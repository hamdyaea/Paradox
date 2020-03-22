#!/bin/bash
# paradox of universal compression
# Developer : Hamdy Abou El Anein

for i in `seq 1 100`; do echo "blabla" >> toto001; done
for i in `seq 1 100`; do gzip -c "toto`printf "%03d" $i`" > "toto`printf "%03d" $((i+1))`"; done
wc -c toto*
