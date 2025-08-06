#!/bin/bash

# Script de ayuda para desarrollo con Ollama y DeepSeek Coder

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función de ayuda
show_help() {
    echo -e "${BLUE}🚀 Ollama Development Helper${NC}"
    echo ""
    echo -e "${YELLOW}Uso:${NC} $0 [comando]"
    echo ""
    echo -e "${YELLOW}Comandos disponibles:${NC}"
    echo "  start     - Iniciar Ollama con DeepSeek Coder"
    echo "  stop      - Detener servicios"
    echo "  logs      - Ver logs en tiempo real"
    echo "  status    - Ver estado de los servicios"
    echo "  models    - Listar modelos disponibles"
    echo "  pull      - Descargar un modelo específico"
    echo "  chat      - Iniciar chat con DeepSeek Coder"
    echo "  code      - Analizar código con DeepSeek Coder"
    echo "  gpu       - Ver información de GPU"
    echo "  clean     - Limpiar contenedores y volúmenes"
    echo "  help      - Mostrar esta ayuda"
    echo ""
    echo -e "${YELLOW}Ejemplos:${NC}"
    echo "  $0 start"
    echo "  $0 pull deepseek-coder:1.3b"
    echo "  $0 chat"
    echo "  $0 code archivo.py"
}

# Verificar si Docker está corriendo
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        echo -e "${RED}❌ Docker no está corriendo${NC}"
        exit 1
    fi
}

# Iniciar servicios
start_services() {
    echo -e "${GREEN}🚀 Iniciando Ollama con soporte GPU...${NC}"
    docker-compose up -d
    echo -e "${GREEN}✅ Servicios iniciados${NC}"
    echo -e "${BLUE}📊 Accede a:${NC}"
    echo "  - API: http://localhost:11434"
    echo "  - Web UI: http://localhost:3000"
}

# Detener servicios
stop_services() {
    echo -e "${YELLOW}🛑 Deteniendo servicios...${NC}"
    docker-compose down
    echo -e "${GREEN}✅ Servicios detenidos${NC}"
}

# Ver logs
view_logs() {
    docker-compose logs -f ollama
}

# Ver estado
show_status() {
    echo -e "${BLUE}📊 Estado de los servicios:${NC}"
    docker-compose ps
    echo ""
    echo -e "${BLUE}🔧 Modelos disponibles:${NC}"
    docker-compose exec ollama ollama list 2>/dev/null || echo "Ollama no está corriendo"
}

# Listar modelos
list_models() {
    echo -e "${BLUE}🔧 Modelos disponibles:${NC}"
    docker-compose exec ollama ollama list
}

# Descargar modelo
pull_model() {
    if [ -z "$1" ]; then
        echo -e "${RED}❌ Especifica el nombre del modelo${NC}"
        echo -e "${YELLOW}Ejemplo:${NC} $0 pull deepseek-coder:1.3b"
        return 1
    fi
    echo -e "${GREEN}📦 Descargando modelo: $1${NC}"
    docker-compose exec ollama ollama pull "$1"
}

# Chat con DeepSeek Coder
start_chat() {
    echo -e "${GREEN}💬 Iniciando chat con DeepSeek Coder...${NC}"
    echo -e "${YELLOW}Escribe 'exit' para salir${NC}"
    docker-compose exec ollama ollama run deepseek-coder:6.7b
}

# Analizar código
analyze_code() {
    if [ -z "$1" ]; then
        echo -e "${RED}❌ Especifica el archivo de código${NC}"
        echo -e "${YELLOW}Ejemplo:${NC} $0 code archivo.py"
        return 1
    fi
    
    if [ ! -f "$1" ]; then
        echo -e "${RED}❌ Archivo no encontrado: $1${NC}"
        return 1
    fi
    
    echo -e "${GREEN}🔍 Analizando código: $1${NC}"
    
    # Leer el archivo y enviarlo a DeepSeek Coder
    code_content=$(cat "$1")
    prompt="Analiza este código y sugiere mejoras:\n\n\`\`\`\n${code_content}\n\`\`\`"
    
    curl -s http://localhost:11434/api/generate \
        -d "{\"model\":\"deepseek-coder:6.7b\",\"prompt\":\"${prompt}\",\"stream\":false}" \
        | jq -r '.response' 2>/dev/null || echo "Error: Asegúrate de que Ollama esté corriendo"
}

# Ver información de GPU
show_gpu_info() {
    echo -e "${BLUE}🎮 Información de GPU:${NC}"
    docker-compose exec ollama nvidia-smi 2>/dev/null || echo "No se detectó GPU NVIDIA o nvidia-smi no disponible"
}

# Limpiar todo
clean_all() {
    echo -e "${YELLOW}🧹 Limpiando contenedores y volúmenes...${NC}"
    docker-compose down -v
    docker system prune -f
    echo -e "${GREEN}✅ Limpieza completada${NC}"
}

# Verificar dependencias
check_dependencies() {
    check_docker
    
    if ! command -v docker-compose > /dev/null; then
        echo -e "${RED}❌ docker-compose no está instalado${NC}"
        exit 1
    fi
    
    if ! command -v jq > /dev/null; then
        echo -e "${YELLOW}⚠️ jq no está instalado (opcional para análisis de código)${NC}"
    fi
}

# Main
main() {
    check_dependencies
    
    case "${1:-help}" in
        start)
            start_services
            ;;
        stop)
            stop_services
            ;;
        logs)
            view_logs
            ;;
        status)
            show_status
            ;;
        models)
            list_models
            ;;
        pull)
            pull_model "$2"
            ;;
        chat)
            start_chat
            ;;
        code)
            analyze_code "$2"
            ;;
        gpu)
            show_gpu_info
            ;;
        clean)
            clean_all
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            echo -e "${RED}❌ Comando desconocido: $1${NC}"
            show_help
            exit 1
            ;;
    esac
}

main "$@"
