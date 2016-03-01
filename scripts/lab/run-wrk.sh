#!/bin/bash
threads=`nproc`
host=192.168.1.100
port=8080
test=plaintext
connections=512
duration=60

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -h|--host)
    host="$2"
    shift # past argument
    ;;
    -p|--port)
    port="$2"
    shift # past argument
    ;;
    -t|--test)
    test="$2"
    shift # past argument
    ;;
    -c|--connections)
    connections="$2"
    shift # past argument
    ;;
    -d|--duration)
    duration="$2"
    shift # past argument
    ;;
esac
shift # past argument or value
done

wrk -c $connections -t $threads -d $duration --timeout 8 -s ../pipeline.lua http://$host:$port/$test -- 16
