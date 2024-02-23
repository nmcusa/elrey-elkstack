# elrey-elkstack
Very basic elkstack, elasticsearch, kibana, logstash

github repo: https://github.com/nmcusa/elrey-elkstack

- Test Your Setup
To test your setup, you can send a sample JSON log message to Logstash using nc (Netcat):
```
echo '{"message": "Hello, Logstash!"}' | nc localhost 5044
```