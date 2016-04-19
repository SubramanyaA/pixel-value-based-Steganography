function [a, b, c, notFound1, notFound2, notFound3] = hidetext_pixel(eachpixelvalue,text1, text2, text3, messageType)



sz1=size(eachpixelvalue);

size11 = sz1(1);

size12 = sz1(2);

sz21=size(text1);

sz22 = size(text2);

sz23 = size(text3);

if messageType == 0
    size21=sz21(1);
    
    a = zeros(1,size21);

selected1 = zeros(1,size21);

notFound1 = zeros(1,size21);

% size22=sz22(1);
%     
%     b = zeros(1,size22);
% 
% selected2 = zeros(1,size22);
% 
% notFound2 = zeros(1,size22);
% 
% size23=sz23(1);
%     
%     c = zeros(1,size21);
% 
% selected3 = zeros(1,size23);
% 
% notFound3 = zeros(1,size23);

sizealpha = 256;

alphavalues = zeros(1,sizealpha);

alphavalues1 = zeros(1,sizealpha);

selecteda = zeros(1,sizealpha);


% for m = 1 : sizealpha
%     alphavalues(m) = m - 1;
% end
% 
% 
% for n = 1:sizealpha
%     if(selecteda(n) == 0)
%         for i = 1:size11
%         %read1 = 0;
%             if(selecteda(n) == 0)
%                 for j=1:size12
%                     if bitand(alphavalues(n),255)== eachpixelvalue(i,j) && selecteda(n) == 0
%                         alphavalues1(n)=(i+((j-1)*size12));
%                         selecteda(n) = 1;
%                         
%                         break;
%                     end
%                 end
%             end
%         end
%     end
% end


for k = 1 : size21
    if(selected1(k) == 0)
        
        for i = 1:size11
        %read1 = 0;
            if(selected1(k) == 0)
                for j=1:size12
%                 disp(size12);
%                 disp('1');
%               disp(bitand(text(k),255));
                    if bitand(text1(k),255)== eachpixelvalue(i,j) && selected1(k) == 0
                        a(k)=(i+((j-1)*size12));
                        selected1(k) = 1;
                
                        %disp(a(k),k,i,j,sz1);
                        %read1 = 1;
                
                        break;
                    end
                end
            end
        end
    end
    if(a(k))==0
        notFound1(k) = 1;
    else
        notFound1(k) = 0;
        
    end
end

% for k = 1 : size22
%     if(selected2(k) == 0)
%         
%         for i = 1:sizealpha
%         %read1 = 0;
% %             if(selected(k) == 0)
% %                 for j=1:size12
%                 %disp(size12);
%                 %disp('1');
% %               disp(bitand(text(k),255));
%                     if bitand(text2(k),255)== alphavalues(i) && selected2(k) == 0
%                         b(k)=alphavalues1(i);
%                         selected2(k) = 1;
%                 
%                         %disp(a(k),k,i,j,sz1);
%                         %read1 = 1;
%                 
%                         break;
%                     end
% %                 end
% %             end
%         end
%     end
%     if(b(k))==0
%         notFound2(k) = 1;
%     else
%         notFound2(k) = 0;
%         
%     end
% end
% 
% for k = 1 : size23
%     if(selected3(k) == 0)
%         
%         for i = 1:sizealpha
%         %read1 = 0;
% %             if(selected(k) == 0)
% %                 for j=1:size12
%                 %disp(size12);
%                 %disp('1');
% %               disp(bitand(text(k),255));
%                     if bitand(text3(k),255)== alphavalues(i) && selected3(k) == 0
%                         c(k)=alphavalues1(i);
%                         selected3(k) = 1;
%                 
%                         %disp(a(k),k,i,j,sz1);
%                         %read1 = 1;
%                 
%                         break;
%                     end
% %                 end
% %             end
%         end
%     end
%     if(c(k))==0
%         notFound3(k) = 1;
%     else
%         notFound3(k) = 0;
%         
%     end
% end

% text = 0;


b = a;
c = a;

notFound2 = notFound1;
notFound3 = notFound1;
else
    size21 = sz21(1)*sz21(2);
    
    size22 = sz22(1)*sz22(2);
    
    size23 = sz23(1)*sz23(2);


a = zeros(1,size21+2);

b = zeros(1,size22+2);

c = zeros(1,size23+2);

selected1 = zeros(1,size21+2);

notFound1 = zeros(1,size21+2);

selected2 = zeros(1,size22+2);

notFound2 = zeros(1,size22+2);

selected3 = zeros(1,size23+2);

notFound3 = zeros(1,size23+2);

sizealpha = 256;

alphavalues = zeros(1,sizealpha);

alphavalues1 = zeros(1,sizealpha);

selecteda = zeros(1,sizealpha);

for m = 1 : sizealpha
    alphavalues(m) = m - 1;
end


for n = 1:sizealpha
    if(selecteda(n) == 0)
        for i = 1:size11
        %read1 = 0;
            if(selecteda(n) == 0)
                for j=1:size12
                    if bitand(alphavalues(n),255)== eachpixelvalue(i,j) && selecteda(n) == 0
                        alphavalues1(n)=(i+((j-1)*size12));
                        selecteda(n) = 1;
                        
                        break;
                    end
                end
            end
        end
    end
end


% disp(eachpixelvalue);

for k = 1 : size21
    if(selected1(k) == 0)
        
        for i = 1:sizealpha
        %read1 = 0;
%             if(selected(k) == 0)
%                 for j=1:size12
                %disp(size12);
                %disp('1');
%               disp(bitand(text(k),255));
                    if bitand(text1(k),255)== alphavalues(i) && selected1(k) == 0
                        a(k)=alphavalues1(i);
                        selected1(k) = 1;
                
                        %disp(a(k),k,i,j,sz1);
                        %read1 = 1;
                
                        break;
                    end
%                 end
%             end
        end
    end
    if(a(k))==0
        notFound1(k) = 1;
    else
        notFound1(k) = 0;
        
    end
end

for k = 1 : size22
    if(selected2(k) == 0)
        
        for i = 1:sizealpha
        %read1 = 0;
%             if(selected(k) == 0)
%                 for j=1:size12
                %disp(size12);
                %disp('1');
%               disp(bitand(text(k),255));
                    if bitand(text2(k),255)== alphavalues(i) && selected2(k) == 0
                        b(k)=alphavalues1(i);
                        selected2(k) = 1;
                
                        %disp(a(k),k,i,j,sz1);
                        %read1 = 1;
                
                        break;
                    end
%                 end
%             end
        end
    end
    if(b(k))==0
        notFound2(k) = 1;
    else
        notFound2(k) = 0;
        
    end
end

for k = 1 : size23
    if(selected3(k) == 0)
        
        for i = 1:sizealpha
        %read1 = 0;
%             if(selected(k) == 0)
%                 for j=1:size12
                %disp(size12);
                %disp('1');
%               disp(bitand(text(k),255));
                    if bitand(text3(k),255)== alphavalues(i) && selected3(k) == 0
                        c(k)=alphavalues1(i);
                        selected3(k) = 1;
                
                        %disp(a(k),k,i,j,sz1);
                        %read1 = 1;
                
                        break;
                    end
%                 end
%             end
        end
    end
    if(c(k))==0
        notFound3(k) = 1;
    else
        notFound3(k) = 0;
        
    end
end
a(size21 + 1) = sz21(1);

a(size21 + 2) = sz21(2);

b(size22 + 1) = sz22(1);

b(size22 + 2) = sz22(2);

c(size23 + 1) = sz23(1);

c(size23 + 2) = sz23(2);

end

% text = 0;

return