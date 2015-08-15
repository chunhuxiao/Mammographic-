f = fopen('fileDescription.txt','r');
data = textscan(f,'%s %d %d %d %s','Delimiter',' ');
roi_features = [];
false_rejected = [];
for i=1:size(data{1},1)
    %fileName = strcat(data{1}{i},'e','.pgm');
    fileName = data{1}{i};
    temp = featuresFromImage(fileName,data{2}(i), data{3}(i), data{4}(i), data{5}{i});
   % if( size(temp,2)==26 && sum(temp(:,26) ) == 0)
   %     false_rejected = [ false_rejected,i];
   % end
    roi_features = [ roi_features;temp];
end
save('data.mat','roi_features');
%save('false.mat','false_rejected');
