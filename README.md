# 🚀 Ollama Development Environment

Optimized development environment for Ollama with GPU support (RTX 3050) and DeepSeek Coder.

## What is Ollama?

Ollama is an open-source project that allows you to run large language models (LLMs) locally. It provides:

-   🔒 **Local Processing**: Run AI models on your own hardware
-   🚀 **High Performance**: Optimized for modern GPUs
-   🎯 **Easy Integration**: Simple REST API for applications
-   📚 **Multiple Models**: Support for various open-source models
-   💻 **Cross-Platform**: Works on Linux, macOS, and Windows

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

### Minimum System Requirements

-   **CPU**: 4+ cores recommended
-   **RAM**: 8GB minimum, 16GB+ recommended
-   **GPU**: NVIDIA GPU with 8GB+ VRAM
-   **Storage**: 20GB+ SSD space
-   **OS**: Linux (Ubuntu 20.04+ recommended)

### System Dependencies

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

## 📚 Model Features and Installation

### Quick Model Selection Guide

Choose the right model based on your needs:

-   **Code Generation & Analysis**: DeepSeek Coder, CodeLlama
-   **General Purpose Tasks**: Llama 2, Mixtral
-   **Lightweight Options**: Phi, Mistral
-   **Chat & Assistance**: Neural Chat

### Available Models

1. **DeepSeek Coder**

    - **Description**: Specialized for code assistance, including generation, explanation, and debugging.
    - **Use Case**: Perfect for developers and language learning.
    - **Versions**: 6.7b, 1.3b
    - **Installation**:
        ```bash
        ./scripts/ollama-dev.sh pull deepseek-coder:6.7b  # Full version
        ./scripts/ollama-dev.sh pull deepseek-coder:1.3b  # Lightweight version
        ```

2. **CodeLlama**

    - **Description**: Versatile model for code tasks across multiple programming languages.
    - **Use Case**: Excellent for code generation, refactoring, and documentation.
    - **Versions**: 34b, 13b, 7b
    - **Installation**:
        ```bash
        ./scripts/ollama-dev.sh pull codellama:34b  # Best performance
        ./scripts/ollama-dev.sh pull codellama:13b  # Balanced performance/resources
        ./scripts/ollama-dev.sh pull codellama:7b   # Lightweight
        ```

3. **Llama 2**

    - **Description**: General-purpose model with strong reasoning capabilities.
    - **Use Case**: Great for writing, analysis, and planning.
    - **Versions**: 70b, 13b, 7b
    - **Installation**:
        ```bash
        ./scripts/ollama-dev.sh pull llama2:70b  # Maximum performance
        ./scripts/ollama-dev.sh pull llama2:13b  # Balanced performance/resources
        ./scripts/ollama-dev.sh pull llama2:7b   # Lightweight
        ```

4. **Mixtral**

    - **Description**: Powerful model with excellent reasoning capabilities.
    - **Use Case**: Perfect for complex tasks and detailed analysis.
    - **Versions**: 8x7b
    - **Installation**:
        ```bash
        ./scripts/ollama-dev.sh pull mixtral  # Base model
        ./scripts/ollama-dev.sh pull mixtral-instruct  # Instruction-optimized
        ```

5. **Phi**

    - **Description**: Compact model with strong performance on technical tasks.
    - **Use Case**: Great for development and technical documentation.
    - **Installation**:
        ```bash
        ./scripts/ollama-dev.sh pull phi
        ```

6. **Mistral**

    - **Description**: Efficient in both general and technical language tasks.
    - **Use Case**: Versatile for various types of tasks.
    - **Installation**:
        ```bash
        ./scripts/ollama-dev.sh pull mistral
        ```

7. **Neural Chat**

    - **Description**: Optimized for conversations and assistance.
    - **Use Case**: Perfect for chatbots and interactive assistance.
    - **Installation**:
        ```bash
        ./scripts/ollama-dev.sh pull neural-chat
        ```

### 💻 System Requirements by Model

#### Hardware Recommendations

-   **Entry Level**: RTX 3060 (8GB VRAM)

    -   Suitable for: Small models (7B), Phi, Mistral
    -   System RAM: 16GB minimum
    -   Storage: 20GB+ SSD

-   **Mid Range**: RTX 3080/3090 (12-24GB VRAM)

    -   Suitable for: Medium models (13B), DeepSeek Coder, CodeLlama 13B
    -   System RAM: 32GB recommended
    -   Storage: 50GB+ SSD

-   **High End**: RTX 4090/A5000 (24GB+ VRAM)
    -   Suitable for: Large models (34B+), Mixtral, Llama 2 70B
    -   System RAM: 64GB recommended
    -   Storage: 100GB+ SSD

#### Model-Specific Requirements

##### Code Models

| Model          | Version | GPU RAM | System RAM | Storage |
| -------------- | ------- | ------- | ---------- | ------- |
| DeepSeek Coder | 6.7b    | 16GB    | 32GB       | 15GB    |
| DeepSeek Coder | 1.3b    | 4GB     | 8GB        | 5GB     |
| CodeLlama      | 34b     | 32GB    | 64GB       | 60GB    |
| CodeLlama      | 13b     | 16GB    | 32GB       | 25GB    |
| CodeLlama      | 7b      | 8GB     | 16GB       | 15GB    |

##### General Purpose Models

| Model   | Version | GPU RAM | System RAM | Storage |
| ------- | ------- | ------- | ---------- | ------- |
| Llama 2 | 70b     | 48GB    | 96GB       | 140GB   |
| Llama 2 | 13b     | 16GB    | 32GB       | 25GB    |
| Llama 2 | 7b      | 8GB     | 16GB       | 15GB    |
| Mixtral | 8x7b    | 24GB    | 48GB       | 45GB    |
| Phi     | base    | 4GB     | 8GB        | 5GB     |
| Mistral | base    | 8GB     | 16GB       | 15GB    |

#### Optimization Tips

1. **Memory Management**:

    - Use quantized versions when available
    - Adjust context length based on needs
    - Close unnecessary applications

2. **Performance Optimization**:

    - Use SSDs for model storage
    - Keep drivers and CUDA updated
    - Monitor GPU temperatures

3. **Resource Allocation**:
    - Set appropriate memory limits in docker-compose.yml
    - Configure GPU utilization in .env
    - Use background processing for large models

### Managing Models

#### List Available Models

```bash
./scripts/ollama-dev.sh models
```

#### Remove a Model

```bash
# Using the API
curl -X DELETE http://localhost:11434/api/delete -d '{"name": "model-name"}'
```

#### Switch Between Models

Update the model name in your API requests or scripts to use the desired model.

#### API Examples

1. **Code Explanation**

```bash
# Ask for code explanation
curl -X POST http://localhost:11434/api/generate \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "deepseek-coder:6.7b",
    "prompt": "Explain this Python code: def fibonacci(n): return n if n <= 1 else fibonacci(n-1) + fibonacci(n-2)",
    "stream": false
  }'
```

2. **General Conversation**

```bash
# Chat with the model
curl -X POST http://localhost:11434/api/generate \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "neural-chat",
    "prompt": "What is machine learning?",
    "stream": true
  }'
```

3. **Code Generation**

```bash
# Generate code based on description
curl -X POST http://localhost:11434/api/generate \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "codellama:13b",
    "prompt": "Write a Python function to sort a list using quicksort",
    "stream": false
  }'
```

**Note**:

-   Use `"stream": true` for real-time responses
-   Use `"stream": false` for complete responses
-   Always include the appropriate headers### Customize resources

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
