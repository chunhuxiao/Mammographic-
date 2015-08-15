f = fopen('databaseMarks.txt','r');
data = textscan(f,'%s %d %d %d','Delimiter',' ');
roi_features = [];
false_rejected = [];
for i=24:24 %size(data{1},1)
    fileName = strcat(data{1}{i},'e','.pgm');
    if(data{2}(i)==2)
        row = data{3}(i);
        col = data{4}(i);
    else
        %continue;
        row = -1;
        col = -1;
    end
    temp = featuresFromImage(fileName,row,col);
   % if( size(temp,2)==26 && sum(temp(:,26) ) == 0)
   %     false_rejected = [ false_rejected,i];
   % end
    roi_features = [ roi_features;temp];
end
save('data.mat','roi_features');
%save('false.mat','false_rejected');