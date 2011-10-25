#!/bin/bash

file=`date -d yesterday +proventus.event.%Y-%m-%d.log`
echo $filename
dir=/site/proventus/logs
mkdir -pv $dir
nodes="lb1 lb2"
for node in $nodes
do
  cmd="scp $node.proventustechnologies.com:/site/proventus/logs/$file $dir/$file.$node"
  echo $cmd
#  $cmd
done

for node in $nodes
do
  cmd="/site/proventus/apps/statistics/current/run.sh $dir/$file.$node"
  echo $cmd
  $cmd
done