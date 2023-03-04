import os
"""
Using 'mintask_in_out/' as project data
and using 2 config files:
- mintask_in_out/uconf_a/uconf_a.yml
- mintask_in_out/snake_config.yml 

the commands:
```
conda activate minsnake
cd $HOME
## with usual options
snakemake -s mintool_snake/Snakefile.smk --cores 1 
--configfiles mintask_in_out/uconf_a/uconf_a.yml mintask_in_out/snake_config.yml  


## with ADVANCED options:
snakemake -s mintool_snake/Snakefile.smk --cores 1 
--configfiles mintask_in_out/uconf_a/uconf_a.yml mintask_in_out/snake_config.yml  
 --config ADVANCED="--multiply_by 9 --supply_2nd_matrix mintask_in_out/data/matrix2.csv" 
```

see END for printing dag

"""
coficofi = os.path.expanduser(config["tool_config_file"])
rows_path = os.path.expanduser(config['rows_path'])
ipath  = os.path.expanduser(config['input_path'])
suffix = config['suffix']
outdir = os.path.expanduser(config['out_path'])
try:
    advanced_op = config['ADVANCED']
except Exception as e:
    advanced_op = ''
    print(e)
    print(advanced_op, "   ** !!! ")


rule all:
    input:
        f'{ipath}',
        f'{outdir}results/step1-{suffix}.csv',
        f'{outdir}results/step2-{suffix}.csv'


rule join_files:
    input:
        f'{ipath}'
    output :
        f'{outdir}results/step1-{suffix}.csv'
    shell:
        f"python -m mintool_snake.src.first_step {coficofi} "


rule second_step:
    input:
        f'{outdir}results/step1-{suffix}.csv'
    output:
        f'{outdir}results/step2-{suffix}.csv'
    shell:
        f'python -m mintool_snake.src.first_step {coficofi} {advanced_op}'


# snakemake --dryrun Snakefile --configfile XXXXXXXXXXX

# END

# Print DAG:
# conda install -c conda-forge python-graphviz
# snakemake -s mintool_snake/Snakefile.smk --cores 1
# --configfiles mintask_in_out/uconf_a/uconf_a.yml mintask_in_out/snake_config.yml
    # --config ADVANCED= --dag | dot -Tpdf > dag.pdf
