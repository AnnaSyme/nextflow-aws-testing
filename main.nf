#!/usr/bin/env nextflow

/*
How to run
conda activate bio
open Docker desktop
nextflow run main.nf
script will also use info from nextflow.config
this specifies to use docker
and the containers for each process
*/

/***Inputs***/
params.R1reads = "/Users/annasyme/data/R1.fq"

/***Outputs***/
/* script output is in 'work' */
/* this outdir param specifies where certain file symlinks are saved */
/* note: can't unzip in here */
/* note this work dir is listed in the .gitignore.txt */

params.outdir = '/Users/annasyme/nftesting/new-results'


/***Channels and Processes***/
channel1 = Channel.fromPath(params.R1reads)

process get_stats {

    publishDir "${params.outdir}/get_stats"

    input:
    file R1 from channel1

    output:
    file "R1stats.txt"

    script:
    """
    seqkit stats $R1 > R1stats.txt
    """
}       

