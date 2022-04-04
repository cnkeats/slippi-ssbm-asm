################################################################################
# Address: 80377b90
################################################################################
.include "Common/Common.s"
.include "Online/Online.s"

  # Check if Versus mode
  getMinorMajor r7
  cmpwi r7, 0x0202
  beq OverrideInputs
  
  # Check for online modes
  lbz r3, OFST_R13_ONLINE_MODE(r13)
  cmpwi r3, ONLINE_MODE_RANKED
  beq Exit
  cmpwi r3, ONLINE_MODE_UNRANKED
  beq Exit

  getMinorMajor r7
  cmpwi r7, 0x0208
  beq OverrideInputs

  # Check if Playback mode
  cmpwi r7, 0x010E
  beq OverrideInputs

  b Exit

OverrideInputs:
  andi. r0, r0, 0xF3FF
  
Exit:
  stw r0, 0 (r5)



  # 804c1fac player 1
  # 804c1ff0 player 2
  # 804c2034 player 3
  # 804c2078 player 4