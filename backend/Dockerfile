# Use an official Golang runtime as a parent image
FROM golang:1.20.2

# Set the working directory to /backend-app
WORKDIR /backend-app

# Copy the current directory contents into the container at /backend-app
COPY . /backend-app

# Install any needed packages specified in go.mod
RUN go mod download

# Build the Go application
RUN go build -o main .

# Expose port 8080
EXPOSE 8080

# Run the Go application when the container starts
ENTRYPOINT ["./main"]
