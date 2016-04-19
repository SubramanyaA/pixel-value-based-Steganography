function [datared, datagreen, datablue]= findtext_pixel(eachpixelvalue, text, messageType, keysizedivide)
sz1=size(eachpixelvalue);

size11 = sz1(2);

size12 = sz1(1);

sz2=size(text);

if messageType == 0
    size2=sz2(2);
    
    datared = zeros(1,size2);
    datagreen = datared;
    datablue = datared;

% disp(eachpixelvalue);

for k = 1 : size2
    i = text(k)-((idivide(uint32(text(k)), size11, 'floor'))*size11);
    j = idivide(uint32(text(k)), size11, 'floor')+1;
    datared(k) = eachpixelvalue(i,j);
    
       
end

else
    size2 = sz2(1)*sz2(2);


datared = zeros(1,keysizedivide+2);

datagreen = zeros(1,keysizedivide+2);

datablue = zeros(1,keysizedivide+2);

%  disp(keysizedivide);

for k = 1 : keysizedivide
    i = text(k)-((idivide(uint32(text(k)), size11, 'floor'))*size11);
    j = (idivide(uint32(text(k)), size11, 'floor'))+1;
    datared(k) = bitand(eachpixelvalue(i,j),255);
    
       
end

datared(keysizedivide+1) = text(end-1);
datared(keysizedivide+2) = text(end);



for k = (keysizedivide+3) : (keysizedivide+keysizedivide+2)
    i = text(k)-((idivide(uint32(text(k)), size11, 'floor'))*size11);
    j = (idivide(uint32(text(k)), size11, 'floor'))+1;
    datagreen(k-keysizedivide-2) = bitand(eachpixelvalue(i,j),255);
    
       
end

datagreen(keysizedivide+1) = text(end-1);
datagreen(keysizedivide+2) = text(end);



for k = (keysizedivide+keysizedivide+5) : (keysizedivide+keysizedivide+keysizedivide+4)
    i = text(k)-((idivide(uint32(text(k)), size11, 'floor'))*size11);
    j = (idivide(uint32(text(k)), size11, 'floor'))+1;
    datablue(k-keysizedivide-keysizedivide-4) = bitand(eachpixelvalue(i,j),255);
    
       
end

datablue(keysizedivide+1) = text(end-1);
datablue(keysizedivide+2) = text(end);

end

%disp(data);
return
 