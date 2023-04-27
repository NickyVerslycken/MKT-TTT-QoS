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
