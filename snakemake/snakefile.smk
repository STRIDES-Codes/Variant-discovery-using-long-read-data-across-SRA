sra_accs_fn = config['sra_accs_fn']

sra_accs_list = []
with open(sra_accs_fn, 'rt') as f:
    for line in f:
        line = line.split()[0].strip()
        if re.match('[SED]RR\d+$', line): 
            sra_accs_list.append(line)


rule all:
    input: 
        expand('bam_files/{acc}.sorted.bam', acc=sra_accs_list),
        expand('bam_files/{acc}.sorted.bam.bai', acc=sra_accs_list),
        # expand('canu_assemblies/{acc}/{acc}.contigs.fasta', acc=sra_accs_list),
        # expand('nsps/{acc}.nsps', acc=sra_accs_list),
        expand('vcf_files/{acc}.vcf', acc=sra_accs_list),
        expand('vcf_files/{acc}.gvcf', acc=sra_accs_list),
        expand('filtered_vcf_files/{acc}.filtered.vcf', acc=sra_accs_list),

include: 'fetch_fastq.smk'
include: 'run_minimap.smk'
# include: 'run_canu.smk'
include: 'run_deepvariant.smk'

