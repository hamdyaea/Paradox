# Paradox of Universal Lossless Compression

Developer: Hamdy Abou El Anein
Contact: hamdy.aea@protonmail.com

This educational Bash experiment illustrates a limitation of **lossless
compression**: no reversible compressor can make *every* possible input
strictly smaller. Repeatedly compressing an already-compressed file often
makes it larger because compression formats carry headers and metadata.

## Run

```bash
./paradox.bash
# or write to a new, explicitly named directory:
./paradox.bash --output /tmp/my-gzip-experiment --rounds 20
```

The script creates an isolated directory (by default using `mktemp -d`),
writes 100 lines of `blabla`, and performs 100 successive gzip operations
(or the specified number). It prints the byte count after each round.

**Safety:** The script never appends to files inside the Git checkout and
refuses to overwrite an existing output directory. Historical `toto*`
files remain in this repository unchanged.

## Offline tests

```bash
bash -n paradox.bash
python3 -m unittest discover -s tests -v
```

The tests verify the round-trip decompression, size generation, argument
validation and refusal to overwrite existing files.

For mathematical background see
[Universal lossless data compression](https://en.wikipedia.org/wiki/Lossless_compression#Limitations).
The original historical script and README are preserved in branch `old`.
