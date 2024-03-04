################################################################################
# Address: 0x802668bc
################################################################################

.include "Common/Common.s"
.include "Online/Online.s"

  # Check if Versus mode CSS
  getMinorMajor r17
  cmpwi r17, 0x0002
  beq EditRules
  
  # Check for online modes
  lbz r17, OFST_R13_ONLINE_MODE(r13)
  cmpwi r17, ONLINE_MODE_RANKED
  beq Exit
  cmpwi r17, ONLINE_MODE_UNRANKED
  beq Exit

  # Check if online mode CSS
  getMinorMajor r17
  cmpwi r17, 0x0008
  beq EditRules

  b Exit

EditRules:
  .set ITEM_RULES_BLOCK, 0x8045C370

  load r17, ITEM_RULES_BLOCK

  load r16, 0xF8FFFF4F
  stw r16,  0x18 (r17) # Random Stage Selection

Exit: