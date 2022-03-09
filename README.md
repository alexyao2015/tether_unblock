# Tether Unblock

Some mobile network operators block tethering. This Magisk Module fixes
TTL values on your phone and disables tethering notification to your
provider.

## How to install:

Stable release:
1. Dowload latest tether_unblock.zip from releases page
   https://github.com/evdenis/tether_unblock/releases
2. MagiskManager -> Modules + Downloads/tether_unblock.zip -> Reboot

Master branch:
1. git clone https://github.com/evdenis/tether_unblock
2. cd tether_unblock
3. make install

## Support

- [Telegram](https://t.me/joinchat/GsJfBBaxozXvVkSJhm0IOQ)


# TODO

Figure out how to operate tc with pedit to modify outbound ttl


netsh int ipv4 set global defaultcurhoplimit=65
netsh int ipv6 set global defaultcurhoplimit=65

iptables -t mangle -A POSTROUTING -j TTL --ttl-set 64
ip6tables -t mangle -A POSTROUTING -j HL --hl-set 64

resetprop net.tethering.noprovisioning true