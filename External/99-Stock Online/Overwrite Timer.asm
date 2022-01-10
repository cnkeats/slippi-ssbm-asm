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

  getMinorMajor r7
  cmpwi r7, 0x0208
  beq EditRules
  b Exit

  b Exit

EditRules:

  load r20, 0x80480530 # Game Bitfield 1
  load r18, 0x3001864c # Originally 0x3201864C - change last byte to change timer setting
  stw r18, 0 (r20)

Exit:
  lis r4, 0x8017