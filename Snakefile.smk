import os
"""
snakemake -s mintool_snake/Snakefile.smk --cores 1 --configfiles mintask_in_out/uconf_a/uconf_a.yml mintask_in_out/snake_config.yml 
--latency-wait=10 --config ADVANCED="--noBestiol --fii 8 --lero 7" 

"""
coficofi = os.path.expanduser(config["fuckingfile"])
rows_path = os.path.expanduser(config['rows_path'])
ipath  = os.path.expanduser(config['input_path'])
suffix = config['suffix']
outdir = os.path.expanduser(config['out_path'])

advanced_op = config['ADVANCED']


rule all:
    input:
        f'{ipath}',
        f'{outdir}results/xx-yy-{suffix}.csv'


rule join_files:
    input:
        f'{ipath}'
    output :
        f'{outdir}results/xx-yy-{suffix}.csv'
    shell:
        f"python -m mintool_snake.src.first_step {coficofi}"


rule second_step:
    input:
        f'{outdir}results/xx-yy-{suffix}.csv'
    output:


#         f'{rows_path}'




# snakemake --dryrun Snakefile --configfile XXXXXXXXXXX