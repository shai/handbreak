@echo off

REM By Shai Ben-Naphtali <shai@shaibn.com>
REM Version 1.1.0
REM I want to thank Tomer Golan for the initial idea and script.
REM License: The MIT License (MIT)

REM === The script ===
REM set server = the host IP of our server even if the IP is of the same
REM server as where the script is running from, it'll still be
REM able to access the share and read/write it
set server=\\10.0.0.1
REM set topdir = is just the path where we've got our Shadowplay files
REM Note that the files should actually be in the work directory, not
REM in the %topdir%. I set %topdir% because I can easily continue
REM using this variable later on, and just suffix it with more paths
set topdir=x\shadowplay\Battlefield 4

REM We create a directory named after each Windows machine that works
REM on the files. This is crucial in order to move the files from the
REM work directory. The move command is atomically, and hence there
REM is zero change that two machines will attempt access to the same
REM initial file.
md "%server%\%topdir%\work\%computername%"

REM Now we loop over the files in the work directory, move 1 file
REM to the individual directory named after the Windows machine
REM and begin using HandBrakeCLI.exe to render it.
REM The original file NEVER gets deleted from that directory.
REM You need to do this manually.
REM The output file (using the -o switch) during rendering is sent to the
REM 'out' sub-directory and when the file is rendered, the output file
REM is moved to the 'done' directory.
for /f "tokens=*" %%I in ('dir /b "%server%\%topdir%\work\*.mp4"') do (
	echo.
	echo %%I
	echo.
	move "%server%\%topdir%\work\%%I" "%server%\%topdir%\work\%computername%\%%I"
	"C:\Program Files\Handbrake\HandBrakeCLI.exe" ^
	 --input "%server%\%topdir%\work\%computername%\%%I" ^
	 --title 1 ^
	 --angle 1 ^
	 --chapters 1 ^
	 --output "%server%\%topdir%\out\%%~nI_.mp4" ^
	 --format mp4 ^
	 --large-file ^
	 --decomb ^
	 --width 1920 ^
	 --height 1088 ^
	 --modulus 16 ^
	 --encoder x264 ^
	 --quality 23 ^
	 --rate 30 ^
	 --cfr ^
	 --audio 1 ^
	 --aencoder faac ^
	 --mixdown dpl2 ^
	 --arate 48 ^
	 --ab 192 ^
	 --drc 0 ^
	 --gain 0 ^
	 --audio-fallback ffac3 ^
	 --x264-profile=high  ^
	 --h264-level="4.1" ^
	 --verbose=1
	move "%server%\%topdir%\out\%%~nI_.mp4" "%server%\%topdir%\work\done\"
)
