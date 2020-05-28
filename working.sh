
# working dir
cd /mnt/griffin/chrwhe/Colias_crocea_genome

# genome file
ln /mnt/griffin/chrwhe/Ccro_scaffold12_assessment/assemblies/QPacBio_all_path_QPacBio_all_path_12_gap_filled_may_14.fa Colias_crocea_genome_V1.fa


# protein dataset
ln /mnt/griffin/chrwhe/Colias_crocea/Colias_crocea_editTrinity.okay.aa .


# copy here
scp chrwhe@miles.zoologi.su.se:/mnt/griffin/chrwhe/Colias_crocea_genome/*gz .
