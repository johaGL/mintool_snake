import numpy as np
import pandas as pd
import os
import argparse
import yaml
import seaborn as sns
import matplotlib.pyplot as plt

## TODO: check this library : https://docs.python.org/3/howto/logging.html



def first_args():
    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('config', type = str,
                        help= "config file")

    parser.add_argument("--multiply_by", type=float, default=1,
                        help="a float")

    parser.add_argument("--supply_2nd_matrix", type=str, default=None,
                        help="add matrix 2 here")
    return parser

def sum_rownames(rownames, matrix1):
    return matrix1

def divide_simple(matrix1, simpledf):
    return matrix1

def detect_and_create_dir(namenesteddir):
    if not os.path.exists(namenesteddir):
        os.makedirs(namenesteddir)


if __name__ == "__main__":
    # matrix1 = np.ones((5,2))
    # matrix2 = np.random.randint(1,8, size=(5, 2))
    # m1 = pd.DataFrame(matrix1)
    # m2 = pd.DataFrame(matrix2)
    # two_col = pd.DataFrame({'n': ['a', 'b'], 'o': [10, 100]})
    # os.chdir("/home/johanna/mintask_in_out/data/")
    # m1.to_csv("matrix1.csv")
    # m2.to_csv("matrix2.csv")
    # two_col.to_csv("simpledf.csv")

    # This minimal tool will be executed by snakemake

    parser = first_args()
    args  = parser.parse_args()

    with open(args.config) as f:
        confidic = yaml.load(f, Loader=yaml.Loader)

    outdir = os.path.expanduser(confidic["out_path"])

    detect_and_create_dir(f"{outdir}results/")
    fii = pd.read_csv(confidic['rows_path'], header=0, index_col=0)
    fii.to_csv(f'{outdir}results/step1-{confidic["suffix"]}.csv')

    plots_out = f"/home/johanna/mintask_in_out/uconf_a/results/plots/"
    detect_and_create_dir(plots_out)
    current_palette = sns.color_palette()
    sns.palplot(current_palette)
    plt.savefig(plots_out+"koro.pdf")

    # end step1

    fuu = pd.read_csv(confidic['input_path'], header=0, index_col=0)
    fuu.index = fii.index
    sortie2 = fuu.multiply(fii['value'], axis=0)
    print(sortie2)
    # using advanced options :

    print(args.multiply_by, " <==")

    if args.supply_2nd_matrix is not None:
        print("using parameter suppy_2nd_matrix as is injected")
        foo = pd.read_csv(args.supply_2nd_matrix,  header=0, index_col=0)
        foo = foo.multiply(args.multiply_by)
        foo.to_csv(f'{outdir}results/secondMat_procesed-{confidic["suffix"]}.csv')


    sortie2.to_csv(f'{outdir}results/step2-{confidic["suffix"]}.csv')












