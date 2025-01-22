#!/bin/bash

# Configure Git username and email

git config --global user.name "Chill-Sam"

git config --global user.email "jonathan@wahrenberg.com"



# Generate SSH key

read -p "Enter the file name for the SSH key (default: ~/.ssh/id_ed25519): " ssh_key_file

ssh_key_file=${ssh_key_file:-~/.ssh/id_ed25519}

ssh-keygen -t ed25519 -C "jonathan@wahrenberg.com" -f "$ssh_key_file" -N ""


# Add SSH key to the SSH agent

eval "$(ssh-agent -s)"

ssh-add "$ssh_key_file"



# Display the public key for adding to Git hosting services

echo "Your SSH public key is:"

cat "${ssh_key_file}.pub"



echo "Setup complete. Add the above public key to your Git hosting service."
