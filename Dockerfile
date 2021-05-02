# Stage 0: Start with a squashed fully updated ubuntu:20.04
# This is created seperately.
FROM ubuntu:14.04

# Ensure apt doesn't ask any questions 
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# Build/install gvm (by default, everything installs in /usr/local)
#COPY src/build-setup.sh /build-setup.sh
RUN apt update && \
    apt install -y ssh  sudo netbase iproute2
RUN useradd scannable && \
    echo "scannable  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers && \
    echo "scannable:Passw0rd" | chpasswd  && \
    echo "service ssh start" >> /entrypoint.sh && \
    echo "ip a" >> /entrypoint.sh && \
    echo "/bin/bash -c \"sleep 2h\"" >> /entrypoint.sh && \
    chmod 755 /entrypoint.sh
WORKDIR /mnt
ENTRYPOINT [ "/bin/bash" ]
CMD [ "/entrypoint.sh" ]

