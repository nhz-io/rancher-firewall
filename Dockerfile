# Docker file for rancher-firewall

FROM alpine
MAINTAINER Ishi Ruy <dev@nhz.io>

RUN apk add -U iproute2

CMD \
	iptables -t mangle -A PREROUTING -i eth0 -m tcp -p tcp -m multiport \! --dports 22,80,443,8080 -j DROP \
	&& iptables -t mangle -A PREROUTING -i eth0 -m udp -p udp -m multiport \! --dports 500,4500 -j DROP \
    	&& while true; do sleep 86400; done
