# Nextflow EGGnog-mapper
Nextflow script running EGGnog-mapper


### Input files

All input files will be amino acid sequences in FASTA format.


### Behavior

This script will take a folder of input files `--input_folder`, run EGGnog-mapper on 
all FASTA files in that folder, and write all of the outputs to `--output_folder`

### Running

```
nextflow run FredHutch/nf-eggnog-mapper --input_folder <INPUT_FOLDER> --output_folder <OUTPUT_FOLDER>
```

### Getting Started with Nextflow

For Fred Hutch users, take a look at [the wiki](https://sciwiki.fredhutch.org/compdemos/nextflow/)
for more details on using Nextflow.
