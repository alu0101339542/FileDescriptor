# Script to enumerate ports in Unix using file descriptors
-  The program is using a level 3 file descriptor (reading and writting) to establish a connection to /dev/tcp. If the status code returned by the command is 0, it means the port is open, otherwise, it is closed.
