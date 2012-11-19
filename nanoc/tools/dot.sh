#!/bin/bash

BASE_DIR=$(readlink -f $(dirname $0))
ROOT_DIR=$BASE_DIR/../..

type -p dot > /dev/null

if (( $? == 0 )); then
  DOT_COMMAND=dot
else
  # for heroku
  export PATH=$ROOT_DIR/.graphviz/bin/:$PATH
  export LD_LIBRARY_PATH=$ROOT_DIR/.graphviz/lib/
  DOT_COMMAND=dot
fi

$DOT_COMMAND "$@"
