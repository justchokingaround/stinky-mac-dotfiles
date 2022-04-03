#!/bin/bash

a=1;
for i in *.mkv; 
do  
  new=$(printf "%04d.mkv" "$a");
  mv "$i" "$new";
  let a=a+1;
done

