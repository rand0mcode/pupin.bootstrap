#!/bin/bash

# execute on kibana host
# needs access to localhost:5601 (kibana default)
/usr/bin/filebeat setup --dashboards
