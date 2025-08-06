# 🚀 Ollama Development Environment

Optimized development environment for Ollama with GPU support (RTX 3050) and DeepSeek Coder.

This project was created as an experiment to explore and optimize workflows for working with large language models (LLMs) locally. By leveraging Docker and NVIDIA GPU acceleration, it ensures high performance and seamless integration with modern development workflows. Whether you're building AI-powered applications, experimenting with LLMs, or contributing to open-source AI projects, this environment has you covered.

## 📋 Features

-   ✅ Full support for NVIDIA RTX 3050 GPU
-   ✅ Pre-installed DeepSeek Coder for code assistance
-   ✅ Included web interface (Open WebUI) for easy interaction
-   ✅ Development script with useful commands for managing services
-   ✅ Optimized configuration for development and testing
-   ✅ Configured health checks and logging for reliability
-   ✅ Non-root user for enhanced security
-   ✅ REST API examples for quick integration
-   ✅ VS Code integration for a seamless coding experience

## 🌟 Why Use This Environment?

1. **Performance**: Harness the power of NVIDIA GPUs to accelerate LLM tasks.
2. **Ease of Use**: Pre-configured scripts and settings reduce setup time.
3. **Flexibility**: Supports a wide range of LLMs, including DeepSeek Coder and CodeLlama.
4. **Scalability**: Easily extendable to include additional models or services.
5. **Security**: Built with best practices to ensure a secure development environment.

## 🔧 Prerequisites

### System

-   Docker >= 20.10
-   Docker Compose >= 2.0
-   NVIDIA Container Toolkit
-   jq (for JSON processing)
-   At least 8GB of available RAM
-   RTX 3050 or compatible GPU

### Installing dependencies

```bash
# Ubuntu/Debian
sudo apt update && sudo apt install -y docker.io docker-compose jq

# Install NVIDIA Container Toolkit
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
  sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update && sudo apt install -y nvidia-container-toolkit
sudo systemctl restart docker
```

### Verify GPU

```bash
nvidia-smi
docker run --rm --gpus all nvidia/cuda:12.1-base-ubuntu22.04 nvidia-smi
```

## 🚀 Quick Start

### 1. Clone and configure

```bash
git clone https://github.com/Jfernandez27/ollama-dev-env.git
cd ollama-dev-env
# The .env file is already configured with default values
# Edit it if you need to adjust specific settings
```

### 2. Start services

```bash
# Option 1: Direct Docker Compose
docker-compose up -d

# Option 2: Development script (recommended)
./scripts/ollama-dev.sh start
```

### 3. Verify installation

```bash
./scripts/ollama-dev.sh status
```

## 🎯 Usage

### Accessing services

-   **Ollama API**: http://localhost:11434
-   **Web UI**: http://localhost:3000
-   **API Health**: http://localhost:11434/api/tags

### Development commands

#### Help script

```bash
./scripts/ollama-dev.sh help
```

#### Main commands

```bash
# Start services
./scripts/ollama-dev.sh start

# Check status
./scripts/ollama-dev.sh status

# Interactive chat
./scripts/ollama-dev.sh chat

# Analyze code
./scripts/ollama-dev.sh code file.py

# View logs
./scripts/ollama-dev.sh logs

# GPU information
./scripts/ollama-dev.sh gpu

# Stop services
./scripts/ollama-dev.sh stop
```

### Using DeepSeek Coder

#### REST API

```bash
curl http://localhost:11434/api/generate \
  -d '{
    "model": "deepseek-coder:6.7b",
    "prompt": "Explain this Python code: def fibonacci(n): return n if n <= 1 else fibonacci(n-1) + fibonacci(n-2)",
    "stream": false
  }'
```

#### Interactive chat

```bash
./scripts/ollama-dev.sh chat
```

#### File analysis

```bash
./scripts/ollama-dev.sh code my_script.py
```

## 📂 Project Structure

