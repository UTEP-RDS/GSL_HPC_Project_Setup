#!/bin/bash

start_value=$1
end_value=$2

src_folder="base/"

for i in $(seq $start_value $end_value); do
  dst_f="sim$i"
  mkdir -p "$dst_f"
  cp -r "$src_folder"/* "$dst_f"
done
