#!/usr/bin/env python3
"""
Ejemplo de código Python para probar DeepSeek Coder
Ejecutar: ./scripts/ollama-dev.sh code examples/example.py
"""

def fibonacci(n):
    """Calcula la secuencia de Fibonacci de forma recursiva (ineficiente)"""
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

def fibonacci_optimized(n):
    """Versión optimizada con memoización"""
    memo = {}
    
    def fib_helper(x):
        if x in memo:
            return memo[x]
        if x <= 1:
            result = x
        else:
            result = fib_helper(x-1) + fib_helper(x-2)
        memo[x] = result
        return result
    
    return fib_helper(n)

class DataProcessor:
    def __init__(self, data):
        self.data = data
        self.processed = False
    
    def process(self):
        # TODO: Implementar procesamiento real
        self.processed = True
        return len(self.data)
    
    def validate(self):
        if not self.data:
            raise ValueError("No data to validate")
        return all(isinstance(x, (int, float)) for x in self.data)

if __name__ == "__main__":
    # Ejemplo de uso
    processor = DataProcessor([1, 2, 3, 4, 5])
    
    print(f"Fibonacci recursivo de 10: {fibonacci(10)}")
    print(f"Fibonacci optimizado de 10: {fibonacci_optimized(10)}")
    
    if processor.validate():
        result = processor.process()
        print(f"Datos procesados: {result} elementos")
