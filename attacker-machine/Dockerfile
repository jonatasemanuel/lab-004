FROM debian:12-slim

# Instala as ferramentas essenciais sem perguntar "sim/não"
# e depois limpa o cache para manter a imagem pequena
RUN apt-get update && apt-get install -y \
    nmap \
    curl \
    dnsutils \
    iputils-ping \
    openssh-client \
    telnet \
    && rm -rf /var/lib/apt/lists/*

# Comando padrão para manter o contêiner rodando
CMD ["sleep", "infinity"]
