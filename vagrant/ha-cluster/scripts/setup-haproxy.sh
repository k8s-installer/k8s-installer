#!/bin/bash

set -euo pipefail

# disable selinux
setenforce Permissive
sed -i "s/^SELINUX=.*$/SELINUX=disabled/" /etc/selinux/config

#yum update -y
#apt-get install -y haproxy
yum install -y haproxy

echo 'net.ipv4.ip_nonlocal_bind=1' >> /etc/sysctl.d/k8s.conf
sysctl -p /etc/sysctl.d/k8s.conf
#grep -q -F 'net.ipv4.ip_nonlocal_bind=1' /etc/sysctl.conf || echo 'net.ipv4.ip_nonlocal_bind=1' >> /etc/sysctl.conf

cat >/etc/haproxy/haproxy.cfg <<EOF
global
	#log /dev/log	local0
	#log /dev/log	local1 notice
	log 127.0.0.1 local2

	chroot /var/lib/haproxy
	pidfile /var/run/haproxy.pid
	maxconn 4000
	user haproxy
	group haproxy
  daemon

	stats socket /var/lib/haproxy/stats
	#stats timeout 30s

	# Default SSL material locations
	ca-base /etc/ssl/certs
	crt-base /etc/ssl/private
	# Default ciphers to use on SSL-enabled listening sockets.
	# For more information, see ciphers(1SSL). This list is from:
	#  https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/
	ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS
	ssl-default-bind-options no-sslv3
	
defaults
	log	global
	mode	tcp
	option	tcplog
	option	dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
	#errorfile 400 /etc/haproxy/errors/400.http
	#errorfile 403 /etc/haproxy/errors/403.http
	#errorfile 408 /etc/haproxy/errors/408.http
	#errorfile 500 /etc/haproxy/errors/500.http
	#errorfile 502 /etc/haproxy/errors/502.http
	#errorfile 503 /etc/haproxy/errors/503.http
	#errorfile 504 /etc/haproxy/errors/504.http

frontend k8s
	bind 192.168.56.40:6443
	default_backend k8s_backend

backend k8s_backend
	balance roundrobin
	mode tcp
	server controller-0 192.168.56.10:6443 check inter 1000
	server controller-1 192.168.56.11:6443 check inter 1000
	server controller-2 192.168.56.12:6443 check inter 1000
EOF

systemctl enable haproxy
systemctl restart haproxy
