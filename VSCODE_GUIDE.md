# 🚀 Guide: Using Ollama with VS Code for Development

## 📋 **Completed Configuration**

Your workspace is already configured with:

-   ✅ Automatic extension setup
-   ✅ Optimized settings for Ollama
-   ✅ Ready-to-use REST API examples
-   ✅ Test scripts in Python and Node.js

## 🔧 **Configuration by Extension**

### **AI Toolkit (Microsoft)**

```json
{
    "ai-toolkit.models.preferredLocation": "/home/jesus/llms/models",
    "ai-toolkit.enableModelBrowser": true,
    "ai-toolkit.defaultProvider": "local"
}
```

### **REST Client**

-   **Ollama Autocoder** (`10nates.ollama-autocoder`): Autocompletion with local models
-   **Twinny** (`rjmacarthy.twinny`): Chat and code assistance
-   **Open Copilot** (`rickyang.ocopilot`): Alternative to GitHub Copilot
-   **Local AI Pilot** (`nr-codetools.localaipilot`): Local AI for development
-   **Cody** (`sourcegraph.cody-ai`): Intelligent code assistant
-   **AI Toolkit** (`ms-windows-ai-studio.windows-ai-studio`): Visual model management and AI app development

### **Support Extensions:**

-   **Docker** (`ms-azuretools.vscode-docker`): Container management
-   **Remote Containers** (`ms-vscode-remote.remote-containers`): Development in containers
-   **YAML** (`redhat.vscode-yaml`): Support for YAML files

## 🎯 **How to Use Each Tool**

### 1. **REST Client (Direct Testing)**

-   Open `api-tests.http`
-   Click "Send Request" on any example
-   View responses in real-time

### 2. **AI Autocompletion**

-   Start writing code
-   Press `Ctrl+Space` for suggestions
-   Accept with `Tab` or `Enter`

### 3. **Chat with DeepSeek Coder**

-   Open Command Palette (`Ctrl+Shift+P`)
-   Search for "Twinny" or "Chat"
-   Ask questions about code

### 4. **Code Analysis**

-   Select code
-   Right-click → "Explain with AI" or "Review with AI"
-   View immediate suggestions

## 💡 **Practical Use Cases**

### **Frontend Development**

```javascript
// Write this and request autocompletion:
function validateForm(
// The model will complete with validations
```

### **Backend Development**

```python
# Select this code and request a review:
def process_users(users):
    result = []
    for i in range(len(users)):
        if users[i]['active']:
            result.append(users[i])
    return result
```

### **SQL and Databases**

```sql
-- Request optimization for this query:
SELECT * FROM users u, orders o
WHERE u.id = o.user_id AND u.active = 1
```

### **Debugging**

```python
# Request help to find the error:
def calculate_average(numbers):
    total = 0
    for i in range(len(numbers) + 1):  # Error here
        total += numbers[i]
    return total / len(numbers)
```

## 🚀 **Integrated Terminal Commands**

```bash
# Test connection
python ollama_client.py

# Generate specific code
curl -X POST http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{"model": "deepseek-coder:6.7b", "prompt": "Your prompt here"}'

# View Ollama logs
./scripts/ollama-dev.sh logs

# Service status
./scripts/ollama-dev.sh status
```

## ⚡ **Useful Keyboard Shortcuts**

-   `Ctrl+Shift+P` → Command Palette
-   `Ctrl+Space` → Manual autocompletion
-   `F1` → Extension help
-   `Ctrl+`` → Integrated terminal
-   `Ctrl+Shift+E` → File explorer

## 🎨 **Advanced Customization**

### Change default model:

```json
// In .vscode/settings.json
"ollama-autocoder.model": "deepseek-coder:1.3b", // For less RAM
"twinny.fimModel": "codellama:7b"  // For another model
```

### Adjust temperature:

```json
"ollama-autocoder.temperature": 0.1  // More deterministic
```

### Configure custom prompts:

-   Edit settings in `settings.json`
-   Create new examples in `api-tests.http`

## 🔥 **Professional Tips**

1. **Use specific context**: Instead of "write a function," say "write a Python function that processes user data from a REST API"

2. **Gradual iteration**: Request specific improvements like "optimize performance" or "add error handling"

3. **Combine tools**: Use REST Client for testing, then autocompletion for implementation

4. **Leverage chat**: For complex questions about architecture or design patterns

## 🐛 **Troubleshooting**

### If autocompletion doesn't work:

```bash
# Verify Ollama is running
./scripts/ollama-dev.sh status

# Verify model is downloaded
./scripts/ollama-dev.sh models
```

### If there are connection errors:

-   Check that port 11434 is open
-   Restart Ollama: `./scripts/ollama-dev.sh stop && ./scripts/ollama-dev.sh start`

### To improve speed:

-   Use smaller models for autocompletion
-   Set low temperature (0.1-0.3)
-   Limit maximum tokens

---

You're all set! Start writing code and experiment with AI suggestions. 🎉
