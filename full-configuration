### BASIC ROUTER CONFURATION
#
{
# SET VARIABLES:BEGIN
:global name=studentnumber value=1
# SET VARIABLES:END
#
# CONFIGURATION:BEGIN
#
## GENERAL
system identity set name="TS$studentnumber"
## WAN
/interface ethernet set name=ether1-wan [find where name=ether1]
/ip dhcp-client add interface=ether1-wan add-default-route=yes default-route-distance=1 disabled=no
/interface list add name=WAN
/interface list member add list=WAN interface=ether1-wan
## DNS
/ip dns set allow-remote-requests=yes
## BRIDGE
/interface bridge
add name=bridge-LAN auto-mac=no admin-mac=[/interface ethernet get value-name=mac-address [find where name~"ether2"]]\
 igmp-snooping=yes fast-forward=yes dhcp-snooping=yes vlan-filtering=yes
### BRIDGE:ENABLE VLAN FILTERING ON BRIDGE
set vlan-filtering=yes [find]
### BRIDGE:PORT
port
:foreach i in=[/interface ethernet find where name!=ether1-wan] do={ /interface bridge port add bridge=bridge-LAN interface=$i};
:foreach i in=[/interface wireless find] do={ /interface bridge port add bridge=bridge-LAN interface=$i};
/interface bridge port set [find] ingress-filtering=yes
## LAN
/interface list add name=LAN
/interface list member add list=LAN interface=bridge-LAN
/ip address add address="172.16.$studentnumber.1/24" interface=bridge-LAN network="172.16.$studentnumber.0"
/ip pool add name=pool-LAN ranges="172.16.$studentnumber.100-172.16.$studentnumber.200"
/ip dhcp-server
add name=DHCP-LAN address-pool=pool-LAN interface=bridge-LAN lease-time=5m add-arp=yes disabled=no
network add address="172.16.$studentnumber.0/24" gateway="172.16.$studentnumber.1"
### LAN:WLAN
/interface wireless
security-profiles add name=WiFiPass authentication-types=wpa2-psk wpa2-pre-shared-key=mysecurewifi mode=dynamic-keys
set name="TS$studentnumber-2" ssid="TS$studentnumber-2" frequency-mode=regulatory-domain country=latvia installation=indoor band=2ghz-b/g/n\
 adaptive-noise-immunity=ap-and-client-mode security-profile=WiFiPass channel-width=20mhz frequency=auto\
 wireless-protocol=802.11 mode=ap-bridge [find where default-name~"wlan" && band~"2ghz" ]
set name="TS$studentnumber-5" ssid="TS$studentnumber-5" frequency-mode=regulatory-domain country=latvia installation=indoor band=5ghz-a/n/ac\
 adaptive-noise-immunity=ap-and-client-mode security-profile=WiFiPass channel-width=20mhz frequency=auto\
 wireless-protocol=802.11 mode=ap-bridge [find where default-name~"wlan" && band~"5ghz" ]
enable [find]
## FIREWALL:BEGIN
### FIREWALL:FILTER
/ip firewall filter
remove [find dynamic=no]
add action=fasttrack-connection chain=input connection-state=established,related
add action=drop chain=input connection-state=invalid
add action=accept chain=input connection-state=established,related
add action=accept chain=input protocol=icmp
add action=drop chain=input in-interface-list=WAN
### FIREWALL:NAT
/ip firewall nat
remove [find dynamic=no]
add chain=srcnat out-interface-list=WAN action=masquerade ipsec-policy=out,none comment=masquerade-internet
add action=redirect chain=dstnat dst-port=53 in-interface-list=LAN protocol=udp to-ports=53
add action=redirect chain=dstnat dst-port=53 in-interface-list=LAN protocol=tcp to-ports=53
## FIREWALL:END
## OTHER SETTINGS
### IP SETTINGS:TCP_SYNCOOKIES
/ip settings set tcp-syncookies=yes
### IP SETTINGS:NEIGHBORS
/ip neighbor discovery-settings
set discover-interface-list=LAN
### CLOCK
/system clock
set time-zone-name=Europe/Riga
### UPNP
/ip upnp
set enabled=yes
interfaces
add interface=bridge-LAN type=internal
add interface=ether1-wan type=external
### MAC-server
/tool mac-server
set allowed-interface-list=LAN
mac-winbox
set allowed-interface-list=LAN
### UPDATE
/system package update set channel=long-term
### FIRMWARE
/system routerboard settings set auto-upgrade=yes
## PASSWORD
/password old-password="" new-password=Myrouter1 confirm-new-password=Myrouter1
#
/
#
#
#
#
### QoS
#
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
#
# Queue types
/queue type
add kind=pcq name=pcq-tvo pcq-burst-rate=512k pcq-burst-threshold=512k pcq-burst-time=15s pcq-classifier=dst-address pcq-rate=256k
add kind=pcq name=pcq-udp pcq-burst-rate=10M pcq-burst-threshold=6M pcq-burst-time=1m pcq-classifier=dst-address pcq-rate=6M
add kind=pcq name=pcq-other pcq-burst-rate=10M pcq-burst-threshold=5M pcq-burst-time=1m pcq-classifier=dst-address pcq-rate=5M
#
#Queue tree
/queue tree
#
#   please change the parent parameter to match your interface name of your bridge or ethernet interface where your LAN is connected to
#
add name=QT-ether1-wan parent=bridge-LAN priority=1 limit-at=10M max-limit=10M comment=parent_queue_tree_item
#
add name=QT-tvo packet-mark=pm_tvo parent=QT-ether1-wan queue=pcq-tvo comment=TVoost_queue_tree_item
add name=QT-udp packet-mark=pm_udp parent=QT-ether1-wan priority=1 queue=pcq-udp comment=UDP_queue_tree_item
add name=QT-other packet-mark=no-mark parent=QT-ether1-wan priority=2 queue=pcq-other comment=Other_traffic_queue_tree_item
#
}
#
