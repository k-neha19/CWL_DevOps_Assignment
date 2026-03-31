# Task 2 - Docker Installation and Web Deployment

## Objective

Install Docker on Ubuntu, containerize a custom web page using Nginx, and expose the application on port `8000`.

## Files in This Task

- `index.html` - Custom web page content
- `Dockerfile` - Container image build instructions

## Step-by-Step Commands

Install Docker on Ubuntu server:

```bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker --no-pager
```

Build and run the container:

```bash
cd Task-2
sudo docker build -t custom-nginx-web:1.0 .
sudo docker run -d --name custom-web -p 8000:80 custom-nginx-web:1.0
sudo docker ps
```

## Command Explanations

- `docker build -t ... .`: Builds image from `Dockerfile` in current directory.
- `docker run -d --name ... -p 8000:80 ...`: Runs container in background and maps host port `8000` to container port `80`.
- `docker ps`: Verifies container is running.

## Expected Output

- Docker service should show `active (running)`.
- `docker ps` should list container `custom-web` with port mapping `0.0.0.0:8000->80/tcp`.
- Web page should open in browser:

```text
http://YOUR_SERVER_IP:8000
```

## Verification

```bash
curl http://localhost:8000
```

You should receive the HTML content defined in `index.html`.
