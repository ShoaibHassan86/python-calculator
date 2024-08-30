# python-calculator
Python calculator on Jupiter notebook via dev container docker file. 

To create a Python calculator in a Jupyter Notebook using a Dev Container with Docker, you'll need to follow these steps:

### 1. **Create a Project Directory**

Create a new directory for your project and navigate into it:

```bash
mkdir python-calculator
cd python-calculator
```

### 2. **Create the Dev Container Configuration**

Inside the project directory, create the following files:

#### **`Dockerfile`**
This file will define the environment for your Dev Container.

```Dockerfile
# Use the official Python base image
FROM python:3.11-slim

# Install required packages
RUN apt-get update && apt-get install -y \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter
RUN pip install notebook

# Set the working directory
WORKDIR /workspace

COPY calculator.ipynb .

# Expose the port for Jupyter Notebook
EXPOSE 8888

# Start Jupyter Notebook server
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
```

#### **`.devcontainer/devcontainer.json`**
This file configures the Dev Container settings for Visual Studio Code.

```json
{
    "name": "Python Calculator",
    "dockerFile": "../Dockerfile",
    "context": "..",
    "workspaceFolder": "/workspace",
    "runArgs": ["--rm", "-p", "8888:8888"],
    "extensions": [
        "ms-python.python",
        "ms-azuretools.vscode-docker"
    ],
    "settings": {
        "python.pythonPath": "/usr/local/bin/python3"
    },
    "postCreateCommand": "pip install --upgrade pip"
}
```

### 3. **Create the Python Calculator Script**

Inside the `python-calculator` directory, create a simple Python calculator script:

#### **`calculator.ipynb`**
This will be your Jupyter Notebook file. You can create this file using Jupyter Notebook directly or add the code through the notebook interface.

Example content:

```python
# Basic Calculator Functions

def add(x, y):
    return x + y

def subtract(x, y):
    return x - y

def multiply(x, y):
    return x * y

def divide(x, y):
    if y == 0:
        return "Cannot divide by zero"
    return x / y

# Example Usage
print("Select operation:")
print("1. Add")
print("2. Subtract")
print("3. Multiply")
print("4. Divide")

choice = input("Enter choice(1/2/3/4): ")

num1 = float(input("Enter first number: "))
num2 = float(input("Enter second number: "))

if choice == '1':
    print(f"{num1} + {num2} = {add(num1, num2)}")
elif choice == '2':
    print(f"{num1} - {num2} = {subtract(num1, num2)}")
elif choice == '3':
    print(f"{num1} * {num2} = {multiply(num1, num2)}")
elif choice == '4':
    print(f"{num1} / {num2} = {divide(num1, num2)}")
else:
    print("Invalid Input")
```

### 4. **Build and Run the Docker Container**

To build and run the container, follow these steps:

1. **Build the Docker Image:**

   From the `python-calculator` directory, run the following command to build the Docker image:

   ```bash
   docker build -t python-calculator .
   ```

2. **Run the Docker Container:**

   Run the container with the following command:

   ```bash
   docker run -p 8888:8888 python-calculator
   ```

3. **Access the Jupyter Notebook:**

   Once the container is running, you can access the Jupyter Notebook by opening your web browser and navigating to:

   ```
   http://localhost:8888/
   ```

   You'll need to enter the token provided in the terminal to access the notebook interface.

### 5. **Develop in the Dev Container**

If you're using Visual Studio Code, you can open the project in a Dev Container by using the "Remote - Containers" extension. This allows you to work within the same environment defined in your Dockerfile and devcontainer.json, ensuring consistency across development environments.

### Summary
This setup allows you to create and run a Python calculator within a Jupyter Notebook using a Dev Container managed by Docker. You can easily extend this project with additional features or libraries as needed.