```
llms/
├── docker-compose.yml      # Main configuration
├── Dockerfile             # Custom image
├── .env                   # Environment variables
├── .dockerignore          # Excluded files
├── init-ollama.sh         # Initialization script
├── README.md             # This documentation
├── scripts/
│   └── ollama-dev.sh     # Development script
├── models/               # Local models (optional)
└── volumes/
    └── ollama-data/      # Persistent data
```

## ⚙️ Advanced Configuration

### Environment variables (.env)

```env
# GPU Configuration
NVIDIA_VISIBLE_DEVICES=all
NVIDIA_DRIVER_CAPABILITIES=compute,utility

# Resource Limits
MEMORY_LIMIT=8G

# Ollama Configuration
OLLAMA_HOST=0.0.0.0
OLLAMA_MODELS=/home/ollama/.ollama/models
```

### Available models

```bash
# List installed models
./scripts/ollama-dev.sh models

# Install specific model
./scripts/ollama-dev.sh pull deepseek-coder:1.3b
./scripts/ollama-dev.sh pull codellama:7b
./scripts/ollama-dev.sh pull llama2:7b
```

### Customize resources

Edit `docker-compose.yml`:

```yaml
deploy:
    resources:
        limits:
            memory: 16G # Adjust according to available RAM
```

## 🔍 Troubleshooting

### Missing dependencies

```bash
# Error: jq is not installed
sudo apt install -y jq

# Error: docker-compose not found
sudo apt install -y docker-compose

# Error: nvidia-smi not found
sudo apt install -y nvidia-driver-535  # or the latest version
```

### GPU not detected

```bash
# Verify NVIDIA Docker
docker run --rm --gpus all nvidia/cuda:12.1-base-ubuntu22.04 nvidia-smi

# Reinstall NVIDIA Container Toolkit if necessary
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
```

### Insufficient memory

```bash
# Use a smaller model
./scripts/ollama-dev.sh pull deepseek-coder:1.3b

# Adjust limits in docker-compose.yml
```

### Port already in use

```bash
# Check ports in use
netstat -tulpn | grep -E ':(11434|3000)'

# Change ports in docker-compose.yml if necessary
```

### Debugging logs

```bash
# View detailed logs
./scripts/ollama-dev.sh logs

# View logs for a specific container
docker logs ollama-dev -f
```

## 🔧 Development

### Add new models

1. Edit `init-ollama.sh`
2. Add `ollama pull <model>` command
3. Rebuild image: `docker-compose build`

### Customize development script

Edit `scripts/ollama-dev.sh` to add custom commands.

### IDE Integration

#### VS Code

Install extensions:

-   REST Client (to test API)
-   Docker (for container management)

Workspace configuration (`.vscode/settings.json`):

```json
{
    "rest-client.environmentVariables": {
        "local": {
            "baseUrl": "http://localhost:11434"
        }
    }
}
```

## 📊 Monitoring

### GPU metrics

```bash
# Real-time monitoring
watch -n 1 'docker exec ollama-dev nvidia-smi'

# Memory usage
docker stats ollama-dev
```

### Health Checks

Containers include automatic health checks:

```bash
docker ps  # View health status
```

## 🛡️ Security

### Best practices implemented

-   ✅ Non-root user in container
-   ✅ Configured resource limits
-   ✅ Structured logging
-   ✅ Environment variables in a separate file
-   ✅ Health checks for availability

### For production

```bash
# Change secrets in .env
WEBUI_SECRET_KEY=your-random-secure-key

# Use specific bind mounts instead of volumes
# Configure firewall for exposed ports
# Consider reverse proxy (nginx)
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes
4. Test with `./scripts/ollama-dev.sh`
5. Submit PR

## 📝 Changelog

### v1.0.0

-   ✅ Initial setup with GPU support
-   ✅ Pre-installed DeepSeek Coder
-   ✅ Development script
-   ✅ Complete documentation
-   ✅ Integrated Open WebUI

## 📄 License

MIT License - see LICENSE file for details.

---

**Issues?** Open an issue in the repository or check the troubleshooting section.
