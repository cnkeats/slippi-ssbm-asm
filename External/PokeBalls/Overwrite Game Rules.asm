################################################################################
# Address: 8000c160
################################################################################
.include "Common/Common.s"
.include "Online/Online.s"
.include "Recording/Recording.s"

  # Check if in an online in-game scene. If not, don't run the code
  getMinorMajor r7
  cmpwi r7, SCENE_ONLINE_IN_GAME
  bne Exit

  # If in ranked or unranked, don't run the code
  lbz r7, OFST_R13_ONLINE_MODE(r13)
  cmpwi r7, ONLINE_MODE_RANKED
  beq Exit
  cmpwi r7, ONLINE_MODE_UNRANKED
  beq Exit

  # This is a jank injection location because we need to run this after InitOnlinePlay but
  # before SendGameInfo. We are injecting here to hijack a function call from SendGameInfo.

  # This should check if we are in StartMelee by looking for the return loc in the stack.
  # This means we will actually run the settings override multiple times including when
  # we don't really need to but I don't think it's going to break anything. As long
  # as it happens the one time we need it, that's all that matters.
  lwz r7, 0x104(r1)
  load r8, 0x8016e94c
  cmpw r7, r8
  bne Exit

  # For every other online mode (direct, teams), run the code

EditRules:

  .set GameInfoBlock, 0x80480530
  .set GameBitfield1, 0x0
  .set GameBitfield2, 0x1
  .set GameBitfield3, 0x2
  .set GameBitfield4, 0x3
  .set MatchFlags, 0x5
  .set BombRain, 0x6
  .set IsTeams, 0x8
  .set ItemFrequency, 0xB
  .set SelfDestructScore, 0xC
  .set Stage, 0xF
  .set GameTimer, 0x10
  .set ItemSpawnBitfield1, 0x23
  .set ItemSpawnBitfield2, 0x24
  .set ItemSpawnBitfield3, 0x25
  .set ItemSpawnBitfield4, 0x26
  .set ItemSpawnBitfield5, 0x27
  .set DamageRatio, 0x30

  .set ItemsOff, 0xFF
  .set ItemsVeryLow, 0x00
  .set ItemsLow, 0x01
  .set ItemsMedium, 0x02
  .set ItemsHigh, 0x03
  .set ItemsVeryHigh, 0x04
  .set ItemsStupidHigh, 0x06
  
  .set PlayerBlockStart, GameInfoBlock + 0x60
  .set PlayerBlockWidth, 0x24
  .set PlayerExternalCharacterId, 0x0
  .set PlayerType, 0x1
  .set PlayerStockCount, 0x2
  .set CostumeIndex, 0x3
  .set TeamShade, 0x7
  .set Handish, 0x8
  .set TeamId, 0x9
  .set PlayerBitfield, 0xC
  .set CPULevel, 0xF
  .set DamageStart, 0x10
  .set DamageSpawn, 0x12
  .set OffenseRatio, 0x18
  .set DefenseRatio, 0x1C
  .set ModelScale, 0x20
  
  .set Player1Block, PlayerBlockStart + (0 * PlayerBlockWidth)
  .set Player2Block, PlayerBlockStart + (1 * PlayerBlockWidth)
  .set Player3Block, PlayerBlockStart + (2 * PlayerBlockWidth)
  .set Player4Block, PlayerBlockStart + (3 * PlayerBlockWidth)

  load r4, GameInfoBlock
  
  li r3, ItemsMedium
  stb r3, ItemFrequency (r4)
    
  load r3, 0x04000000
  stw r3, ItemSpawnBitfield1 (r4)

  li r3, 0x00
  stb r3, ItemSpawnBitfield5 (r4)

Exit:
  cmpwi r4, 0 # replaced code line