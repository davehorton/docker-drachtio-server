#!/bin/bash
set -e

if [ "$1" = 'drachtio' ]; then
    shift

while :; do
  case $1 in 
  -p|--port)
    if [ -n "$2" ]; then
      sed -i -e "s/<admin port=\"[[:digit:]]\+\"/<admin port=\"$2\"/g" /etc/drachtio.conf.xml
    fi
    ;;

  -s|--secret)
    if [ -n "$2" ]; then
      sed -i -e "s/secret=\".\+\"/secret=\"$2\"/g" /etc/drachtio.conf.xml
    fi
    ;;

  -c|--contact)
    if [ -n "$2" ]; then
      sed -i -e "s/<contacts>/<contacts><contact>$2<\/contact>/g" /etc/drachtio.conf.xml
    fi
    ;;

  -l|--loglevel)
    if [ -n "$2" ]; then
      sed -i -e "s/<loglevel>info/<loglevel>$2/" /etc/drachtio.conf.xml
    fi
    ;;

  --sofia-loglevel)
    if [ -n "$2" ]; then
      sed -i -e "s/<sofia-loglevel>3/<sofia-loglevel>$2/" /etc/drachtio.conf.xml
    fi
    ;;

  --)
    shift
    break
    ;;

  *)
    break
  esac

  shift
  shift

done

    exec drachtio "$@"
fi

exec "$@"