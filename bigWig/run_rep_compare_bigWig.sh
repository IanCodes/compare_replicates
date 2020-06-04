#!/bin/bash

#####
# This script requires that Deeptools is installed in your current environment, either directly or via conda, etc.
#####

### Check whether Deeptools2 is present
### make sure Deeptools is loaded, e.g. 'conda activate deeptools@3.4.3'
# method from https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script

command -v multiBigwigSummary >/dev/null 2>&1 || { echo >&2 "I require multiBigwigSummary but it's not installed.  Aborting."; exit 1; }


### Read in a file of input file names
# contents of BW_files.txt to be used with '--bwfiles' flag
# preferably short_descriptive names
# cat BW_files.txt separate by spaces
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
echo INPUT files: $infiles


#### Read in a file of input file labels
# short descriptive name of sample to be used with '--labels' flag

inlabels=$(cat $labels | tr '\n' ' ')
echo INPUT labels: $inlabels
echo ""

#### Run multiBigwigSummary
echo --- Running multiBigwigSummary ---
echo multiBigwigSummary bins --numberOfProcessors "max/2" --bwfiles $infiles --labels $inlabels -o ${name}_summary.npz
echo ""

multiBigwigSummary bins --bwfiles $infiles --labels $inlabels -o ${name}_summary.npz 

#### Draw correlation plot
echo --- Drawing correlation plot ---
echo plotCorrelation -in ${name}_summary.npz --corMethod spearman --skipZeros --plotTitle "Spearman Correlation of fragments" --whatToPlot heatmap --colorMap RdYlBu --plotNumbers -o ${name}_heatmap_SpearmanCorr_readCounts.png --outFileCorMatrix ${name}_SpearmanCorr_readCounts.tab
echo ""

plotCorrelation -in ${name}_summary.npz --corMethod spearman --skipZeros --plotTitle "Spearman Correlation of fragments" --whatToPlot heatmap --colorMap RdYlBu --plotNumbers -o ${name}_heatmap_SpearmanCorr_readCounts.png --outFileCorMatrix ${name}_SpearmanCorr_readCounts.tab

#### Draw PCA plot
echo --- Drawing PCA plot ---
echo plotPCA --corData ${name}_summary.npz --plotTitle "PCA of Read Counts" -o ${name}_PCA_readCounts.png --outFileNameData ${name}_PCA_fragments.tab
echo ""

plotPCA --corData ${name}_summary.npz --plotTitle "PCA of fragments" -o ${name}_PCA_fragments.png --outFileNameData ${name}_PCA_fragments.tab

echo "Finished!"



