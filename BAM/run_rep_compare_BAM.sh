#!/bin/bash

# This script requires that Deeptools is installed in your current environment, either directly or via conda, etc.

# Check whether Deeptools2 is present
# method from https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script

command -v multiBamSummary >/dev/null 2>&1 || { echo >&2 "I require multiBamSummary but it's not installed.  Aborting."; exit 1; }


# Read in a file of input file names


# cat ids.txt | parallel echo cutadapt -l 20 {}_1.fastq -o {}_1.trimmed.fq
