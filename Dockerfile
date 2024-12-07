# Step 1: Build the React Vite app
FROM node:18 AS build

WORKDIR /app

# Copy package.json and package-lock.json (if present)
COPY package*.json ./

# Install dependencies
RUN rm -rf node_modules package-lock.json && \
    npm install

# Copy the rest of the app
COPY . .

# Build the app for production
RUN npm run build

# Install a simple server for serving static content
RUN npm install -g serve

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["serve", "-s", "dist", "-l", "3000"]