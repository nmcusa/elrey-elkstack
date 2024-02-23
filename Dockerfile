# # Use the official Kibana image as a parent image
# FROM docker.elastic.co/kibana/kibana:8.12.0

# # Example: Installing a Kibana plugin (replace with actual plugin installation commands)
# # Note: For demonstration purposes only; actual plugin URLs/installation commands may differ
# # RUN bin/kibana-plugin install file:///path/to/plugin/your-plugin.zip

# # Copy custom configuration file
# COPY kibana.yml /usr/share/kibana/config/kibana.yml

# # Set environment variables (optional)
# ENV SERVER_PUBLICBASEURL="http://10.2.0.199:5601"

# # Expose port (optional, mainly for documentation purposes)
# EXPOSE 5601
