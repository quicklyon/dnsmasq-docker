#dnsmasq config, for a complete example, see:
#  http://oss.segetech.com/intra/srv/dnsmasq.conf

# Never forward plain names (without a dot or domain part)
domain-needed

# Never forward addresses in the non-routed address spaces.
bogus-priv

no-resolv
log-queries
log-facility=/var/log/dnsmasq.log
strict-order

#use cloudflare as default nameservers, prefer 1^4
server=/cn/1.2.4.8
server=8.8.8.8
server=1.2.4.8

#serve all .quickon queries using a specific nameserver
server=/quickon/127.0.0.1
#explicitly define host-ip mappings
address=/localhost.quickon/127.0.0.2
