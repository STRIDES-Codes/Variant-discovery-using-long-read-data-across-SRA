import re 

FASTQ_DUMP = '/opt/sratoolkit.2.10.8-ubuntu64/bin/fastq-dump'

rule fetch_fastq:
    output: 'fastq_files/{acc}.fastq.gz',
    log: 'logs/{acc}.fastq_dump.log'
    shell:
        """
        mkdir -p 'fastq_files'
        mkdir -p 'logs'

        {FASTQ_DUMP} \
            --split-spot \
            --skip-technical {wildcards.acc} \
            --stdout 2>{log} \
        | gzip -c > {output}
        """