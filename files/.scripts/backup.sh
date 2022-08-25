#!/bin/sh
if [ -d "$1" ];
then
  sudo rsync -aAXv --progress --exclude={"/files/*","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/home/*/.cache/*","/home/*/Sync/*","/home/*/.mozilla/*"} / "$1";
else
  echo $'usage:\n'$0' </path/to/target/directory>';
  echo $'\nError: invalid target directory, cancelling backup..';
fi
