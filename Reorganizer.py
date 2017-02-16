# Reorganizer.py
import copy
import numpy
import pandas as pd
import argparse as ap

global df_list
df_list = []


def parse_file(inputfile):
    df = pd.DataFrame.from_csv(inputfile,header=0, sep='\t',index_col=0)
    df_list.append(copy.copy(df))
    samples = list(df.columns)
    return samples


# Parse command line options, return the option list
def parse_args():

    desc = '''
    This script will reorganize input files depending on first row (header).
    Tab deliminate required!
    For example,

        A1     A2     A3     A4
    F1  2      3      1      3
    F2  0.1    0.2    2.1    -0.3
    F3  -0.4   0.45   2.1    4
    F4  -2     -1.3   3.1    0

    Headers [A1, A2, A3, A4] will be extracted and compare between two files
    Intersection between samples will write into output with same order.
    (You will lose samples in ONLY one files.)
    For more information please contact me. Thank you.'''


    parser = ap.ArgumentParser(prog='Rerorganizer.py',
                               formatter_class=ap.RawDescriptionHelpFormatter,
                               description=desc,
                               add_help=True)
    p_addarg = parser.add_argument
    # make the function name shorter

    # --- output ---
    p_addarg('-o', '--outdir',
             metavar='OUT_DIR',
             action='store',
             dest='out_dir',
             help='''Set the ouput directory. E.g. /home/user/project/''')



    # --- files ---
    p_addarg('-f','--file',metavar='input_file',
             action='append',
             dest='inputfiles',
             help='''Files need to reorganize sample. Please input more than 2 files.
                     e.g. -f file.txt -f anotherfile.txt ... ''')




    args = parser.parse_args()
    return args




def intersection(vector1,vector2):
    return list(set(vector1) & set(vector2))


# Utilizing intersect sampleID to reorder orginal matrices
def reorder_matrix(sampleID,args):
    count = 0
    # Checking output dir format
    check_outdir = args.out_dir[-1:]
    if check_outdir == '/':
        outdir = args.out_dir
    else:
        outdir = args.out_dir+"/"

    for dataframe in df_list:
        reorder_df = dataframe[sampleID]
        name = args.inputfiles[count].split('/').pop()
        filename = "reordered_"+name
        reorder_df.to_csv(outdir+filename, sep='\t', encoding='utf-8')
        count += 1



def main():
    args = parse_args()
    #print(args.inputfiles)
    s1 = parse_file(args.inputfiles[0])
    s2 = parse_file(args.inputfiles[1])
    final_sample_order = intersection(s1,s2)
    reorder_matrix(final_sample_order,args)



if __name__ == '__main__':
	main()
