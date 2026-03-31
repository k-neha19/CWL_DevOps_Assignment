# Task 1 - Server Setup and SSH Configuration

## Objective

Configure secure remote access to an Ubuntu server using SSH key-based authentication and disable password-based SSH login.

## Prerequisites

- Ubuntu server with `sudo` privileges
- Client machine with SSH installed
- Network connectivity between client and server

## Step-by-Step Commands

Run on the **server**:

```bash
sudo apt update
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
sudo systemctl status ssh --no-pager
```

Run on the **client**:

```bash
ssh-keygen -t ed25519 -C "devops-assignment-key"
ssh-copy-id YOUR_USERNAME@YOUR_SERVER_IP
ssh YOUR_USERNAME@YOUR_SERVER_IP
```

Run on the **server** to harden SSH:

```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PubkeyAuthentication .*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl reload ssh
sudo sshd -T | grep -E 'passwordauthentication|pubkeyauthentication'
```

## Command Explanations

- `apt update`: Refreshes package metadata from configured repositories.
- `apt install -y openssh-server`: Installs SSH server daemon.
- `systemctl enable ssh`: Ensures SSH starts automatically after reboot.
- `systemctl start ssh`: Starts SSH service immediately.
- `ssh-keygen`: Creates private/public key pair for secure login.
- `ssh-copy-id`: Appends local public key to server's authorized keys.
- `sed` updates: Enforces secure SSH auth settings in `sshd_config`.
- `sshd -T`: Prints effective SSH configuration for verification.

## Expected Output

- `systemctl status ssh` shows `active (running)`.
- SSH login works without password prompt after key setup.
- `sshd -T` output includes:
  - `passwordauthentication no`
  - `pubkeyauthentication yes`

## Relevant File

- Commands list: `ssh_setup_commands.txt`
