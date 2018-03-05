#!/bin/bash

service httpd start

cat <<EOF >~/.bashrc trap
'/usr/local/bin/stop; exit 0' TERM
EOF

exec /bin/bash
