MINIMAP2 = '/data/anaconda3/bin/minimap2'
SAMTOOLS = '/data/anaconda3/bin/samtools'

rule run_minimap:
    message: 'Run minimap2 on {wildcards.acc}'
    input: 'fastq_files/{acc}.fastq.gz',
    output: temp('bam_files/{acc}.sam'),
    log: 'logs/{acc}.minimap2.log'
    params:
        ref_fa = config['ref_fa'],
    threads: 4
    shell:
        """
        mkdir -p bam_files 
        mkdir -p logs

        {MINIMAP2} \
            -t {threads} \
            -ax map-ont \
            --sam-hit-only \
            --eqx {params.ref_fa} {input} \
            > {output} \
            2> {log}
        """

rule sam_to_bam:
    message: 'Convert sam to sorted bam for {wildcards.acc}'
    input: 'bam_files/{acc}.sam',
    output: 'bam_files/{acc}.sorted.bam',
    log: 'logs/{acc}.sam_sort.log',
    threads: 4
    shell:
        """
        {SAMTOOLS} view \
            --threads {threads} -u {input} 2>{log} \
        | {SAMTOOLS} sort \
            --threads {threads} - -o {output} 2>{log}
        """

rule index_bam:
    message: 'Index {wildcards.acc} bam file'
    input: 'bam_files/{acc}.sorted.bam',
    output: 'bam_files/{acc}.sorted.bam.bai',
    log: 'logs/{acc}.sam_index.log',
    shell:
        """
        {SAMTOOLS} index {input} {output}
        """
