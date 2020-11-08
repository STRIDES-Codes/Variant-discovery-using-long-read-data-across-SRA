# Variant discovery using long-read data across SRA

## Background
Single Nucleotide Polymorphisms (SNPs) across SARS-CoV-2 genomes are critical to the understanding of their molecular biology and SNPs are also important for public health interventions.

SARS-CoV-2 variation data can be visualized using some already developed tools but these existing tools are designed mostly for short reads.

This project is therefore aimed towards the development of a pipeline for the discovery and visualization of SNPs in long read SARS-CoV-2 sequences obtained from the Sequence Read Archive (SRA). These long reads will be primarily from experiments performed using Pacbio Single Molecule Real-Time (SMRT) and Oxford Nanopore Sequencing technologies.

## Workflow
+ Download Reference SARS-CoV-2 Genome from RefSeq (data/ref/sars2_ref_sequence.fasta)
- Query the Sequence Read Archive (SRA) to find longread datasets for SARS-CoV-2
+ Generate TSV file with all accessions resulting from the longread query (18,966 accessions in data/long_reads_SARS2.tsv)
- Download some SARS-CoV-2 fastq files from GenBank using a few accessions above (7 fastqs in data/test_fastq/list.txt)
+ Use Minimap to align these fastqs to the reference SARS-CoV-2 genome
- Use Medaka to generate VCFs from the alignments for each of the samples.
+ Analyse the VCFs and look for SNPs based on the alignments
- Correlate SNPs with SARS-CoV-2 genome metadata
+ Visualize SNPs and associated SARS-CoV-2 metadata

###### Some Longread Variant Callers
[NanoCaller](https://github.com/WGLab/NanoCaller), [DeepVariant](https://github.com/google/deepvariant), [LongShot](https://github.com/pjedge/longshot), [Clair](https://github.com/HKU-BAL/Clair), [Medaka](https://github.com/nanoporetech/medaka)

## Research Questions
Using the resulting data from about 20,000 runs in this project, here are the research questions that we want to answer:
+ What are the top 10 hotspots for SNPs in SARS-CoV-2?
- What are the most common locations for SNPs among US samples?
+ Which genes have the least number of SNPs across all samples?
- Based on date of sample collection, where are the SNP hotspots?


## People/Team
+ Vadim Zalunin, NCBI/NIH, Maryland, MD, zaluninvv@ncbi.nlm.nih.gov
+ Vamsi Kodali, NCBI/NIH, Maryland, MD, kodalivk@ncbi.nlm.nih.gov
+ Olaitan I. Awe, University of Ibadan, Nigeria, laitanawe@gmail.com
+ Brett Youtsey, <Affiliation>, brettyoutsey@gmail.com
+ Weizhong Chang, NIH, Maryland, MD, weizhong.chang@nih.gov
+ Cory Weller, <Affiliation>, cory.a.weller@gmail.com
+ Xiaoli Jiao, <Affiliation>, jiaoxl@gmail.com
