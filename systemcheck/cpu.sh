#!/bin/sh
#####cpu检查#####
function GetCpu 
  { 
   CpuValue=`ps -p $1 -o pcpu |grep -v CPU | awk '{print $1}' | awk -  F. '{print $1}'` 
        echo $CpuValue 
    }
GetCpu
