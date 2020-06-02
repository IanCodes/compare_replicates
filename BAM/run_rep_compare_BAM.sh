#!/bin/bash

#####
# This script requires that Deeptools is installed in your current environment, either directly or via conda, etc.
#####

### Check whether Deeptools2 is present
### make sure Deeptools is loaded, e.g. 'conda activate deeptools@3.4.3'
# method from https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script

command -v multiBamSummary >/dev/null 2>&1 || { echo >&2 "I require multiBamSummary but it's not installed.  Aborting."; exit 1; }


#### Read in a file of input file names
# contents of BAM_files.txt to be used with '--bamfiles' flag
# preferably short_descriptive names
# cat BAM_files.txt
cat BAM_files.txt | tr '\n' ' '

#### Read in a file of input file labels
# short descriptive name of sample to be used with '--labels' flag
cat BAM_labels.txt | tr '\n' ' '

# cat ids.txt | parallel echo cutadapt -l 20 {}_1.fastq -o {}_1.trimmed.fq
