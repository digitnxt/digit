#!/bin/bash

# Exit on error
set -e

echo "Setting up Google Cloud CLI locally..."

# Check if running on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS..."
    
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Install Google Cloud SDK
    echo "Installing Google Cloud SDK..."
    brew install --cask google-cloud-sdk

    # Initialize gcloud
    echo "Initializing gcloud..."
    gcloud init --no-browser

    # Install kubectl
    echo "Installing kubectl..."
    brew install kubectl

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Detected Linux..."
    
    # Add Google Cloud SDK repository
    echo "Adding Google Cloud SDK repository..."
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

    # Add Google Cloud public key
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

    # Update and install
    sudo apt-get update && sudo apt-get install -y \
        google-cloud-sdk \
        kubectl

    # Initialize gcloud
    echo "Initializing gcloud..."
    gcloud init --no-browser
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi

# Verify installation
echo "Verifying Google Cloud CLI installation..."
gcloud version
kubectl version --client

# Configure authentication
echo "Configuring authentication..."
echo "Please follow these steps to authenticate:"
echo "1. Go to the Google Cloud Console (https://console.cloud.google.com)"
echo "2. Create a new project or select an existing one"
echo "3. Enable the following APIs:"
echo "   - Compute Engine API"
echo "   - Kubernetes Engine API"
echo "4. Create a service account:"
echo "   - Go to IAM & Admin > Service Accounts"
echo "   - Click 'Create Service Account'"
echo "   - Give it a name and description"
echo "   - Grant it the following roles:"
echo "     - Compute Admin"
echo "     - Kubernetes Engine Admin"
echo "5. Create a key for the service account:"
echo "   - Click on the service account"
echo "   - Go to 'Keys' tab"
echo "   - Click 'Add Key' > 'Create new key'"
echo "   - Choose JSON format"
echo "   - Download the key file"
echo ""
echo "Once you have the service account key file, run:"
echo "gcloud auth activate-service-account --key-file=PATH_TO_KEY_FILE.json"
echo ""
echo "Then set your project:"
echo "gcloud config set project YOUR_PROJECT_ID"

# Set default project (if provided)
if [ ! -z "$1" ]; then
    echo "Setting default project to $1..."
    gcloud config set project "$1"
fi

echo "Google Cloud CLI setup completed successfully!"
echo "Next steps:"
echo "1. Follow the authentication steps above"
echo "2. Once authenticated, you can create the GPU instance with:"
echo "   gcloud compute instances create llama-server ..." 