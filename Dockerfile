# Docker file for rancher-firewall

FROM alpine
MAINTAINER Ishi Ruy <dev@nhz.io>

RUN apk add -U iproute2

ENV INTERFACE eth0
ENV TCP_PORTS 80,443,8080
ENV UDP_PORTS 500,4500

CMD iptables -F INPUT \
	&& iptables -A INPUT -p tcp -i $INTERFACE -m multiport \! --dports $TCP_PORTS -j DROP \
	&& iptables -A INPUT -p udp -i $INTERFACE -m multiport \! --dports $UDP_PORTS -j DROP
