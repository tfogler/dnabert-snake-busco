
rule run_busco_from_link:
    output:
        f"{config['dir']}/{config['base']}.busco_summary_{config['busco_db']}.txt",
        f"{config['dir']}/{config['base']}.busco_table_{config['busco_db']}.tsv"
    params:
        link = config['link'],
        busco_db = config['busco_db'],
        base = config['base']
    threads:
        8
    conda:
        "config.yaml"
    shell:
        """
        # download assembly
        wget {params.link} --output-document temp.fasta.gz --quiet
        # gunzip assembly
        gunzip temp.fasta.gz -f
        busco -i temp.fasta -c {threads} --mode geno -o {params.base} -l {params.busco_db} -f
        mv {params.base}/run_{params.busco_db}/short_summary.txt {output[0]}
        mv {params.base}/run_{params.busco_db}/full_table.tsv {output[1]}
        """

