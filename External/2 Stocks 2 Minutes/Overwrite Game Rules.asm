################################################################################
# Address: 8016e91c
################################################################################
.include "Common/Common.s"
.include "Online/Online.s"

  # Check if Versus mode
  getMinorMajor r7
  cmpwi r7, 0x0202
  beq EditRules
  
  # Check for online modes
  lbz r3, OFST_R13_ONLINE_MODE(r13)
  cmpwi r3, ONLINE_MODE_RANKED
  beq Exit
  cmpwi r3, ONLINE_MODE_UNRANKED
  beq Exit

  getMinorMajor r7
  cmpwi r7, 0x0208
  beq EditRules

  # Check if Playback mode
  cmpwi r7, 0x010E
  beq EditRules

  b Exit

EditRules:
  li r3, 0x2 # 2 Stocks

  load r4, 0x8045310e # Player 1's starting stocks
  stb r3, 0(r4)
  
  load r4, 0x80453f9e # Player 2's starting stocks
  stb r3, 0(r4)
  
  load r4, 0x80454e2e # Player 3's starting stocks
  stb r3, 0(r4)
  
  load r4, 0x80455cbe # Player 4's starting stocks
  stb r3, 0(r4)

Exit:
  lwz r0, 0x0024(sp)
