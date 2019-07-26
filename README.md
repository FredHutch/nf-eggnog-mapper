# Nextflow EGGnog-mapper
Nextflow script running EGGnog-mapper


### Input files

All input files will be amino acid sequences in FASTA format.
Input files must end with .faa[.gz] or .fasta[.gz].


### Reference Database

EGGnog mapper needs two reference files in order to run, `--eggnog_db` and `--eggnog_dmnd`.
Examples are provided at:

```
--eggnog_db s3://fh-ctr-public-reference-data/tool_specific_data/eggnog-mapper/emapperdb-4.5.1/eggnog.db
--eggnog_dmnd s3://fh-ctr-public-reference-data/tool_specific_data/eggnog-mapper/emapperdb-4.5.1/eggnog_proteins.dmnd
```


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
