# address rules
/ip firewall address-list
add address=176.58.30.0/24 list=addrl-TVO comment=TVoost-non-live-content-streaming-servers
add address=93.123.38.0/24 list=addrl-TVO comment=TVoost-live-content-streaming-servers
add address=176.58.31.0/24 list=addrl-TVO comment=TVoost-live-content-streaming-servers
#
# mangle rules
/ip firewall mangle
# add connection mark for TVoost traffic
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-list=addrl-TVO\
log=yes log-prefix=cm_tvo new-connection-mark=cm_tvo passthrough=yes dst-port=!53 dst-address=!255.255.255.255\
comment=Connections-mark_to_TVoost
# add connection mark for UDP traffic
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-list=!addrl-TVO\
log=yes log-prefix=cm_udp new-connection-mark=cm_udp passthrough=yes protocol=udp comment=Connection-mark_for_other_udp_traffic
#  add packet mark for TVoost traffic
add action=mark-packet chain=prerouting connection-mark=cm_tvo log=yes log-prefix=pm_tvo\
new-packet-mark=pm_tvo passthrough=yes comment=Packet-mark_for_TVoost
# add connection mark for UDP traffic
add action=mark-packet chain=prerouting connection-mark=cm_udp log=yes log-prefix=pm_udp\
new-packet-mark=pm_udp passthrough=yes comment=Packet-mark_for_UDP_traffic
