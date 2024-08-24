# Use the official Rust image as a base
FROM rust:latest

# Set the working directory
WORKDIR /app

# Install necessary dependencies
RUN apt-get update && apt-get install -y git curl

# Install Diesel CLI
RUN cargo install diesel_cli --no-default-features --features mysql

# Copy the source code
COPY . .

# Build the Rust application
RUN cargo build --release

# Expose the port that your Rust server will run on
EXPOSE 8080

# Command to run migrations and then start your Rust server
CMD ["sh", "-c", "diesel migration run && ./target/release/coal-hq-server"]
