#!/bin/sh

# Trap SIGTERM and SIGINT
trap '/stop-container.sh; exit $?' TERM INT

# Start the container
/start-container.sh

# Wait for signal
while true; do :; done
