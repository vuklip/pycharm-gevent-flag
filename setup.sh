#!/bin/bash

set -e  # Exit on error

echo "Starting setup..."

# Install pyenv
echo "Installing pyenv..."
if [ ! -d "$HOME/.pyenv" ]; then
    curl https://pyenv.run | bash

    # Add pyenv to PATH and initialize
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    echo ""
    echo "⚠️  Add the following to your ~/.bashrc or ~/.zshrc:"
    echo 'export PYENV_ROOT="$HOME/.pyenv"'
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"'
    echo 'eval "$(pyenv init -)"'
    echo ""
else
    echo "pyenv already installed"
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Install Poetry
echo "Installing Poetry..."
if ! command -v poetry &> /dev/null; then
    curl -sSL https://install.python-poetry.org | python3 -

    # Add Poetry to PATH
    export PATH="$HOME/.local/bin:$PATH"

    echo ""
    echo "⚠️  Add the following to your ~/.bashrc or ~/.zshrc:"
    echo 'export PATH="$HOME/.local/bin:$PATH"'
    echo ""
else
    echo "Poetry already installed"
    export PATH="$HOME/.local/bin:$PATH"
fi

# Configure Poetry to create virtualenv in project directory
echo "Configuring Poetry to use local .venv..."
poetry config virtualenvs.in-project true

# Install Python 3.11.8
echo "Installing Python 3.11.8 with pyenv..."
pyenv install -s 3.11.8

# Install Python 3.13.7
echo "Installing Python 3.13.7 with pyenv..."
pyenv install -s 3.13.7

# Set local Python version to 3.13.7
echo "Setting local Python version to 3.13.7..."
pyenv local 3.13.7

# Run poetry install
echo "Running poetry install..."
poetry install

# Run poetry run python -V
echo "Checking Python version with poetry..."
poetry run python -V

echo ""
echo "✅ Setup completed successfully!"