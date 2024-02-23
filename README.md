# elrey-elkstack
Very basic elkstack, elasticsearch, kibana, logstash

# ELK Stack Setup Guide

- github repo: https://github.com/nmcusa/elrey-elkstack

This document provides an overview of our ELK (Elasticsearch, Logstash, Kibana) stack setup, including basic validation checks to ensure your logs are being sent correctly, and the URLs and port addresses to access Elasticsearch, Kibana, and Logstash.

## Access URLs and Ports

Here are the default URLs and ports used to access the tools in the ELK stack:

- **Elasticsearch**: http://10.2.0.199:9200
  - A distributed, JSON-based search and analytics engine designed for horizontal scalability, reliability, and easy management.
- **Kibana**: http://10.2.0.199:5601
  - A web UI that lets you visualize your Elasticsearch data and navigate the Elastic Stack.
- **Logstash**: TCP input on port 5044
  - A server-side data processing pipeline that ingests data from multiple sources simultaneously, transforms it, and then sends it to your favorite "stash."

## Basic Validation Checks

To ensure your ELK stack is correctly set up and can process logs, follow these validation steps:

### 1. Check Elasticsearch Health

Run the following command to retrieve the health status of your Elasticsearch cluster:

```bash
curl -X GET "10.2.0.199:9200/_cluster/health?pretty"
```

### 2. Verify Logs in Elasticsearch
```bash
curl -X GET "10.2.0.199:9200/_search?q=message:<log_message>&pretty"
```

### Notes:
- This guide assumes you have `curl` and `nc` (Netcat) installed on your system for testing purposes.
- You might need to adjust the `<log_message>` placeholder with the actual log message content you're testing.
- If you have secured your ELK stack with authentication, you'll need to include authentication details in your `curl` commands.

Adapt and expand this README.md as necessary to fit the specifics of your environment and setup.

---

# Test logstash input:
```bash
echo 'Hello World!' | nc 10.2.0.199 5044
```

# Verify Logs in Elasticsearch:
```bash
curl -X GET "10.2.0.199:9200/_search?q=message:\"Hello World!\"&pretty"
```