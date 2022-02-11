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
  andi. r0, r0, 0x1E08

  load r15, 0x00000000
  load r16, 0x804c1fd4 # Player 1 C-stick X
  stw r15, 0(r16)
  load r16, 0x804c1fd8 # Player 1 C-stick Y
  stw r15, 0(r16)
  load r16, 0x804c1fdc # Player 1 L-Trigger
  stw r15, 0(r16)
  load r16, 0x804c1fe0 # Player 1 R-Trigger
  stw r15, 0(r16)

  load r16, 0x804c2018  # Player 2 C-stick X
  stw r15, 0(r16)
  load r16, 0x804c201c  # Player 2 C-stick Y
  stw r15, 0(r16)
  load r16, 0x804c2020  # Player 2 L-Trigger
  stw r15, 0(r16)
  load r16, 0x804c2024  # Player 2 R-Trigger
  stw r15, 0(r16)

  load r16, 0x804c205c  # Player 3 C-Stick X
  stw r15, 0(r16)
  load r16, 0x804c2060  # Player 3 C-Stick Y
  stw r15, 0(r16)
  load r16, 0x804c2064  # Player 3 L-Trigger
  stw r15, 0(r16)
  load r16, 0x804c2068  # Player 3 R-Trigger
  stw r15, 0(r16)

  load r16, 0x804c20a0  # Player 4 C-Stick X
  stw r15, 0(r16)
  load r16, 0x804c20a4  # Player 4 C-Stick Y
  stw r15, 0(r16)
  load r16, 0x804c20a8  # Player 4 L-Trigger
  stw r15, 0(r16)
  load r16, 0x804c20ac  # Player 4 R-Trigger
  stw r15, 0(r16)
  
Exit:
  stw r0, 0 (r5)



  # 804c1fac player 1
  # 804c1ff0 player 2
  # 804c2034 player 3
  # 804c2078 player 4