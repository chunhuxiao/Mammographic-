function [data] =  readData()
f = fopen('Data.txt','r');
data = textscan(f,'%s %s %s %s %d %d %d','Delimiter',' ');
end