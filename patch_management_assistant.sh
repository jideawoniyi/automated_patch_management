
#!/bin/bash

# Patch Management Assistant Script

# Configuration
log_file="patch_management_log_$(date +%Y%m%d).txt"  # Log file name
send_notifications=false  # Set true to send notifications after patching
notification_recipient="admin@example.com"  # Email for sending notifications

# Function to check for updates
check_updates() {
    echo "Checking for available updates..." | tee -a $log_file
    sudo apt update | tee -a $log_file
    updates=$(sudo apt list --upgradable)
    if [ -z "$updates" ]; then
        echo "No updates available." | tee -a $log_file
    else
        echo "Updates available:" | tee -a $log_file
        echo "$updates" | tee -a $log_file
    fi
}

# Function to apply updates
apply_updates() {
    echo "Applying updates..." | tee -a $log_file
    sudo apt upgrade -y | tee -a $log_file
    echo "Updates applied." | tee -a $log_file
}

# Function to send notifications
send_notification() {
    if $send_notifications; then
        mail -s "Patch Management Report" $notification_recipient < $log_file
        echo "Notification sent to $notification_recipient" | tee -a $log_file
    fi
}

# Main function
main() {
    check_updates
    # Uncomment the next line to apply updates automatically
    # apply_updates
    send_notification
}

# Execute main function
main
