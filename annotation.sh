######
# here we are using MESPA, which is a effectively a wrapper for spaln2, which uses the results to scaffold assemblies by proteins # and then generates a GFF file based upon the input protein sequences, as well as summary stats. We use it cause it works and is very fast # but there are perhaps other methods that are better, both for scaffolding and annotation (e.g. BRAKER)

# Neethiraj, R., Hornett, E.A., Hill, J.A., and Wheat, C.W. (2017). Investigating the genomic basis of discrete phenotypes using a Pool-Seq-only approach: New insights into the genetics underlying colour variation in diverse taxa. Molecular Ecology 26, 4990–5002.

mkdir annotation
cd annotation

cp /mnt/griffin/chrwhe/software/scritps/mespa_v1.cfg .

/data/programs/scripts/mespa_v1.3.py -h

# annotation with scaffolding by protein
/data/programs/scripts/mespa_v1.3.py -a ../Colias_crocea_genome_V1.fa -p ../Colias_crocea_editTrinity.okay.aa -s mespa_v1.cfg -c 4

# run
# Local current time (starting Spaln) : Thu May 28 10:20:11 2020
# /data/DB/annotation/spaln_db/seqdb/assembly_edited_20205281020113149-1.mfa
# /data/DB/annotation/spaln_db/seqdb
# make assembly_edited_20205281020113149-1.idx
# make assembly_edited_20205281020113149-1.bkp
# /data/programs/spaln2.1.4/bin/spaln -Q7 -LS -O1 -S3 -M1 -d assembly_edited_20205281020113149-1 -t 60 Colias_crocea_editTrinity.okay_reformatted.txt > spaln_assembly_edited.aln
# /data/programs/spaln2.1.4/bin/spaln -Q7 -LS -O0 -S3 -M1 -d assembly_edited_20205281020113149-1 -t 60 Colias_crocea_editTrinity.okay_reformatted.txt > spaln_assembly_edited.gff
# /data/programs/spaln2.1.4/bin/spaln -Q7 -LS -O4 -S3 -M1 -d assembly_edited_20205281020113149-1 -t 60 Colias_crocea_editTrinity.okay_reformatted.txt > spaln_assembly_edited.mb
# /data/programs/spaln2.1.4/bin/spaln -Q7 -LS -O7 -S3 -d assembly_edited_20205281020113149-1 -t 60 Colias_crocea_editTrinity.okay_reformatted.txt > spaln_translated_proteins_assembly_edited.fa
# Local current time (finished Spaln): Thu May 28 10:24:28 2020
#
#
#
# Local current time : Thu May 28 10:25:21 2020
# scaffolds built
# Local current time (starting Spaln): Thu May 28 10:25:23 2020
# /data/DB/annotation/spaln_db/seqdb/scaffolds_20205281025233149-1.mfa
# /data/DB/annotation/spaln_db/seqdb
# make scaffolds_20205281025233149-1.idx
# make scaffolds_20205281025233149-1.bkp
# /data/programs/spaln2.1.4/bin/spaln -Q7 -LS -O1 -S3 -M1 -d scaffolds_20205281025233149-1 -t 60 Colias_crocea_editTrinity.okay_reformatted.txt > spaln_scaffolds.aln
# /data/programs/spaln2.1.4/bin/spaln -Q7 -LS -O0 -S3 -M1 -d scaffolds_20205281025233149-1 -t 60 Colias_crocea_editTrinity.okay_reformatted.txt > scaffolds.gff
# /data/programs/spaln2.1.4/bin/spaln -Q7 -LS -O4 -S3 -M1 -d scaffolds_20205281025233149-1 -t 60 Colias_crocea_editTrinity.okay_reformatted.txt > spaln_scaffolds.mb
# /data/programs/spaln2.1.4/bin/spaln -Q7 -LS -O7 -S3 -d scaffolds_20205281025233149-1 -t 60 Colias_crocea_editTrinity.okay_reformatted.txt > spaln_translated_proteins_scaffolds.fa
# Local current time (finished running Spaln): Thu May 28 10:29:56 2020

more output_summary.txt

Protein file name: ../Colias_crocea_editTrinity.okay.aa
Number of proteins: 19906

Time taken for analysis
Local current time (starting Spaln) : Thu May 28 10:20:11 2020
Local current time (finished Spaln) : Thu May 28 10:24:28 2020
Local current time (starting Spaln) : Thu May 28 10:25:23 2020
Local current time (finished Spaln) : Thu May 28 10:29:56 2020


Validation statistics

Coverage statistics Pre-scaffolding
Number of proteins covered at over 90% coverage:        17768
Number of proteins covered at over 80% coverage:        18085
Number of proteins covered at over 70% coverage:        18330
Number of proteins covered at over 60% coverage:        18542
Number of proteins covered at over 50% coverage:        18737

Coverage statistics Post-scaffolding
Number of proteins covered at over 90% coverage:        18124
Number of proteins covered at over 80% coverage:        18349
Number of proteins covered at over 70% coverage:        18517
Number of proteins covered at over 60% coverage:        18641
Number of proteins covered at over 50% coverage:        18776

Fragmentation statistics
Number of unscaffolded proteins: 3059
Number of proteins scaffolded with 2 contigs: 423
Number of proteins scaffolded with 3 contigs: 68
Number of proteins scaffolded with 4 contigs: 5


grep -c '>' *.fa
assembly_edited.fa:8499 # reformated input genome file
onlygenemodels.fa:3573 # only scaffolds for which gff annotations exist
remaining_contigs.fa:4343 # other scaffolds without annotations
scaffolds.fa:7916 # all the scaffolds (onlygenemodels + remaining_contigs)

ln annotation/scaffolds.fa Colias_crocea_genome_V1_mespa_scaffolded.fa
ln annotation/scaffolds.gff Colias_crocea_genome_V1_mespa_scaffolded.gff

# assessment
# extract CDS and protein
reference=Colias_crocea_genome_V1_mespa_scaffolded.fa
gff_file=Colias_crocea_genome_V1_mespa_scaffolded.gff
/data/programs/cufflinks-2.2.1.Linux_x86_64/gffread "$gff_file" \
-g "$reference" -x "$reference"_cds.fa -y "$reference"_prot.fa

grep -c '>' *.fa
# Colias_crocea_genome_V1_mespa_scaffolded.fa_cds.fa:19404
# Colias_crocea_genome_V1_mespa_scaffolded.fa_prot.fa:19404

#
