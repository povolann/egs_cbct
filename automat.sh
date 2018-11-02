#! /bin/bash
set -x #kontrola promennych

zacatek=694
konec=717
inputFile="/home/anya/EGSnrc/egs_home/egs_cbct/blank_phant.egsinp"
puvod=$(grep -Po 'initial seeds = 1802 \K[^ ]+' $inputFile)

for ((n=$zacatek; n<=$konec; n++))
do
outputFile="/home/anya/EGSnrc/egs_home/egs_cbct/phant_$n.egsinp"
cislo=$(grep -Po 'initial seeds = 1802 \K[^ ]+' $outputFile)
sed -i "s/seeds = 1802 $puvod/seeds = 1802 $cislo/g" $inputFile
puvod=$cislo

#./egs-parallel.sh 6 
egs_cbct -i blank_phant
#./egs-parallel.sh 6 
egs_cbct -i phant_$n
#prikaz pro provedení MC pro zacatek až konec vcetne obou

done
