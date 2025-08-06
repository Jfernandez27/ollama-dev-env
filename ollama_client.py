#!/usr/bin/env python3
"""
Cliente Python para interactuar con Ollama durante el desarrollo
Uso: python ollama_client.py
"""

import requests
import json
import sys
from typing import List, Dict, Optional

class OllamaClient:
    def __init__(self, host: str = "localhost", port: int = 11434, model: str = "deepseek-coder:6.7b"):
        self.base_url = f"http://{host}:{port}"
        self.model = model
        
    def is_connected(self) -> bool:
        """Verifica si Ollama está disponible"""
        try:
            response = requests.get(f"{self.base_url}/api/tags", timeout=5)
            return response.status_code == 200
        except:
            return False
    
    def list_models(self) -> List[str]:
        """Lista modelos disponibles"""
        try:
            response = requests.get(f"{self.base_url}/api/tags")
            data = response.json()
            return [model['name'] for model in data.get('models', [])]
        except:
            return []
    
    def generate_code(self, prompt: str, **kwargs) -> Optional[str]:
        """Genera código basado en el prompt"""
        payload = {
            "model": self.model,
            "prompt": prompt,
            "stream": False,
            "options": {
                "temperature": kwargs.get("temperature", 0.2),
                "top_p": kwargs.get("top_p", 0.9),
                "stop": kwargs.get("stop", ["\n\n"])
            }
        }
        
        try:
            response = requests.post(f"{self.base_url}/api/generate", json=payload)
            result = response.json()
            return result.get('response', '')
        except Exception as e:
            print(f"Error generando código: {e}")
            return None
    
    def explain_code(self, code: str, language: str = "") -> Optional[str]:
        """Explica código dado"""
        lang_prefix = f"Explica este código {language}:" if language else "Explica este código:"
        prompt = f"{lang_prefix}\n\n```\n{code}\n```"
        return self.generate_code(prompt)
    
    def review_code(self, code: str, language: str = "") -> Optional[str]:
        """Revisa código y sugiere mejoras"""
        lang_prefix = f"{language} " if language else ""
        prompt = f"Revisa este código {lang_prefix}y sugiere mejoras:\n\n```\n{code}\n```"
        return self.generate_code(prompt)
    
    def generate_tests(self, function_code: str, test_framework: str = "pytest") -> Optional[str]:
        """Genera tests unitarios"""
        prompt = f"Genera tests unitarios usando {test_framework} para esta función:\n\n```\n{function_code}\n```"
        return self.generate_code(prompt)
    
    def debug_code(self, code: str, error_msg: str = "") -> Optional[str]:
        """Ayuda a debuggear código"""
        error_info = f"\n\nError: {error_msg}" if error_msg else ""
        prompt = f"Encuentra y corrige errores en este código:{error_info}\n\n```\n{code}\n```"
        return self.generate_code(prompt)
    
    def refactor_code(self, code: str, goals: str = "mejorar legibilidad y performance") -> Optional[str]:
        """Refactoriza código"""
        prompt = f"Refactoriza este código para {goals}:\n\n```\n{code}\n```"
        return self.generate_code(prompt)
    
    def chat(self, message: str, context: List[Dict] = None) -> Optional[str]:
        """Chat conversacional"""
        if context is None:
            context = []
            
        messages = [
            {"role": "system", "content": "Eres un asistente de programación experto."},
            *context,
            {"role": "user", "content": message}
        ]
        
        payload = {
            "model": self.model,
            "messages": messages,
            "stream": False
        }
        
        try:
            response = requests.post(f"{self.base_url}/api/chat", json=payload)
            result = response.json()
            return result.get('message', {}).get('content', '')
        except Exception as e:
            print(f"Error en chat: {e}")
            return None

def main():
    """Función principal para testing"""
    client = OllamaClient()
    
    print("🔍 Verificando conexión con Ollama...")
    if not client.is_connected():
        print("❌ No se puede conectar a Ollama. Asegúrate de que esté ejecutándose.")
        sys.exit(1)
    
    print("✅ Conexión exitosa!")
    
    # Listar modelos
    models = client.list_models()
    print(f"📋 Modelos disponibles: {models}")
    
    # Ejemplo de generación de código
    print("\n🧠 Generando código...")
    code = client.generate_code("Escribe una función Python que calcule el factorial de un número")
    if code:
        print("💻 Código generado:")
        print(code)
    
    # Ejemplo de explicación
    print("\n📖 Explicando código...")
    sample_code = """
def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quicksort(left) + middle + quicksort(right)
    """
    
    explanation = client.explain_code(sample_code, "Python")
    if explanation:
        print("📝 Explicación:")
        print(explanation)

if __name__ == "__main__":
    main()
