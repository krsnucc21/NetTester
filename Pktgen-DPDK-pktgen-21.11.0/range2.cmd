range 0 dst mac start 12:22:97:eb:54:2f
range 0 src mac start 12:00:c1:fa:ca:91

range 0 dst ip start 10.0.0.170
range 0 dst ip inc 0.0.0.0
range 0 dst ip min 10.0.0.170
range 0 dst ip max 10.0.0.170

range 0 src ip start 10.0.0.235
range 0 src ip inc 0.0.0.0
range 0 src ip min 10.0.0.235
range 0 src ip max 10.0.0.235

range 0 proto udp

range 0 dst port start 20000
range 0 dst port inc 1
range 0 dst port min 20000
range 0 dst port max 30000

range 0 src port start 50000
range 0 src port inc 1
range 0 src port min 50000
range 0 src port max 60000

range 0 vlan start 0

range 0 size start 1500
range 0 size inc 1
range 0 size min 1500
range 0 size max 1500

set 0 rate 15
enable 0 range
