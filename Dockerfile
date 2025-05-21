FROM node:18

# Create app directory inside container
WORKDIR /usr/src/app

# Copy all files from host to container
COPY . .

# Install dependencies
RUN npm install

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["node", "server.js"]

