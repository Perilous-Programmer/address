# #!/bin/bash

# ADDRESS_SERVER_PORT=8080 php bin/simps.php http:start

#!/bin/bash
### BEGIN INIT INFO
# Provides:          swoole_service
# Required-Start:    $local_fs $network
# Required-Stop:     $local_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start Swoole PHP server
# Description:       Start the Swoole PHP server on boot
### END INIT INFO

# Set the path to your PHP and script
PHP="/usr/bin/php"  # Adjust this path to your PHP binary
SCRIPT="/opt/address/bin/simps.php"
ADDRESS_SERVER_PORT=8080
TMP=/tmp

# Function to start the service
start() {
    echo "Starting Swoole service..."
    nohup $PHP $SCRIPT http:start > /var/log/swoole_service.log 2>&1 &
    echo $! > /var/run/swoole_service.pid
    echo "Swoole service started with PID $(cat /var/run/swoole_service.pid)"
}

# Function to stop the service
stop() {
    echo "Stopping Swoole service..."
    if [ -f /var/run/swoole_service.pid ]; then
        kill $(cat /var/run/swoole_service.pid)
        rm /var/run/swoole_service.pid
        echo "Swoole service stopped."
    else
        echo "Swoole service is not running."
    fi
}

# Function to restart the service
restart() {
    stop
    start
}

# Function to check the status of the service
status() {
    if [ -f /var/run/swoole_service.pid ]; then
        echo "Swoole service is running with PID $(cat /var/run/swoole_service.pid)"
    else
        echo "Swoole service is not running."
    fi
}

# Check the command passed to the script
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac

exit 0