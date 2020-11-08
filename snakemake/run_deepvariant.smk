rule run_deepvariant:
    input: 
        bam_fn = 'bam_files/{acc}.sorted.bam',
    output:
        vcf_fn = touch('vcf_files/{acc}.vcf'),
        gvcf_fn = touch('vcf_files/{acc}.gvcf'),
    log: 'logs/{acc}.deepvariant.log'
    threads: 8
    shell:
        """
        set -x
        mkdir -p vcf_files

        sudo docker run \
            -v /data/ref:/ref \
            -v /data/snakemake_pipeline/bam_files:/bam_dir \
            -v /data/snakemake_pipeline/vcf_files:/vcf_dir:rw \
            -w / \
            google/deepvariant \
            /opt/deepvariant/bin/run_deepvariant \
            --model_type=WGS \
            --ref=/ref/GCF_009858895.2_ASM985889v3_genomic.fna \
            --reads=/bam_dir/{wildcards.acc}.sorted.bam \
            --output_vcf=/vcf_dir/{wildcards.acc}.vcf \
            --output_gvcf=/vcf_dir/{wildcards.acc}.gvcf \
            --num_shards={threads} >& {log}

        sudo chmod 777 {output.vcf_fn}
        sudo chmod 777 {output.gvcf_fn}
        """

rule filter_vcfs:
    input: 'vcf_files/{acc}.vcf',
    output: 'filtered_vcf_files/{acc}.filtered.vcf',
    shell:
        """
        /usr/bin/bcftools view -f 'PASS,.' {input} > {output}
        """