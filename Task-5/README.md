# Task 5 - Firewall Configuration

## Objective

Harden server network access using UFW by allowing only trusted SSH source, HTTP traffic, and application port `8000`.

## File in This Task

- `firewall_rules.txt` - Firewall setup and verification commands

## Commands

```bash
sudo apt update
sudo apt install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from YOUR_IP to any port 22 proto tcp
sudo ufw allow 80/tcp
sudo ufw allow 8000/tcp
sudo ufw enable
sudo ufw status numbered
sudo ufw status verbose
```

## Command Explanations

- `default deny incoming`: Blocks unsolicited inbound traffic by default.
- `allow from YOUR_IP to any port 22`: Restricts SSH access to one trusted IP.
- `allow 80/tcp`: Allows standard HTTP service.
- `allow 8000/tcp`: Allows custom application port access.
- `ufw enable`: Activates firewall policy.
- `ufw status numbered`: Displays active rules in order.

## Verification Steps

1. Confirm UFW is active:

```bash
sudo ufw status
```

2. Check SSH rule source IP is correct.
3. Validate ports `80` and `8000` are listed as `ALLOW`.
4. From an unauthorized IP, SSH should be blocked.

## Expected Outcome

- Server accepts:
  - SSH only from `YOUR_IP`
  - HTTP traffic on port `80`
  - App traffic on port `8000`
- All other incoming traffic is blocked.
