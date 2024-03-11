FROM ubuntu:22.04

# Install some tools in the container and generate self-signed SSL certificates.
# Packages are listed in alphabetical order, for ease of readability and ease of maintenance.
RUN	apt update
RUN	apt install -y bash busybox curl ethtool iperf3 iproute2 iputils-ping jq \
                libatomic1 libnuma-dev libpcap-dev nginx pciutils python3 rt-tests tcpdump \
                vim wget

# Build dpdk
ARG DPDK_VERSION=21.11
ARG DPDK_STUFF=dpdk-$DPDK_VERSION.tar.xz
ARG DPDK_HOME=/dpdk

RUN     apt install -y build-essential ca-certificates libnuma-dev python3-pip python3-pyelftools \
                python3-setuptools xz-utils \
     && pip3 install meson ninja \
     && wget --quiet http://fast.dpdk.org/rel/$DPDK_STUFF \
     && mkdir --parents $DPDK_HOME \
     && tar --extract --file=$DPDK_STUFF --directory=$DPDK_HOME --strip-components 1

RUN cd $DPDK_HOME && meson build && ninja -C build && ninja -C build install && ldconfig

ENV RTE_SDK=$DPDK_HOME

# Build pktgen
ADD Pktgen-DPDK-pktgen-21.11.0 /root/Pktgen-DPDK-pktgen-21.11.0

RUN cd /root/Pktgen-DPDK-pktgen-21.11.0 && make

# Copy a simple index.html to eliminate text (index.html) noise which comes with default nginx image.
COPY index.html /usr/share/nginx/html/

# Copy a custom/simple nginx.conf which contains directives
#   to redirected access_log and error_log to stdout and stderr.

COPY nginx.conf /etc/nginx/nginx.conf
