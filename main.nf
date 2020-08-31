#!/usr/bin/env nextflow

/*What it does*/


/***How to run***/
/*locally - conda activate bio*/
/*nextflow run main.nf (plus change any params here) -resume*/

/***Inputs***/
params.R1reads = "/Users/annasyme/data/R1.fq"
params.R2reads = "/Users/annasyme/data/R2.fq"
params.nanoreads = "/Users/annasyme/data/nanopore.fastq"

/***Outputs***/
/* script output is in 'work' */
/* this outdir param specifies where certain file symlinks are saved */
/* note: can't unzip in here */
params.outdir = '/Users/annasyme/nftesting/results'

/***Channels and Processes***/

ch_R1_reads1 = Channel.fromPath(params.R1reads)
ch_R2_reads1 = Channel.fromPath(params.R2reads)
ch_nano_reads1 = Channel.fromPath(params.nanoreads)

process read_stats_1 {
    publishDir "${params.outdir}/read_stats_1"
    
    input:
    file R1 from ch_R1_reads1
    file R2 from ch_R2_reads1
    file nano from ch_nano_reads1

    output:
    file "R1stats.txt"
    file "R2stats.txt" 
    file "nanostats.txt"

    script:
    """
    seqkit stats $R1 > R1stats.txt
    seqkit stats $R2 > R2stats.txt
    seqkit stats $nano > nanostats.txt
    """
}

ch_nano_reads2 = Channel.fromPath(params.nanoreads)

process assemble_1 {
    publishDir "${params.outdir}/assemble_1"
    
    input:
    file reads from ch_nano_reads2

    output:
    path "flye001"
    file "flye001/assembly.fasta" into assembly1_ch

    script:
    """
    flye --nano-raw $reads  --genome-size 150000 --out-dir flye001
    """
}

ch_nano_reads3 = Channel.fromPath(params.nanoreads)

process raconpolish1 {
}

process raconpolish2 {
}

process filter_short_reads {
}

process pilonpolish1 {
}
