#!/bin/bash
# Usage: ./gro_merge.sh rec.gro lig_GMX.gro

###
### gro_merge.sh - dose one thing well
###
### Usage:
###       gro_merge.sh <receptor.gro>  <ligand_GMX.gro>
###
### Options:
###     <receptor.gro> 		The gro file generated from gmx pdb2gmx
###     <ligand_GMX.gro> 	The gro file generated from acpype
###     -h          		Show this message

help() {
	sed -rn 's/^### ?//;T;p;' "$0"
}

if [[ $# == 0 ]]  || [[ "$1" == "-h" ]]; then
	help
	exit 1
fi


more  $2 | sed -n '3,$p' > test.gro && sed -i '' test.gro 
# a=`sed -n 2p rec.gro`
a=`sed -n 2p $1`
b=`sed -n 2p $2 `
c=$(($a+$b))
more $1 > complex.gro
sed -i "2c $c" complex.gro
tail -1 $1 > last
sed -i '$d' complex.gro
more test.gro >> complex.gro
more last >> complex.gro
rm last 
rm test.gro


