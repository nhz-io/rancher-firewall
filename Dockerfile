# Docker file for rancher-firewall

FROM alpine
MAINTAINER Ishi Ruy <dev@nhz.io>

RUN apk add -U iproute2

CMD iptables -F INPUT \
	&& iptables -P INPUT ACCEPT \
	&& iptables -P FORWARD ACCEPT \
	&& iptables -P OUTPUT ACCEPT \
	&& iptables -A INPUT \! -i eth0 -j ACCEPT \
	&& iptables -A INPUT -i docker0 -j ACCEPT \
	&& iptables -A INPUT -i lo -j ACCEPT \
	&& iptables -A INPUT -i eth0 -m state --state ESTABLISHED -j ACCEPT \
	&& iptables -A INPUT -p tcp -i eth0 -m multiport \! --dports 22,80,443,8080 -j DROP \
	&& iptables -A INPUT -p udp -i eth0 -m multiport \! --dports 500,4500 -j DROP \
    	&& while true; do sleep 86400; done
