#!/usr/bin/env nextflow

// Input parameters
params.input_folder = false
params.output_folder = false
params.eggnog_db = "s3://fh-ctr-public-reference-data/tool_specific_data/eggnog-mapper/emapperdb-4.5.1/eggnog.db"
params.eggnog_dmnd_db = "s3://fh-ctr-public-reference-data/tool_specific_data/eggnog-mapper/emapperdb-4.5.1/eggnog_proteins.dmnd"

// Check that the input parameters are set
assert params.input_folder, "Please specify an input folder with --input_folder"
assert params.output_folder, "Please specify an output folder with --output_folder"
assert params.eggnog_db, "Please specify an eggNOG database with --eggnog_db"
assert params.eggnog_dmnd_db, "Please specify an eggNOG reference *.dmnd file with --eggnog_dmnd_db"

// Make a Channel with the input files
fasta_ch = Channel
    .fromPath( [
        "${params.input_folder}/*faa.gz", 
        "${params.input_folder}/*faa", 
        "${params.input_folder}/*fasta.gz", 
        "${params.input_folder}/*fasta"
    ] )
    .map{it -> file(it)}

// Run EGGnog-mapper on all input files
process eggnogAnnotation {
    container "quay.io/biocontainers/eggnog-mapper:1.0.3--py27_0"
    cpus 16
    memory "32 GB"
    publishDir "${params.output_folder}"
    
    input:
    file query from fasta_ch
    file db from file(params.eggnog_db)
    file dmnd_db from file(params.eggnog_dmnd_db)

    output:
    file "${query.simpleName}.emapper.annotations.gz" into refdb_eggnog
    
    afterScript "rm *"

    """
    set -e

    mkdir data
    mkdir TEMP
    mkdir SCRATCH
    if [[ "${db}" =~ \\.gz\$ ]]; then
        mv ${db} data/eggnog.db.gz
        gunzip data/eggnog.db.gz
    else
        mv ${db} data/eggnog.db
    fi

    if [[ "${dmnd_db}" =~ \\.gz\$ ]]; then
        mv ${dmnd_db} data/eggnog_proteins.dmnd.gz
        gunzip data/eggnog_proteins.dmnd.gz
    else
        mv ${dmnd_db} data/eggnog_proteins.dmnd
    fi

    emapper.py \
      -i ${query} \
      --output ${query.simpleName} \
      -m "diamond" \
      --cpu 16 \
      --data_dir data/ \
      --scratch_dir SCRATCH/ \
      --temp_dir TEMP/ \

    gzip ${query.simpleName}.emapper.annotations
    
    """

}