#!/usr/bin/env python3

# A quick and dirty Python script to send a message to an IRC channel.

import os
import socket
import ssl

nick    = bytes(os.getenv("IRC_NICK", "notguru-cicd"), "ascii")
host    = os.getenv("IRC_HOST", "irc.libera.chat")
port    = int(os.getenv("IRC_PORT", "6697"))
channel = bytes(os.getenv("IRC_CHANNEL", "##notgentoo-guru"), "ascii")
message = bytes(os.getenv("IRC_MESSAGE", "Howdy!"), "ascii")
context = ssl.create_default_context()

def main():
    print("Connecting to IRC network...")
    sock  = socket.create_connection((host, port))
    ssock = context.wrap_socket(sock, server_hostname=host)

    # Let the server speak up first before we send anything
    buf = ssock.recv()
    if len(buf) == 0:
        raise Exception("Unexpected disconnect")

    # Identify ourselves to the server, then join a channel to send a message.
    # We send VERSION last since the response (351) is predictable and used as
    # an indicator that everything was received.
    print("Sending commands...")
    command = (
        b"NICK " + nick + b"\n" +
        b"USER " + nick + b" 0 0 :" + nick + b"\n" +
        b"JOIN " + channel + b"\n" +
        b"PRIVMSG " + channel + b" :" + message + b"\n" +
        b"VERSION\n"
    )
    ssock.sendall(command)

    print("Waiting for response...")
    while True:
        buf = ssock.recv()
        if len(buf) == 0:
            raise Exception("Unexpected disconnect")

        lines = buf.split(b"\n")
        for line in lines:
            parts = line.split()
            if len(parts) > 1 and parts[1] == b"351":
                print("Message sent!")
                return

main()
