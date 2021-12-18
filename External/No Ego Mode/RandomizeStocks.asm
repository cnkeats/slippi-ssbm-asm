################################################################################
# Address: 8016e91c
################################################################################
.include "Common/Common.s"
.include "Online/Online.s"

  # Check if Versus mode
  getMinorMajor r7
  cmpwi r7, 0x0202
  beq RandomizeStocks
  
  # Check Online modes
  lbz r3, OFST_R13_ONLINE_MODE(r13)
  cmpwi r3, ONLINE_MODE_DIRECT
  beq RandomizeStocks

  # Check if Playback mode
  cmpwi r7, 0x010E
  beq RandomizeStocks

  b Exit
  
RandomizeStocks:
  li r3, 6
  branchl r12, HSD_Randi
  addi r3, r3, 1
  load r4, 0x8045310E # Player 1's starting stocks
  stb r3, 0(r4)
  
  li r3, 6
  branchl r12, HSD_Randi
  addi r3, r3, 1
  load r4, 0x80453F9E # Player 2's starting stocks
  stb r3, 0(r4)
    
  li r3, 6
  branchl r12, HSD_Randi
  addi r3, r3, 1
  load r4, 0x80454E2E # Player 3's starting stocks
  stb r3, 0(r4)
    
  li r3, 6
  branchl r12, HSD_Randi
  addi r3, r3, 1
  load r4, 0x80455CBE # Player 4's starting stocks
  stb r3, 0(r4)

Exit:
  lwz r0, 0x0024(sp)
