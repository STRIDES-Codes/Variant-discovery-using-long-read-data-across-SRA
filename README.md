# Variant discovery using long-read data across SRA

## Background
Single Nucleotide Polymorphisms (SNPs) across SARS-CoV-2 genomes are critical to the understanding of their molecular biology and SNPs are also important for public health interventions.

## What's the problem?
SARS-CoV-2 variation data can be visualized using some already developed tools but these existing tools are designed mostly for short reads and are therefore limited by the amount and kind of information that can be obtained from the resulting SARS-CoV-2 genomic data analysis.

## Solution to the problem
This project is therefore aimed towards the development of a pipeline for the discovery and visualization of SNPs in long read SARS-CoV-2 sequences obtained from the Sequence Read Archive (SRA). These long reads will be primarily from experiments performed using Pacbio Single Molecule Real-Time (SMRT) and Oxford Nanopore Sequencing technologies.

## Architecture for the solution

SARS-CoV-2 longread (SRA) mapped to SARS-CoV-2 reference genome (RefSeq) +++++> Alignments +++++> Identify SNPs +++++> Visualize SARS-CoV-2 SNPs

## Workflow
+ Download Reference SARS-CoV-2 Genome from RefSeq (data/ref/sars2_ref_sequence.fasta)
- Query the Sequence Read Archive (SRA) to find longread datasets for SARS-CoV-2
+ Generate TSV file with all accessions resulting from the longread query (18,966 accessions in data/long_reads_SARS2.tsv)
- Download some SARS-CoV-2 fastq files from the Sequence Read Archive using a few accessions above (7 fastqs in test dataset)
+ Use Minimap to align these fastqs to the reference SARS-CoV-2 genome
- Use Deepvariant to generate VCFs from the alignments for each of the samples.
+ Assemblies were done with CANU
+ Analyse the VCFs and look for SNPs based on the alignments
- Correlate SNPs with SARS-CoV-2 genome metadata
+ Visualize SNPs and associated SARS-CoV-2 metadata

## Note:
Outputs from from our pipeline are JSON files which are similar to the one below.


## Template for variant data (JSON)
```json
{
     "start": 9560,
     "stop": 9561,
     "reference_sequence": "C",
     "alleles": [
       {
         "allele": "T",
         "count": 6,
         "spdi": "NC_045512.2:9560:C:T",
         "Host": [
           {
             "value": "Homo sapiens",
             "count": 6
           }
         ],
         "Collection Date": [
           {
             "value": "2020-01-11",
             "count": 1
           },
           ...
         ],
         "Collection Location": [
           {
             "value": "USA: CA/North America",
             "count": 5
           },
           {
             "value": "China/Asia",
             "count": 1
           }
         ],
         "codon": "TTA",
         "amino_acid": "L",
         "protein_variant": "S336L",
         "aa_type": "non_synonymous"
       }
     ],
     "protein_name": "nsp4",
     "protein_accession": "YP_009724389.1",
     "protein_position": 336,
     "offset": 1,
     "codon": "TCA",
     "amino_acid": "S"
   },
```

Our pipeline produced the following products:
+ Alignments (BAM files)
- Vigor4 annotations (GFF and peptides)
+ Assemblies (contig fasta)
- nsps search results

###### Some Longread Variant Callers
[NanoCaller](https://github.com/WGLab/NanoCaller), [DeepVariant](https://github.com/google/deepvariant), [LongShot](https://github.com/pjedge/longshot), [Clair](https://github.com/HKU-BAL/Clair), [Medaka](https://github.com/nanoporetech/medaka)

## Research Questions
Using the resulting data from about 20,000 runs in this project, here are the research questions that we want to answer:
- What are the top 10 hotspots for SNPs in SARS-CoV-2?
- What are the most common locations for SNPs among US samples?
- Which genes have the least number of SNPs across all samples?
- Based on date of sample collection, where are the SNP hotspots?

## Challenges
+ We didn't have time to figure out permissions to run cluster, so we had to stick with our local Virtual Machines
+ We can't do visualization of SNPs because the viewer is not available.

## Next steps
+ We intend to continue working on this project after the codeathon.

## People/Team
+ Vadim Zalunin, NCBI/NIH, Maryland, MD, zaluninvv@ncbi.nlm.nih.gov
+ Vamsi Kodali, NCBI/NIH, Maryland, MD, kodalivk@ncbi.nlm.nih.gov
+ Olaitan I. Awe, University of Ibadan, laitanawe@gmail.com
+ Brett Youtsey, Los Alamos National Laboratory, byoutsey@lanl.gov
+ Weizhong Chang, NIH, Maryland, MD, weizhong.chang@nih.gov
+ Cory Weller, <Affiliation>, cory.a.weller@gmail.com
+ Xiaoli Jiao, <Affiliation>, jiaoxl@gmail.com
