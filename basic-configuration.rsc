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
}
