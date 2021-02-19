################################################################################
# Address: 800343b4
################################################################################

.include "Common/Common.s"
.include "Online/Online.s"

lbz r5, OFST_R13_ISWINNER(r13)
cmpwi r5, 2
bne Go_To_Pesudo_SuddenDeath_Exit # If the last game wasn't a draw, skip over this.

# Play Warning sfx 
#li r3, 0xbc
#li r4, 127
#li r5, 64
#branchl r12, 0x800237a8 # SFX_PlaySoundAtFullVolume

# Enable bomb rain
li r3, 0xFF
load r4, 0x8046db6e
stb r3, 0(r4)

# Disable item spawning
li r3, 0x00
load r4, 0x8046db73
stb r3, 0(r4)

# Disable timer
li r3, 0x30
load r4, 0x8046db68
stb r3, 0(r4)

# Set stocks to 1
li r3, 0x01
load r4, 0x8045310e # player 1
stb r3, 0(r4)
load r4, 0x80453f9e # player 2
stb r3, 0(r4)

# Set starting percentage to 300
load r0, 0x60
load r30, 0x012C012C

Go_To_Pesudo_SuddenDeath_Exit:
sthx r30, r29, r0
