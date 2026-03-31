# Project-Submission

This repository contains a complete DevOps internship assignment implementation focused on secure server access, containerized deployment, monitoring automation, user-based log protection, and firewall hardening.

## Project Objectives

- Configure secure SSH access with key-based authentication.
- Deploy a Dockerized web application and expose it on port `8000`.
- Automate container CPU and memory monitoring every minute.
- Secure monitoring assets with least-privilege file permissions.
- Configure a firewall to allow only required traffic.

## Repository Structure

```text
Project-Submission/
├── Task-1/
│   ├── README.md
│   └── ssh_setup_commands.txt
├── Task-2/
│   ├── README.md
│   ├── Dockerfile
│   └── index.html
├── Task-3/
│   ├── README.md
│   └── monitor.sh
├── Task-4/
│   ├── README.md
│   └── user_permissions.txt
├── Task-5/
│   ├── README.md
│   └── firewall_rules.txt
└── README.md
```

## Environment

- OS Target: Ubuntu Linux (20.04+)
- Privilege Level: `sudo` access required for installation and system configuration
- Runtime: Docker Engine
- Scheduler: Cron
- Firewall: UFW

## Task Overview

### Task 1 - SSH Setup and Passwordless Access

Installs and configures SSH server, generates client SSH keys, enables key-based login, and disables password authentication.

### Task 2 - Dockerized Web Deployment

Builds and runs an Nginx-based container hosting a custom `index.html`, exposed on `http://<SERVER_IP>:8000`.

### Task 3 - Container Monitoring Automation

Adds a monitoring script that records container CPU and memory usage with timestamps into `/opt/container-monitor/logs/monitor.log`, scheduled every minute using cron.

### Task 4 - User and Permission Hardening

Creates a dedicated monitoring user and locks down `/opt/container-monitor` so only that user can access monitoring files.

### Task 5 - Firewall Configuration

Configures UFW to allow SSH from one trusted IP, allow HTTP (`80`), allow container traffic (`8000`), and block everything else by default.

## Validation Checklist

- SSH key login works without password prompt.
- Web page is reachable on `http://<SERVER_IP>:8000`.
- Monitoring log updates every minute with timestamp, CPU, and memory values.
- Non-privileged users cannot read monitoring logs.
- UFW status reflects only expected allowed ports and source restrictions.

## Notes

- Replace placeholders like `YOUR_SERVER_IP`, `YOUR_USERNAME`, `YOUR_CONTAINER_NAME`, and `YOUR_IP` with actual values from your environment.
- For assignment submission, include screenshots and a walkthrough video link in the task README files if needed.
