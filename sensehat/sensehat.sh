#!/bin/bash
#      _______. _______ .__   __.      _______. _______  __    __       ___   .___________.
#     /       ||   ____||  \ |  |     /       ||   ____||  |  |  |     /   \  |           |
#    |   (----`|  |__   |   \|  |    |   (----`|  |__   |  |__|  |    /  ^  \ `---|  |----`
#     \   \    |   __|  |  . `  |     \   \    |   __|  |   __   |   /  /_\  \    |  |
# .----)   |   |  |____ |  |\   | .----)   |   |  |____ |  |  |  |  /  _____  \   |  |
# |_______/    |_______||__| \__| |_______/    |_______||__|  |__| /__/     \__\  |__|

# Author: Ken Osborn
# Version: 1.0
# Created: 26-Nov-19
# Last Updated: 26-Nov-19
# Purpose: Used to gather and send SenseHAT Metrics to Pulse

# Declare Path Variable for Pulse Agent bin folder
AGENTBINPATH="/opt/vmware/iotc-agent/bin/"

# Retrieve Gateway and SenseHat ID Values
GATEWAYID=$(${AGENTBINPATH}DefaultClient get-devices | sed -n 2p | awk '{print $1}')
SENSEHATID=$(${AGENTBINPATH}DefaultClient get-devices | sed -n 3p | awk '{print $1}')

while true; do
# Set and Retrieve Python return variables for Temperature, Humidity and Barometric Pressure
TEMP=$(/usr/bin/python /opt/sensehat/temperature.py)
HUMIDITY=$(/usr/bin/python /opt/sensehat/humidity.py)
PRESSURE=$(/usr/bin/python /opt/sensehat/pressure.py)

# Retrieve Uptime Value
UP=$(uptime -p | sed -e 's/ /-/g' | sed -e 's/,-/,/g')

# Utilize DefaultClient to send SenseHat Metrics and Gateway Uptime to Pulse
sudo ${AGENTBINPATH}DefaultClient send-metric --device-id=$SENSEHATID --name=Temperature --type=double --value=$SENSEHATTEMP
sudo ${AGENTBINPATH}DefaultClient send-metric --device-id=$SENSEHATID --name=Humidity --type=double --value=$SENSEHATHUMIDITY
sudo ${AGENTBINPATH}DefaultClient send-metric --device-id=$SENSEHATID --name=BarometricPressure --type=double --value=$SENSEHATPRESSURE
sudo ${AGENTBINPATH}DefaultClient send-properties --device-id=$GATEWAYID --key=uptime --value=$UP

# Configure While Loop Interval
sleep 30
done

