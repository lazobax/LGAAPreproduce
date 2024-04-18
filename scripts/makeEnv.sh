#!/bin/bash

# Function to create a Conda environment from a YAML file
create_env_from_yaml() {
    yaml_file="$1"
    env_name=$(basename "$yaml_file" .yaml)
    echo "Creating environment from $yaml_file"
    mamba env create -n "$env_name" --file "$yaml_file" -y
}

# Check if mamba is installed
if ! command -v mamba &> /dev/null; then
    echo "Mamba is not installed. Please install mamba and try again."
    exit 1
fi

# Check if YAML files folder is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <yaml_files_folder>"
    exit 1
fi

yaml_folder="$1"

# Check if YAML files folder exists
if [ ! -d "$yaml_folder" ]; then
    echo "Error: YAML files folder '$yaml_folder' not found."
    exit 1
fi

# Loop through YAML files in the folder and create environments
for yaml_file in "$yaml_folder"/*.yaml; do
    create_env_from_yaml "$yaml_file"
done

echo "All environments created successfully."
