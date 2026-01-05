# #!/bin/bash

# python3 -m bsbolt Align -F1 ../PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R2_001_val_1.fq.gz -F2 ../PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R1_001_val_2.fq.gz \
#     -DB /work4/home/yenmr/tools/bsbolt/Index/hg19 -O ./SGLTiFU-140_V3_hg19_bsbolt_PE.bam -t 15 &
# python3 -m bsbolt Align -F1 ../PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R2_001_val_1.fq.gz -F2 ../PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R1_001_val_2.fq.gz \
#     -DB /work4/home/yenmr/tools/bsbolt/Index/hg19 -O ./SGLTiFU-143_V1_hg19_bsbolt_PE.bam -t 15 &
# python3 -m bsbolt Align -F1 ../PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R2_001_val_1.fq.gz -F2 ../PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R1_001_val_2.fq.gz \
#     -DB /work4/home/yenmr/tools/bsbolt/Index/hg19 -O ./SGLTiFU-148_V1_hg19_bsbolt_PE.bam -t 15 &

# wait
# echo "hg19 mapping jobs done."

### Methylation Calling Pre-Processing
# fixmates to prepare for duplicate removal, use -p to disable proper pair check
samtools fixmate -p -m SGLTiFU-140_V3_hg19_bsbolt_PE.bam.bam SGLTiFU-140_V3_hg19_bsbolt_PE.fixmates.bam &
samtools fixmate -p -m SGLTiFU-143_V1_hg19_bsbolt_PE.bam.bam SGLTiFU-143_V1_hg19_bsbolt_PE.fixmates.bam &
samtools fixmate -p -m SGLTiFU-148_V1_hg19_bsbolt_PE.bam.bam SGLTiFU-148_V1_hg19_bsbolt_PE.fixmates.bam &
wait
# sort bam by coordinates for duplicate calling
samtools sort -@ 2 -o SGLTiFU-140_V3_hg19_bsbolt_PE.sorted.bam SGLTiFU-140_V3_hg19_bsbolt_PE.fixmates.bam &
samtools sort -@ 2 -o SGLTiFU-143_V1_hg19_bsbolt_PE.sorted.bam SGLTiFU-143_V1_hg19_bsbolt_PE.fixmates.bam &
samtools sort -@ 2 -o SGLTiFU-148_V1_hg19_bsbolt_PE.sorted.bam SGLTiFU-148_V1_hg19_bsbolt_PE.fixmates.bam &
wait
# remove duplicate reads
samtools markdup SGLTiFU-140_V3_hg19_bsbolt_PE.sorted.bam SGLTiFU-140_V3_hg19_bsbolt_PE.dup.bam &
samtools markdup SGLTiFU-143_V1_hg19_bsbolt_PE.sorted.bam SGLTiFU-143_V1_hg19_bsbolt_PE.dup.bam &
samtools markdup SGLTiFU-148_V1_hg19_bsbolt_PE.sorted.bam SGLTiFU-148_V1_hg19_bsbolt_PE.dup.bam &
wait
# index bam file for methylation calling
samtools index SGLTiFU-140_V3_hg19_bsbolt_PE.dup.bam &
samtools index SGLTiFU-143_V1_hg19_bsbolt_PE.dup.bam &
samtools index SGLTiFU-148_V1_hg19_bsbolt_PE.dup.bam &
wait
echo "hg19 pre-processing done."

python3 -m bsbolt CallMethylation -I SGLTiFU-140_V3_hg19_bsbolt_PE.dup.bam -DB /work4/home/yenmr/tools/bsbolt/Index/hg19 \
    -O SGLTiFU-140_V3_hg19_bsbolt_PE.methylation.txt -t 10 &
python3 -m bsbolt CallMethylation -I SGLTiFU-143_V1_hg19_bsbolt_PE.dup.bam -DB /work4/home/yenmr/tools/bsbolt/Index/hg19 \
    -O SGLTiFU-143_V1_hg19_bsbolt_PE.methylation.txt -t 10 &
python3 -m bsbolt CallMethylation -I SGLTiFU-148_V1_hg19_bsbolt_PE.dup.bam -DB /work4/home/yenmr/tools/bsbolt/Index/hg19 \
    -O SGLTiFU-148_V1_hg19_bsbolt_PE.methylation.txt -t 10 &

wait
echo "hg19 methylation calling done."