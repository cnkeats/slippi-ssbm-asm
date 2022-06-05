################################################################################
# Address: 80023ffc
################################################################################
.include "Common/Common.s"

  getMinorMajor r17
  cmpwi r17, 0x0202
  beq MuteMusic

  li r4, 127
  b Exit

MuteMusic:
  li r4, 0

Exit:
  