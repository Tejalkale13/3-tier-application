#!/bin/bash

# Create the main project directory
mkdir -p my-app/{backend,frontend}

# Create docker-compose.yml
cat << 'EOF' > my-app/docker-compose.yml
version: '3.8'

services:
  db:
    image: postgres:13
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data

  backend:
    build: ./backend
    ports:
      - "5000:5000"
    depends_on:
      - db
    environment:
      - FLASK_ENV=development
    volumes:
      - ./backend:/app

  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    depends_on:
      - backend
    volumes:
      - ./frontend:/app
      - /app/node_modules
    environment:
      - WATCHPACK_POLLING=true
      - WDS_SOCKET_PORT=0
    command: npm start

volumes:
  db_data:
EOF

echo "Project setup completed successfully!"
