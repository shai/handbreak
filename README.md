handbreak
=========

Distributed CPU power across multiple machine to render video files using HandBrakeCLI.exe

## Why?
Why do I need this script? Because Adobe Piere Pro CC is a
professional software that doesn't accept Shadowplay's variable
frame rate, and so I must use HandBreak to set a constant frame
rate, which is the --cfr switch you can see in the command.

## Some info
This script will process [Shadowplay](http://www.geforce.com/geforce-experience/shadowplay) files on the same host,
one at a time, so that multiple Windows machines (PC/Laptop)
can work on multiple files, utilizing their own CPU to
distribute the CPU usage and shorten the time it takes to
process the video files.

## Prerequisites
For this to work, you need to have HandBrakeCLI.exe (ie. install [HandBreak](https://handbrake.fr/))
and you need to make sure that all of the machines (including your local one,
if you want to use it to also render the video files) have access
to the destination directories to read/write to.

## Running the script
To run the script, I simply access it from the share or manually
if running from the local machine where the files are.
from a Windows machine on the network: \\x\bin\handbrake_local.bat
from the local Windows machine: x:\bin\handbrake_local.bat
