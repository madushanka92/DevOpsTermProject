# Use a specific Node.js version
FROM node:18

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache git

# Copy package.json and package-lock.json
COPY package*.json ./

# Clear npm cache and force reinstall dependencies
RUN npm cache clean --force && \
    rm -rf node_modules package-lock.json && \
    npm install

# Copy the rest of the project files
COPY . .

# Build the application
RUN npm run build

# Install serve to run the production build
RUN npm install -g serve

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["serve", "-s", "dist", "-l", "3000"]