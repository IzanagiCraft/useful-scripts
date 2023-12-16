#!/bin/bash

while true; do
    echo "Which server do you want to connect to?"
    echo ""
    echo "1. Connect to root@izanagicraft."
    echo ""
    echo "0. Exit script."
    echo ""
    read -p "Choice: " option

    case $option in
        1)
            echo "Connecting via ssh to root@izanagicraft..."
            sleep 1
            ssh -p 22 root@127.0.0.1
            ;;
        0)
            echo "Bye :)"
            sleep 1
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a valid option."
            ;;
    esac
done
