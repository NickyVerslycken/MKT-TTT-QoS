# MKT-TTT-QoS - Mikrotik 1h QoS training

## Configuration files:
> Only use them when you are short on time or as gideline when you are configuring your router by yourself.
 -  reset-configuration:
    - command to reset your router to no defaults
 -  basic-configuration:
    - You can use that for loading a basic configuration in your router if you want but a normal basic router setup works perfect aswell for this lab.
    - Tackle it:
      - Connect your computer with your router on ether1.
      - Reset to no default configuratin so it's completely empty.
      - Copy the script from the file "basic-configuration" and past it in the terminal of your router.
      - When it's fully deployed disconnect from ether1 and connect you computer to ether2.
      - Connect ether1 to the internet RJ45 connection in your desk.
 -  firewall-rules:
     - This are the rules you will inplement in the address list and the mangle rules in your configuration.
 -  firewall-rules-extended:
     - This rules are an extension for the address list, you don't need them to implement but that are subnets of more streaming servers of the same company.
 -  queue-items
     - This is the configuration for the Queue type's and the Queue tree
 -  full-configuration:
    - You can use that for loading all the configuration at once. (only use if realy necessary)
    - Tackle it:
      - Connect your computer with your router on ether1.
      - Reset to no default configuratin so it's completely empty.
      - Copy the script from the file "basic-configuration" and past it in the terminal of your router.
      - When it's fully deployed disconnect from ether1 and connect you computer to ether2.
      - Connect ether1 to the internet RJ45 connection in your desk.   

----------------------------------------------------------------------------

## Course outline:

| **time** | **Part of course** |
| --- | --- |
| 15 minutes | Theory |
| 30 minutes | Practice lab |
| 10 minutes | play time / quistions & answers |
| 5 minutes | Quiz |


----------------------------------------------------------------------------

## Practice outline:

1.  Reset your router to a default router configuration.
2.  Add the firewall address list items.
3.  Add the firewall mangel rules for the connection marks.
4.  Add the firewall mangle rules for the packet marks.
4.  Add the Queue type items.
5.  Add the Queue tree items.
5.  test the streaming on this url: https://t.ly/UpcKv and watch the bandwidth being used and the quality of the stream.
6.  do some other stuff like opening a video on youtube, browsing the web and watch your Queue tree trough what queue the traffic flows.
    You can leave the videostream open.

** Extra **

7.  Adjust the bandwitdh of the correct Queue type to create a fluid low quality video stream on the TVoost website and tell me your findings.


