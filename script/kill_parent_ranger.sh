#!/bin/bash

seek_ranger_pid()
{
  check_ranger "$1"
  if [ $? = 0 ]; then
    echo "$1"
    return
  fi

  ppid=$(parent_id "$1")
  if [ "$ppid" = "" ] || [ "$ppid" = 0 ] ; then
    exit 1
  else
    echo ""
  fi
}

parent_id(){
  ppid=$(ps --pid "$1" -o ppid -h)
  # shellcheck disable=SC2086
  echo $ppid
}

check_ranger(){
  comm=$(comm "$1")
  if [ ! "$comm" = "ranger" ]; then
    return 1
  fi
  return 0
}

comm(){
  comm=$(ps -p "$1" -o comm -h)
  # shellcheck disable=SC2086
  echo $comm
}

ranger=$(seek_ranger_pid "$PPID")

edit_cmd='edit'
edit_path='./'

edit_cmd=$1
edit_path=$2
cmd_file=$3
path_file=$4
if [ $# -eq 4 ]; then
  edit_cmd=$1
  edit_path=$2
  cmd_file=$3
  path_file=$4
else
  echo 'require 4 argument'
  exit 1
fi

if [ ! "$ranger" = "" ]; then
  echo "$edit_cmd" > $cmd_file
  echo "$edit_path" > $path_file
  kill "$ranger"
fi
