CANU = '/opt/canu-2.1.1/bin/canu'
MAKEBLASTDB = '/usr/bin/makeblastdb'
TBLASTN = '/usr/bin/tblastn'

nsps_cls = '/home/vadim/nsps.fn.cls'

rule run_canu:
    message: "Run canu on {wildcards.acc}"
    input: 'fastq_files/{acc}.fastq.gz',
    output: 
        canu_dir = directory('canu_assemblies/{acc}/'),
        canu_contigs = 'canu_assemblies/{acc}/{acc}.contigs.fasta',
    log: 'logs/{acc}.canu.log'
    shell:
        """
        mkdir -p canu_assemblies 
        mkdir -p {output.canu_dir}

        {CANU} \
            -p {wildcards.acc} \
            -d {output.canu_dir} genomeSize=30k \
            -nanopore {input} 2>{log}

        if [ ! -f {output.canu_contigs} ] ; then
            echo -e "Cannot find contigs file!" ;
            exit 1 ;
        fi
        """

rule run_nsps:
    input: rules.run_canu.output.canu_contigs,
    output: 'nsps/{acc}.nsps',
    params: 
        nsps_cls = nsps_cls,
    shadow: 'shallow'
    shell:
        """
        mkdir -p nsps

        {MAKEBLASTDB} \
            -input_type fasta \
            -in {input} \
            -title "{wildcards.acc} contigs" \
            -dbtype nucl 

        {TBLASTN} \
            -query {params.nsps_cls} \
            -db {input} \
            -outfmt 6 \
        > {output}
        """
