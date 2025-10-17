FROM debian:12-slim

RUN apt-get update && apt-get install -y \
    nmap \
    curl \
    dnsutils \
    iputils-ping \
    openssh-client \
    telnet \
    && rm -rf /var/lib/apt/lists/*

# comando padrão para manter o contêiner rodando
CMD ["sleep", "infinity"]
