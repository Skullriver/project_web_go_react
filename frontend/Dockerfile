# Use an official Node runtime as a parent image
FROM node:16.3.0-alpine3.13

# Set the working directory to /app
WORKDIR /frontend-app

# Copy the current directory contents into the container at /app
COPY . /frontend-app

# Install any needed packages
RUN npm install

# Build the React application
RUN npm run build

# Expose port 3000
EXPOSE 3000

# Run the React application when the container starts
CMD ["npm", "start"]
