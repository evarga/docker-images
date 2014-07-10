#!/bin/bash
#
# This is an entry point into this container. The script sets the working directory to /src/thrift, which
# is mapped to a host folder containing the .thrift files. Afterward, it passes the language and the file name
# to the thrift compiler. These parameters should be provided as command line arguments to this script, though.

# This is the mapped volume with source files.
cd /src/thrift

# Print out information about this run.
echo "Current working directory: " ${PWD##*/}
echo "Target language: " $1
echo "Source file name: " $2

# Invoke the Thrift compiler.
thrift --gen $1 $2