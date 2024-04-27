# Stage 1: Build Flutter Project
FROM ghcr.io/cirruslabs/flutter:3.19.6 AS flutter_builder

# Set working directory
WORKDIR /app

# Clone or copy your Flutter project into the container
COPY . .

# Build the web application
RUN flutter build web

# Stage 2: Serve Web Application
FROM nginx:alpine AS web_server

# Set working directory
WORKDIR /usr/share/nginx/html

# Copy built web files from the previous stage
COPY --from=flutter_builder /app/build/web .

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]


