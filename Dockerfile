# Usar imagen oficial de Ollama como base
FROM ollama/ollama:latest

# Variables de entorno
ENV DEBIAN_FRONTEND=noninteractive
ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_MODELS=/root/.ollama/models
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

# Configurar timezone
ENV TZ=America/Mexico_City
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Actualizar e instalar dependencias adicionales para desarrollo
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    nodejs \
    npm \
    ca-certificates \
    gnupg \
    lsb-release \
    htop \
    vim \
    jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Crear directorio para modelos con permisos apropiados
RUN mkdir -p /root/.ollama && \
    chmod 755 /root/.ollama

# Crear script de inicialización
COPY init-ollama.sh /root/
RUN chmod +x /root/init-ollama.sh

# Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:11434/api/tags || exit 1

# Exponer puerto
EXPOSE 11434

# Comando por defecto
ENTRYPOINT ["/bin/bash", "/root/init-ollama.sh"]