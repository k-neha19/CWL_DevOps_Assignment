# Use the official lightweight Nginx image from Docker Hub.
FROM nginx:stable-alpine

# Copy the custom homepage into Nginx's default web root.
COPY index.html /usr/share/nginx/html/index.html

# Expose container port 80 for web traffic.
EXPOSE 80

# Start Nginx in the foreground so the container keeps running.
CMD ["nginx", "-g", "daemon off;"]
