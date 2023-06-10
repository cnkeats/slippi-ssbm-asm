################################################################################
# Address: 0x802668b0
################################################################################

.include "Common/Common.s"
.include "Online/Online.s"

backup

li r3, 0          # port
li r4, 0          # ?
li r5, 0          # ?
li r6, 60         # duration
branchl r12, 0x80014574

li r3, 1          # port
li r4, 0          # ?
li r5, 0          # ?
li r6, 60         # duration
branchl r12, 0x80014574

li r3, 2          # port
li r4, 0          # ?
li r5, 0          # ?
li r6, 60         # duration
branchl r12, 0x80014574

li r3, 3          # port
li r4, 0          # ?
li r5, 0          # ?
li r6, 60         # duration
branchl r12, 0x80014574

restore

li r3, 0
