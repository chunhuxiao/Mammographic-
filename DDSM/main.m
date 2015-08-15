f = fopen('fileDescription_cancer01','r');
data = textscan(f,'%s %d %d %d %s','Delimiter',' ');
cancer01_features = [];
rootPath = './../figment.csee.usf.edu/pub/DDSM/cases/cancers/cancer_01/all/';
emptyCount = 0;
for i=1:size(data{1},1)
    %fileName = strcat(data{1}{i},'e','.pgm');
    fileName = data{1}{i}
    filePath = strcat(rootPath,fileName);
    overlayFilePath = strcat(rootPath,data{5}{i});
    i
    temp = featuresFromImage(filePath,data{2}(i), data{3}(i), data{4}(i), overlayFilePath);
   % if( size(temp,2)==26 && sum(temp(:,26) ) == 0)
   %     false_rejected = [ false_rejected,i];
   % end
   if( size(temp,1)==0)
       emptyCount = emptyCount + 1;
   end
   cancer01_features = [ cancer01_features;temp];
end
%save('cancer01.mat','cancer01_features');
rootPath = './../figment.csee.usf.edu/pub/DDSM/cases/benigns/benign_01/all/';
f = fopen('fileDescription_benign01','r');
data = textscan(f,'%s %d %d %d %s','Delimiter',' ');
benign01_features = [];
for i=1:size(data{1},1)
    %fileName = strcat(data{1}{i},'e','.pgm');
    fileName = data{1}{i}
    i
    filePath = strcat(rootPath,fileName);
    overlayFilePath = strcat(rootPath,data{5}{i});
    temp = featuresFromImage(filePath,data{2}(i), data{3}(i), data{4}(i), overlayFilePath);
   % if( size(temp,2)==26 && sum(temp(:,26) ) == 0)
   %     false_rejected = [ false_rejected,i];
   % end
    benign01_features = [ benign01_features;temp];
end
%save('benign01.mat','benign01_features');
rootPath = './../figment.csee.usf.edu/pub/DDSM/cases/normals/normal_01/all/';
f = fopen('fileDescription_normal01','r');
data = textscan(f,'%s %d %d %d %s','Delimiter',' ');
normal01_features = [];
for i=1:size(data{1},1)
    %fileName = strcat(data{1}{i},'e','.pgm');
    fileName = data{1}{i}
    i
    filePath = strcat(rootPath,fileName);
    overlayFilePath = strcat(rootPath,data{5}{i});
    temp = featuresFromImage(filePath,data{2}(i), data{3}(i), data{4}(i), overlayFilePath);
   % if( size(temp,2)==26 && sum(temp(:,26) ) == 0)
   %     false_rejected = [ false_rejected,i];
   % end
    normal01_features = [ normal01_features;temp];
end
save('normal01.mat','normal01_features');