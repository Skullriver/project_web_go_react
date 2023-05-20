# Use an official PostgreSQL runtime as a parent image
FROM postgres:13.3-alpine

# Set the environment variables for the PostgreSQL container
ENV POSTGRES_USER ps3r
ENV POSTGRES_PASSWORD ps3r2023
ENV POSTGRES_DB bets_ratp

# Copy the SQL script to create the database schema
COPY mydump.sql /docker-entrypoint-initdb.d/

# Expose port 5432
EXPOSE 5432
