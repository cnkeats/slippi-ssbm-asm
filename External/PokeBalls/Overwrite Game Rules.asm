################################################################################
# Address: 8016e750
################################################################################
.include "Common/Common.s"
.include "Online/Online.s"

  # Check if Versus mode
  getMinorMajor r17
  cmpwi r17, 0x0202
  beq EditRules
  
  # Check for online matchmaking modes
  lbz r17, OFST_R13_ONLINE_MODE(r13)
  cmpwi r17, ONLINE_MODE_RANKED
  beq Exit
  cmpwi r17, ONLINE_MODE_UNRANKED
  beq Exit
  
  # Check for other online modes
  getMinorMajor r17
  cmpwi r17, 0x0208
  beq EditRules

  # Check if Playback mode
  cmpwi r17, 0x010E
  beq EditRules

  b Exit

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

  load r20, GameInfoBlock
  
  li r18, ItemsStupidHigh
  stb r18, ItemFrequency (r20)
	
  load r18, 0x04000000
  stw r18, ItemSpawnBitfield1 (r20)

  li r18, 0x00
  stb r18, ItemSpawnBitfield5 (r20)

Exit:
  lis r4, 0x8017
