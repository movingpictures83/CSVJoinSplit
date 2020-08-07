# CSVJoinSplit
# Language: R
# Input: TXT
# Output: PREFIX
# Tested with: PluMA 1.1, R 4.0.0
# Dependency: microbiome (1.10.0), ggplot2 (3.3.1), ape (5.4), psadd (0.1.2), stringr (1.4.0)

PluMA plugin to take taxa counts, metadata and a taxonmoic tree and use them to split
the counts into their taxonomic classifications.

The input TXT file consists of the following keyword-value pairs (tag-delimited):
otufile: File of taxa counts (taxa rows, samples columns) (CSV)
mapping: File of metadata table (samples rows) (CSV)
tree: File for taxonomic tree (taxa rows, classification levels columns) (CSV)

The user supplies an output prefix.  If no classification directories are present (i.e. kingdom/),
the output files will be prefix.kingdom.csv, prefix.phylum.csv, etc.

If classification directories are present, the plugin will use kingdom/prefix.csv, phylum/prefix.csv, etc.

