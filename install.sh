#!/bin/sh

backup($@) {
  if [ "$1" != "" ]; then
          CONFIG_BACKUP="${1// /-}"
  else
          cur_time=`date`
          CONFIG_BACKUP="~/config_backup_${cur_time// /-}"
  fi
  mkdir "$CONFIG_BACKUP"
  cp ~/.vimrc "$CONFIG_BACKUP/"
  cp -R ~/.vim/ "$CONFIG_BACKUP/"
  cp ~/.screenrc "$CONFIG_BACKUP/"
  cp ~/.gitconfig "$CONFIG_BACKUP/"
  cp ~/.gdbinit "$CONFIG_BACKUP/"
}

backup || exit -1
cp vimrc ~/.vimrc
cp -R vim ~/.vim/
cp screenrc ~/.screenrc
cp gitconfig ~/.gitconfig
cp gdbinit ~/.gdbinit
