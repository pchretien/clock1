#!/usr/bin/python
import time
import sys
import atexit
from threading import Timer
import RPi.GPIO as GPIO

# Display detailed information when set to true
verbose = False

# tic every second
sleepDelay = 1

# Display a message to the console if the verbose mode is enabled
def printInfo(msg):
    if verbose:
        print msg

# Print an error message
def printError(error):
    print(error)

# Process the command line arguments if any
def processArgv():
    global verbose
    for i in range(1, len(sys.argv)):
        if sys.argv[i] == '-i':
            print('-i: Ignoring current mentions')
            ignoreCurrentTweets()

        if sys.argv[i] == '-v':
            print('-v: Activating verbose mode')
            verbose = True

def clearGPIO():
    GPIO.cleanup()
    print('Bye!')

atexit.register(clearGPIO)

def initGPIO():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(18, GPIO.OUT)
    GPIO.setup(23, GPIO.OUT)

def tic():
    print('tic ' + time.ctime())
    Timer(1, tic).start()

#
# Main
#

def main():

    # Init the IOs
    initGPIO()

    # Read the command line arguments
    processArgv()

    printInfo('Starting clock1 ...')

    tic()
    
    while True:        
        time.sleep(sleepDelay)

if __name__ == "__main__":
    main()
