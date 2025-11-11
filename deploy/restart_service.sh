#!/bin/bash
APP_DIR=$1
echo "Restarting Node app in $APP_DIR"
pkill -f "node index.js" || true
cd "$APP_DIR"
nohup node index.js > app.log 2>&1 &
echo "App restarted successfully!"
