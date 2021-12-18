################################################################################
# Address: 802f9994
################################################################################
.include "Common/Common.s"
.include "Online/Online.s"

  # Check if Versus mode
  getMinorMajor r7
  cmpwi r7, 0x0202
  beq SkipStockGX
  
  # Check Online modes
  lbz r3, OFST_R13_ONLINE_MODE(r13)
  cmpwi r3, ONLINE_MODE_DIRECT
  beq SkipStockGX

  # Check if Playback mode
  cmpwi r7, 0x010E
  beq RandomizeStocks

  b Exit

SkipStockGX:
  branchl r12, 0x802F99AC
  
Exit:
  lis r3, 0x8030