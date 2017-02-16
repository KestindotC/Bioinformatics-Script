Practical Scripts for Bioinformatics
==========
These scripts were writen to fasten data analysis.  
So, just keep or download it if you need it. Or if you have any advice on them, please email me.   
Thank you very much.


這裡的程式碼只是加速我們在做研究的時候需要一些細碎的資料處理
如果你有需要可以直接下載
如果有更好的建議或者有錯誤可以用email通知我
謝謝

### combine_ReadCounts
原則上這支Script的效用不大，幫助跟我一樣傻傻沒看清楚就下了featureCount的人整合所有單筆跑出來的結果
使用featureCount可以直接下：
`featureCounts -t exon -g gene_id -a annotation.gtf -o counts.txt library1.bam library2.bam library3.bam`
但印象中[HTseq](http://www-huber.embl.de/users/anders/HTSeq/doc/overview.html)的使用上則無法達到，但也不需要寫程式，可以透過

```shell
awk 'NF > 1 {a[$1] = a[$1]"\t"$2} END {for( i in a ) print i a[i]}' $HTseq_DIR/*htseq.counts > Merged.htseq.counts""
```

### Reorganizer

傳輸進入的檔案會依照共有的標頭(Header)據重新排列產出原本數量的排列過後的檔案   
省去用R一直order sampleID的麻煩
```python
python Reorganizer.py -f file1.txt -f file2.txt -o <output_dir>
```




