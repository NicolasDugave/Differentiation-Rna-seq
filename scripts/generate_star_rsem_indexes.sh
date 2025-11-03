#!/bin/bash
#SBATCH -c 4
#SBATCH --mem=4096
#SBATCH -C cascadelake
#SBATCH -p cpu-preempt
#SBATCH -t 01:00:00
#SBATCH -o ../logs/slurm-%j.out
#SBATCH -e ../logs/slurm-error-%j.out

#module load microarch/cascadelake
module load star/2.7.9a
#module load gmp/6.2.1
module load rsem/1.3.3

# Generate reference indexes required for alignment to genome (STAR) or transcriptome (rsem)

STAR --runThreadN 4 \
     --runMode genomeGenerate \
     --genomeDir ../data/proc/genome_annot/star \
     --genomeFastaFiles ../data/raw/genomes/Naegr1_scaffolds.fasta \
     --sjdbGTFfile ../data/proc/genome_annot/Naegr1_complete_models_20240701.gtf \
     --genomeSAindexNbases 11

rsem-prepare-reference --gtf ../data/proc/genome_annot/Naegr1_complete_models_20240701.gtf \
    --star \
    --num-threads 4 \
    ../data/raw/genomes/Naegr1_scaffolds.fasta \
    ../data/proc/genome_annot/rsem/Naegr1.rsem
