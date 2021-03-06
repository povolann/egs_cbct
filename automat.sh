﻿#! /bin/bash
set -x #kontrola promennych

start=694
end=717
inputFile="/home/anya/EGSnrc/egs_home/egs_cbct/blank_phant.egsinp"
origin=$(grep -Po 'initial seeds = 1802 \K[^ ]+' $inputFile)

for ((n=$start; n<=$end; n++))
do
outputFile="/home/anya/EGSnrc/egs_home/egs_cbct/phant_$n.egsinp"
new=$(grep -Po 'initial seeds = 1802 \K[^ ]+' $outputFile)
sed -i "s/seeds = 1802 $origin/seeds = 1802 $new/g" $inputFile
origin=$new

./egs-parallel.sh 6 egs_cbct -i blank_phant
./egs-parallel.sh 6 egs_cbct -i phant_$n
#prikaz pro provedení MC pro zacatek až konec vcetne obou

done
