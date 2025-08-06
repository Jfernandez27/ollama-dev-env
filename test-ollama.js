#!/usr/bin/env node

/**
 * Script de prueba para la integración de Ollama con VS Code
 * Ejecutar: node test-ollama.js
 */

const http = require('http');

const OLLAMA_HOST = 'localhost';
const OLLAMA_PORT = 11434;
const MODEL = 'deepseek-coder:6.7b';

async function testOllamaConnection() {
    console.log('🔍 Probando conexión con Ollama...');

    try {
        // Test de conectividad
        const models = await makeRequest('/api/tags');
        console.log('✅ Conexión exitosa!');
        console.log(
            '📋 Modelos disponibles:',
            models.models.map((m) => m.name)
        );

        // Test de generación de código
        console.log('\n🧠 Probando generación de código...');
        const codeGeneration = await makeRequest('/api/generate', 'POST', {
            model: MODEL,
            prompt: 'Escribe una función JavaScript que valide un email',
            stream: false,
        });

        console.log('💻 Código generado:');
        console.log(codeGeneration.response);

        // Test de explicación de código
        console.log('\n📖 Probando explicación de código...');
        const explanation = await makeRequest('/api/generate', 'POST', {
            model: MODEL,
            prompt: 'Explica este código: const arr = [1,2,3]; const doubled = arr.map(x => x * 2);',
            stream: false,
        });

        console.log('📝 Explicación:');
        console.log(explanation.response);
    } catch (error) {
        console.error('❌ Error:', error.message);
        process.exit(1);
    }
}

function makeRequest(path, method = 'GET', data = null) {
    return new Promise((resolve, reject) => {
        const options = {
            hostname: OLLAMA_HOST,
            port: OLLAMA_PORT,
            path: path,
            method: method,
            headers: {
                'Content-Type': 'application/json',
            },
        };

        const req = http.request(options, (res) => {
            let body = '';

            res.on('data', (chunk) => {
                body += chunk;
            });

            res.on('end', () => {
                try {
                    const jsonResponse = JSON.parse(body);
                    resolve(jsonResponse);
                } catch (e) {
                    reject(new Error('Respuesta no válida'));
                }
            });
        });

        req.on('error', (error) => {
            reject(error);
        });

        if (data) {
            req.write(JSON.stringify(data));
        }

        req.end();
    });
}

// Función para autocompletado de código (ejemplo)
async function getCodeCompletion(prompt) {
    try {
        const response = await makeRequest('/api/generate', 'POST', {
            model: MODEL,
            prompt: prompt,
            stream: false,
            options: {
                temperature: 0.2,
                top_p: 0.9,
                stop: ['\n\n', '//'],
            },
        });

        return response.response;
    } catch (error) {
        console.error('Error en autocompletado:', error);
        return null;
    }
}

// Función para chat interactivo
async function chatWithModel(message, context = []) {
    try {
        const messages = [
            {
                role: 'system',
                content:
                    'Eres un asistente de programación experto en múltiples lenguajes.',
            },
            ...context,
            { role: 'user', content: message },
        ];

        const response = await makeRequest('/api/chat', 'POST', {
            model: MODEL,
            messages: messages,
            stream: false,
        });

        return response.message.content;
    } catch (error) {
        console.error('Error en chat:', error);
        return null;
    }
}

// Ejecutar tests
if (require.main === module) {
    testOllamaConnection();
}

module.exports = {
    getCodeCompletion,
    chatWithModel,
    makeRequest,
};
