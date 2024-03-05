FROM ubuntu:22.04

# Install some tools in the container and generate self-signed SSL certificates.
# Packages are listed in alphabetical order, for ease of readability and ease of maintenance.
RUN	apt update
RUN	apt install -y bash busybox curl ethtool iperf3 iproute2 iputils-ping jq \
                libatomic1 libnuma-dev libpcap-dev nginx pciutils python3 rt-tests tcpdump \
                vim wget

# Copy dpdk and pktgen to /root
ADD dpdk-21.11 /root/dpdk-21.11
ADD Pktgen-DPDK-pktgen-21.11.0 /root/Pktgen-DPDK-pktgen-21.11.0
ENV LD_LIBRARY_PATH=/root/dpdk-21.11/build/lib:/root/dpdk-21.11/build/drivers

# Copy a simple index.html to eliminate text (index.html) noise which comes with default nginx image.
# (I created an issue for this purpose here: https://github.com/nginxinc/docker-nginx/issues/234)
COPY index.html /usr/share/nginx/html/

# Copy a custom/simple nginx.conf which contains directives
#   to redirected access_log and error_log to stdout and stderr.
# Note: Don't use '/etc/nginx/conf.d/' directory for nginx virtual hosts anymore.
#   This 'include' will be moved to the root context in Alpine 3.14.

COPY nginx.conf /etc/nginx/nginx.conf
