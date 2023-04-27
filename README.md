# MKT-TTT-QoS
Mikrotik 1h QoS training

Configuration files:
 -  Basic configuration:
    - you can use that for loading a basic configuration in your router if you want but a normal basic router setup works perfect aswell for this lab
    - tackle it:
      - connect your computer with your router on ether1
      - reset to no default configuratin so it's completely empty
      - copy the script from the file "basic-configuration" and past it in the terminal of your router
      - when it's fully deployed disconnect from ether1 and connect you computer to ether2
      - connect ether1 to the internet RJ45 connection in your desk

----------------------------------------------------------------------------

Practice outline:

1.  Reset your router to a default router configuration
2.  Add the firewall address list items
3.  Add the firewall mangel rules for the connection marks
4.  Add the firewall mangle rules for the packet marks
4.  Add the Queue type items
5.  Add the Queue tree items
5.  test the streaming on this url: https://t.ly/UpcKv and watch the bandwidth being used and the quality of the stream
6.  do some other stuff like opening a video on youtube, browsing the web and watch your Queue tree trough what queue the traffic flows

* Extra

7.  Adjust the bandwitdh of the correct Queue type to create a fluid low quality video streem on the TVoost website


