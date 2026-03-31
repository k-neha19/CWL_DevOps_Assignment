# Task 4 - Dedicated User and Permission Management

## Objective

Secure monitoring artifacts by assigning them to a dedicated user and restricting access for all other users.

## File in This Task

- `user_permissions.txt` - Commands for user creation and ACL hardening

## Commands

```bash
sudo useradd -m -s /bin/bash monitoruser
sudo passwd monitoruser
sudo mkdir -p /opt/container-monitor/logs
sudo chown -R monitoruser:monitoruser /opt/container-monitor
sudo chmod 700 /opt/container-monitor
sudo chmod 700 /opt/container-monitor/logs
sudo touch /opt/container-monitor/logs/monitor.log
sudo chmod 600 /opt/container-monitor/logs/monitor.log
sudo usermod -aG docker monitoruser
```

## Command Explanations

- `useradd -m -s /bin/bash monitoruser`: Creates a dedicated local user with home directory.
- `chown -R monitoruser:monitoruser ...`: Grants ownership of monitoring path to dedicated user.
- `chmod 700`: Directory is accessible only by owner.
- `chmod 600`: Log file is readable/writable only by owner.
- `usermod -aG docker monitoruser`: Allows `monitoruser` to run `docker` commands without `sudo` (needed for cron monitoring).

## Verification Steps

Check ownership and permissions:

```bash
ls -ld /opt/container-monitor /opt/container-monitor/logs
ls -l /opt/container-monitor/logs/monitor.log
```

Test access as monitoring user:

```bash
sudo -u monitoruser ls -la /opt/container-monitor/logs
```

Test access as non-privileged user (expected denial):

```bash
sudo -u nobody ls -la /opt/container-monitor/logs
```

## Expected Outcome

- `monitoruser` has full control over `/opt/container-monitor`.
- Other users cannot view or modify monitoring logs.
