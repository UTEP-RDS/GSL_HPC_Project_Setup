start_value=$1
end_value=$2
 
src_folder="base/"
 
for i in $(seq $start_value $end_value); do
  dst_f="sim$i"
  mkdir $dst_f
  cp -r "$src_folder"/* "$dst_f"
done
 
# Navigate to the simulation directories and run the commands
for i in $(seq $start_value $end_value); do
  sim_dir="sim$i"
  gnome-terminal --tab -- bash -c "
    cd '$sim_dir'
    make all
    make run
    exec bash
    cd ..
  "
done