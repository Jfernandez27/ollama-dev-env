#!/bin/bash

echo "🚀 Iniciando Ollama para desarrollo..."

# Iniciar Ollama en background
ollama serve &
OLLAMA_PID=$!

# Esperar a que Ollama esté listo
echo "⏳ Esperando a que Ollama esté listo..."
sleep 5
while ! curl -s http://localhost:11434/api/tags > /dev/null; do
    echo "Esperando Ollama..."
    sleep 2
done

echo "✅ Ollama está listo!"

# Verificar si DeepSeek Coder ya está instalado
if ! ollama list | grep -q "deepseek-coder"; then
    echo "📦 Descargando DeepSeek Coder (esto puede tomar un tiempo)..."
    ollama pull deepseek-coder:6.7b
    echo "✅ DeepSeek Coder descargado!"
else
    echo "✅ DeepSeek Coder ya está disponible"
fi

echo "🎯 Modelos disponibles:"
ollama list

echo "🔧 Para usar DeepSeek Coder, ejecuta:"
echo "   curl http://localhost:11434/api/generate -d '{\"model\":\"deepseek-coder:6.7b\",\"prompt\":\"Explain this code:\"}'"

echo "🌐 Ollama Web UI disponible en: http://localhost:11434"
echo "📊 GPU Info:"
nvidia-smi --query-gpu=name,memory.total,memory.used --format=csv,noheader,nounits 2>/dev/null || echo "No se detectó GPU NVIDIA"

# Mantener el proceso principal vivo
wait $OLLAMA_PID
