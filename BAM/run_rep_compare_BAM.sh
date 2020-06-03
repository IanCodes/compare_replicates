#!/bin/bash

#####
# This script requires that Deeptools is installed in your current environment, either directly or via conda, etc.
#####

### Check whether Deeptools2 is present
### make sure Deeptools is loaded, e.g. 'conda activate deeptools@3.4.3'
# method from https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script

command -v multiBamSummary >/dev/null 2>&1 || { echo >&2 "I require multiBamSummary but it's not installed.  Aborting."; exit 1; }


### Read in a file of input file names
# contents of BAM_files.txt to be used with '--bamfiles' flag
# preferably short_descriptive names
# cat BAM_files.txt separate by spaces
# https://www.linuxquestions.org/questions/linux-newbie-8/want-to-list-output-in-single-line-space-separated-860016/


### Input file names via arguments
while getopts f:l:n: flag
do
    case "${flag}" in
        f) files=${OPTARG};;
        l) labels=${OPTARG};;
        n) name=${OPTARG};; 
    esac
done

infiles=$(cat $files | tr '\n' ' ')
echo $infiles


#### Read in a file of input file labels
# short descriptive name of sample to be used with '--labels' flag

inlabels=$(cat $labels | tr '\n' ' ')
echo $inlabels

# cat ids.txt | parallel echo cutadapt -l 20 {}_1.fastq -o {}_1.trimmed.fq


#### Run multiBamSummary
echo multiBamSummary bins --bamfiles $infiles --labels $inlabels --extendReads --ignoreDuplicates --samFlagInclude 2 --maxFragmentLength 500 -o ${name}_summary.npz
