## Configuration sample

# Offline install mode: set 'yes' to install offline
OFFLINE_INSTALL=no
#OFFLINE_INSTALL=yes

# Pod network CIDR
POD_NETWORK_CIDR=172.31.0.0/16

# Proxy config
#PROXY_URL=http://proxy.example.com:8080
#NO_PROXY=localhost,127.0.0.1

# Firewall config, set no to disable firewalld.
#ENABLE_FIREWALLD=yes

## For HA cluster config

# load balancer DNS or IP
#LOAD_BALANCER_DNS=
# load balancer PORT
#LOAD_BALANCER_PORT=6443
