#!/bin/bash


cat ids.txt | parallel echo cutadapt -l 20 {}_1.fastq -o {}_1.trimmed.fq
