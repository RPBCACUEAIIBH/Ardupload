This is a tool for uploading/updating arduino sketch from distance via a linux pc (such as a raspberry pi) that the arduino is connected to.

Instructions:
1. Open your sketch with the arduino IDE, select the type of device you have connected to the remote machine, and hit verify instead of upload. (Leave the IDE open!)
2. Go to /tmp and find the .ino.hex file that has the same name that your sketch has in an arduinosomething folder.
3. (Assuming you have ssh access) Copy the .ino.hex file to the remote machine with:
scp /local/path/file.ino.hex username@domainorip:/remote/path
4. ssh into the machine:
ssh username@domainorip
5. (Assuming you have this script on the remote machine, if not download or clone it) Run this script:
/path/Ardupload.sh /path/file.ino.hex /dev/ttyUSB0
where: /dev/ttyUSB0 is the port the arduino is connected to.

Note that the script uses avrdude, if it's not installed, the script will try to install it, so you may need super user privileges to do that the first time you run it!

Since it includes parts of arduino IDE I gave it the same license.
