#############################################################################
# Filename: temperature.py
# Date Created: 03/15/19
# Date Modified: 03/18/19
# Author: Parth Trivedi
#
# Version 1.1
#
# Description: Script returns temperature value to sensehat.sh so that Metric
#              can be sent to Pulse.
#
# Usage: Place this script in /home/pi/scripts/sensehat and make it executable
#        with chmod.
#
# Version history:
# 1.1 - Ken Osborn: Re-named script, added banner, modified variable names,
#                   added Fahrenheit and Case Heat calculations.
# 1.0 - Parth Trivedi: First version of the script.
#############################################################################
from sense_hat import SenseHat
sense = SenseHat()
temperature = 0
temperature = round(sense.get_temperature(),3)
# Convert to Fahrenheit and account for case heat, comment next line to use
# Celsius, instead.
temperature = ( ((temperature/5*9)+32)-26 )
print (temperature)