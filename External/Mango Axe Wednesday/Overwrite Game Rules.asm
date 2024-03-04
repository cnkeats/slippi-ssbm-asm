################################################################################
# Address: 8016e750
################################################################################
.include "Common/Common.s"
.include "Online/Online.s"

  # Check if Versus mode
  getMinorMajor r17
  cmpwi r17, 0x0202
  beq EditRules

  # Check if Playback mode
  getMinorMajor r17
  cmpwi r17, 0x010E
  beq EditRules
  
  # Check for online modes
  lbz r17, OFST_R13_ONLINE_MODE(r13)
  cmpwi r17, ONLINE_MODE_RANKED
  beq Exit
  cmpwi r17, ONLINE_MODE_UNRANKED
  beq Exit

  getMinorMajor r17
  cmpwi r17, 0x0208
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

  .set ItemsOff, 0xFF
  .set ItemsVeryLow, 0x00
  .set ItemsLow, 0x01
  .set ItemsMedium, 0x02
  .set ItemsHigh, 0x03
  .set ItemsVeryHigh, 0x04

  load r20, GameInfoBlock
  
  li r18, ItemsHigh
  stb r18, ItemFrequency (r20)

  li r18, 0x78 # 2 minutes
  stw r18, GameTimer (r20)

  load r18, 0xFDFFFBF8
  stw r18, ItemSpawnBitfield1 (r20)

  li r18, 0xFF
  #stb r18, ItemSpawnBitfield2 (r20)
  #stb r18, ItemSpawnBitfield3 (r20)
  #stb r18, ItemSpawnBitfield4 (r20)
  stb r18, ItemSpawnBitfield5 (r20)


Exit:

  lis r4, 0x8017