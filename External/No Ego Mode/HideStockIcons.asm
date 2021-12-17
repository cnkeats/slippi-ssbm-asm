################################################################################
# Address: 802f9994
################################################################################
.include "Common/Common.s"
.include "Online/Online.s"

  # Check if Versus mode
  getMinorMajor r7
  cmpwi r7, 0x0202
  #bne Exit
  beq SkipStockGX
  
  # Check for online modes
  lbz r3, OFST_R13_ONLINE_MODE(r13)
  #cmpwi r3, ONLINE_MODE_UNRANKED
  #beq Exit
  cmpwi r3, ONLINE_MODE_DIRECT
  beq SkipStockGX
  b Exit
  #cmpwi r3, ONLINE_MODE_TEAMS
  #beq Exit
  #cmpwi r3, ONLINE_MODE_RANKED
  #beq Exit

  #getMinorMajor r7
  #cmpwi r7, 0x0208
  #beq SkipStockGX

SkipStockGX:
  branchl r12, 0x802F99AC
  
Exit:
  lis r3, 0x8030