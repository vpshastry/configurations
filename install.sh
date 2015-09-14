#!/bin/bash

backup() {
  if [ "$1" != "" ]; then
          CONFIG_BACKUP="${1// /-}"
  else
          cur_time=`date`
          CONFIG_BACKUP="/home/`whoami`/config_backup_${cur_time// /-}"
  fi

  mkdir $CONFIG_BACKUP || return -1
  cp ~/.vimrc "$CONFIG_BACKUP/" || return -1
  cp -R ~/.vim/ "$CONFIG_BACKUP/" || return -1
  cp ~/.screenrc "$CONFIG_BACKUP/" || return -1
  cp ~/.gitconfig "$CONFIG_BACKUP/" || return -1
  cp ~/.gdbinit "$CONFIG_BACKUP/" || return -1
}

backup $@ || exit -1
cp vimrc ~/.vimrc
cp -R vim ~/.vim/
cp screenrc ~/.screenrc
cp gitconfig ~/.gitconfig
cp gdbinit ~/.gdbinit
