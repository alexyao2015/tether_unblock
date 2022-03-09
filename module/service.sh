#!/system/bin/sh

settings put global tether_dun_required 0

if [ -x "$(command -v iptables)" ] && grep -q TTL /proc/net/ip_tables_targets; then
	iptables -t mangle -A POSTROUTING -j TTL --ttl-set 64
fi

if [ -x "$(command -v ip6tables)" ] && grep -q HL /proc/net/ip6_tables_targets; then
	ip6tables -t mangle -A POSTROUTING -j HL --hl-set 64
fi
