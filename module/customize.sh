#!/system/bin/sh

FLAG=0

if ! [ -x "$(command -v iptables)" ]; then
  ui_print "iptables was not found. This module will not be able to set TTL."
  ui_print "You will need to set TTL on each client device manually to 65."
  FLAG=1
else
  if ! grep -q TTL /proc/net/ip_tables_targets; then
    ui_print "The kernel module to support TTL for iptables was not found."
    ui_print "You will need to set TTL on each client device manually to 65."
    ui_print "Alternatively, you can compile and install the kernel module."
    FLAG=1
  fi
  if ! [ -x "$(command -v ip6tables)" ]; then
    ui_print "ip6tables was not found. This module will not be able to set HL."
    ui_print "You can set HL on each client device manually to 65."
    ui_print "Alternatively, you can disable IPv6 on each client device."
    FLAG=1
  else
    if ! grep -q HL /proc/net/ip6_tables_targets; then
      ui_print "The kernel module to support HL for ip6tables was not found."
    ui_print "You will need to set HL on each client device manually to 65."
    ui_print "Alternatively, you can compile and install the kernel module."
    FLAG=1
    fi
  fi
fi

if [ "${FLAG}" -eq "1" ]; then
  ui_print "Some features will not be available."
else
  ui_print "All features will be available."
fi

ui_print "Restart to activate the module."
