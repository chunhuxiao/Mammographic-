function [m,n] = getPosition(filename)
  
fileID = fopen('mias_db_info.txt','r');

tline = fgets(fileID);

while ischar(tline)
    C = strsplit(tline);
    s1 = char(C(1));
    
    if (s1 == filename)
        if (size(C,2) < 6 )
            m = 0;
            n = 0;
        else
         m = 1025-str2double(char(C(5)));
         n = str2double(char(C(6)));
        end
    end
    
    tline = fgets(fileID);
end

end
