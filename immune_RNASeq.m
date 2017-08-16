%% RNA-Seq analysis matrix reading:
%  For reading into specific gene set
addpath(pwd);
[num,txt,raw]=xlsread('GSE79338_BrainRNAseq.xlsx');

SampleID=txt(1,2:end)';
gene_symbol=txt(2:end,1);
exp=num;
exp(find(exp==0))=1;

%% Normalization(Log2-transofrm and Z transform)
exp=log2(exp);
[m,n] = size(exp);
Avg=mean(exp,2);
stdev= std(exp,0,2);
data_z=(exp-repmat(Avg,1,n))./repmat(stdev,1,n);

%% Gene set reading
cd ../ImmuneGeneSet/
dir_name=struct2cell(dir('*.txt'));
gene_set_name=(dir_name(1,:))';
fid=fopen('Immune_gene_mismatch.txt','w');
for set_index=1:length(gene_set_name);
geneset=textread(gene_set_name{set_index},'%s');
GENESET=gene_set_name{set_index}(1:length(gene_set_name{set_index})-4);
fprintf(fid,'%s\t',GENESET);
[ttt,loc] = ismember(upper(geneset),upper(gene_symbol));
badgenes=geneset(ttt==0);

fprintf(fid,'%s\t',badgenes{:});
fprintf(fid,'NaN\t');
loc=loc(loc>0);
immuno_gene_id=gene_symbol(loc);
Data_z_filtered=data_z(loc,:);
idx=find(isnan(Data_z_filtered(:,1))==1);
nogene=immuno_gene_id(idx);
fprintf(fid,'%s\t',nogene{:});
fprintf(fid,'\n');
ESscore(set_index,:)=nanmean(Data_z_filtered,1);
end

fclose('all');
