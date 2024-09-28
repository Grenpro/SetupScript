netsh interface ipv4 set dnsservers Ethernet static 1.1.1.1 primary

netsh interface ipv4 set dnsservers Wi-Fi static 1.1.1.1 primary

netsh interface ipv4 add dnsservers Ethernet 8.8.8.8 index=2

netsh interface ipv4 add dnsservers Wi-Fi 8.8.8.8 index=2

netsh interface ipv6 set dnsservers Ethernet static 2606:4700:4700::1111 primary

netsh interface ipv6 set dnsservers Wi-Fi static 2606:4700:4700::1111 primary

netsh interface ipv6 add dnsservers Ethernet 2001:4860:4860::8888 index=2

netsh interface ipv6 add dnsservers Wi-Fi 2001:4860:4860::8888 index=2

exit
