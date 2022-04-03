#!/usr/bin/env python3
from pypresence import Presence # The simple rich presence client in pypresence
import time

client_id = "960145972002979892"  # Put your Client ID in here
RPC = Presence(client_id)  # Initialize the Presence client
RPC.connect() # Start the handshake loop
IMAGE="https://cdn.niceboard.co/boards/legaltechjobs/companies/technical-university-of-munich-U-BvaGGi6f.png"
# ACTIVITY=''

while True:  # The presence will stay on as long as the program is running
    RPC.update(
        details="Studying...",
        # state=ACTIVITY,
        large_image=IMAGE,
        start=int(time.time()),
    )
    time.sleep(60) #Wait a wee bit
