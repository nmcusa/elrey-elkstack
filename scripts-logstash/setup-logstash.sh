#!/bin/bash

# Configuration Block
ELASTICSEARCH_HOST="10.2.0.199:9200"
LOG_PATH="/var/log/*.log"
# Elasticsearch Authentication - Uncomment if needed
# ES_USER="your_elasticsearch_username"
# ES_PASSWORD="your_elasticsearch_password"
MANUAL_MODE=0 # Set to 1 for manual mode

# Function to check if a command exists
command_exists () {
    type "$1" &> /dev/null ;
}

# Function for installing Logstash
install_logstash () {
    echo "Checking for Logstash..."
    if command_exists logstash; then
        echo "Logstash is already installed. Skipping installation."
    else
        echo "Logstash not found. Installing..."
        sudo apt-get update && sudo apt-get install logstash -y
    fi
}

# Function to configure Logstash
configure_logstash () {
    echo "Configuring Logstash..."
    LogstashConfig='/etc/logstash/conf.d/logstash-forwarder.conf'
    if [ -f "$LogstashConfig" ]; then
        echo "Logstash configuration already exists. Skipping configuration."
    else
        sudo bash -c "cat > $LogstashConfig" << EOF
input {
  file {
    path => "$LOG_PATH"
    start_position => "beginning"
    ignore_older => 0
  }
}

output {
  elasticsearch {
    hosts => ["$ELASTICSEARCH_HOST"]
    index => "logstash-%{+YYYY.MM.dd}"
    $(if [ -n "$ES_USER" ] && [ -n "$ES_PASSWORD" ]; then echo "user => \"$ES_USER\""; echo "password => \"$ES_PASSWORD\""; fi)
  }
}
EOF
    fi
}

# Function to start Logstash
start_logstash () {
    echo "Starting Logstash..."
    sudo systemctl enable logstash
    sudo systemctl start logstash
    echo "Logstash started successfully."
}

# Main script execution
if [ "$MANUAL_MODE" -eq 0 ]; then
    echo "Running in automatic mode..."
    # Pre-requisites
    echo "Installing necessary packages..."
    sudo apt-get update
    sudo apt-get install -y apt-transport-https openjdk-11-jdk wget
    echo "Importing Elasticsearch PGP Key..."
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    echo "Adding Elasticsearch repository..."
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list

    # Install Logstash
    install_logstash

    # Configure Logstash
    configure_logstash

    # Start Logstash
    start_logstash

    echo "Setup completed."
else
    echo "Running in manual mode..."
    echo "Manual steps:"
    echo "1. Install Logstash."
    echo "2. Configure Logstash using the configuration provided in this script."
    echo "3. Start the Logstash service."
fi
