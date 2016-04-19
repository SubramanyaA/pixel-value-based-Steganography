function varargout = Gui_Steg(varargin)

% Pixel Value Based Image Steganography
% Author - Subramanya. A. Iyer
% Email - subramanyaaiyer@gmail.com

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui_Steg_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui_Steg_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% --- Executes just before Gui_Steg is made visible.
function Gui_Steg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui_Steg (see VARARGIN)

% Choose default command line output for Gui_Steg
handles.output = hObject;

a=ones(256,256);
axes(handles.axes1);
imshow(a);
axes(handles.axes2);
imshow(a);
axes(handles.axes4);
imshow(a);
axes(handles.axes5);
imshow(a);
axes(handles.axes6);
imshow(a);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui_Steg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gui_Steg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  [filename,pathname] = uigetfile({'*.bmp';'*.jpg';'*.png';'*.gif';'*.tif'},'Pick an Image');
%         msg = imread( strcat(PathName,FileName) );
%         
%         [filename, pathname] = uigetfile('*.*', 'Pick an Image');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
       InputImage=imread(strcat(pathname,filename));
       axes(handles.axes1);
       handles.InputImage=InputImage;
       imshow(InputImage);
       
    end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in Datahiding.
function Datahiding_Callback(hObject, eventdata, handles)
% hObject    handle to Datahiding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
original=handles.InputImage;
target=handles.InputImage;
%fid = fopen('message.txt','r');
%F = fread(fid);
%s = char(F');
%fclose(fid);

message = handles.message;

% disp(message);

F = message;

% F = fread(message);
% s = char(F');
% fclose(message);

%F = message;
%s=char(F');

% disp(F);

sz1=size(original);
size1=sz1(1)*sz1(2);
sz2=size(F);
if handles.messageType == 0
    size2=sz2(1);
else
    size2 = sz2(1)*sz2(2);
end


if size2> size1 
    fprintf('\nImage File Size  %d\n',size1);
    fprintf('Text  File Size  %d\n',size2);
    disp('Text File is too Large');
else
    fprintf('\nImage File Size  %d\n',size1);
    fprintf('Text  File Size  %d\n',size2);
    disp('Text File is Small or Equal');
    i=1;j=1;k=1;
        while k<=size2
        a=F(k);
        o1=original(i,j,1);
        o2=original(i,j,2);
        o3=original(i,j,3);
        
        [r1,r2,r3]=hidetext(o1,o2,o3,a); 
        
        target(i,j,1)=r1;
        target(i,j,2)=r2;
        target(i,j,3)=r3;
        
            if(i<sz1(1))
                i=i+1;
            else
                i=1;
                j=j+1;
            end
            k=k+1;
        end
        width=sz1(1);
        txtsz=size2;
        n=size(original);
        target(n(1),n(2),1)=txtsz;% Text Size
        target(n(1),n(2),2)=width;% Image's Width
        
        
        %save secret.mat target;% txtsz width;
        imwrite(target,'secret.bmp','bmp');
       
       axes(handles.axes2),imshow(target)
    
end
    

helpdlg('data hided succesfully in secret.bmp');

function pixelvaluefinding_Callback(hObject, eventdata, handles)
% hObject    handle to Datahiding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
original=handles.InputImage;
% target=handles.InputImage;
%axes(handles.axes2),imshow(original);

I = (original);

messageType = handles.messageType;

% Get edit text
% Display it on a static text label
%set(handles.text6, 'String', int2str(szi));
%abc(1,2)=1;


%imwrite(target,'custom.bmp','bmp');

message = handles.message;

eachPixelValueRed = I(:,:,1);

% eachPixelValueGreen = I(:,:,2);
% 
% eachPixelValueBlue = I(:,:,3);
if(messageType == 0)
    [a, b, c, notFound1, notFound2, notFound3] = hidetext_pixel(eachPixelValueRed, message, message, message, messageType);
    
    handles.a = a;
    
    sizea = size(a);
    
    sizeaa = sizea(1)*sizea(2);
    
    a1234 = zeros(1,sizeaa);
    
    for i = 1:sizeaa
%     disp(i);
    a1234(i) = (uint32(a(i)));
    

    end
    
    imgdata = I;

afinal = num2str(a1234);

fid = fopen('hiddenFileRed.txt','w');
        fprintf(fid,'%d,\n',a1234);
        fclose(fid);

else
    
message1 = message(:,:,1);

message2 = message(:,:,2);

message3 = message(:,:,3);
% disp(eachPixelValue1);
% 
% eachPixelValue = idivide(eachPixelValue1, 3, 'round');
[a, b, c, notFound1, notFound2, notFound3] = hidetext_pixel(eachPixelValueRed, message1, message2, message3, messageType);

% [b, notFound2] = hidetext_pixel(eachPixelValueGreen, message2, messageType);
% 
% [c, notFound3] = hidetext_pixel(eachPixelValueBlue, message3, messageType);
% imgdata = imread('custom.bmp');
% 


%sz2 = size(target);
%set(handles.text6, 'String', int2str(I(1:1:1)));

handles.a = a;

handles.b = b;

handles.c = c;

sizea = size(a);

sizeb = size(b);

sizec = size(c);

% disp(sizea);

sizeaa = sizea(1)*sizea(2);

sizebb = sizeb(1)*sizeb(2);

sizecc = sizec(1)*sizec(2);

a1234 = zeros(1,sizeaa+sizebb+sizecc);

for i = 1:sizeaa
%     disp(i);
    a1234(i) = (uint32(a(i)));
    

end

for j = (sizeaa + 1):(sizeaa+sizebb)
%     disp(i);
    a1234(j) = (uint32(b(j-sizeaa)));
    

end

for k = (sizeaa+sizebb +1):(sizeaa+sizebb+sizecc)
%     disp(i);
    a1234(k) = (uint32(c(k-sizeaa-sizebb)));
    

end

% disp(a1234)


        
imgdata = I;

afinal = num2str(a1234);

% fid = fopen('hiddenFileRed.txt','w');
%         fprintf(fid,'%d,\n',a1234);
%         fclose(fid);
% 
% bfinal = b1234;
% 
% fid = fopen('hiddenFileGreen.txt','w');
%         fprintf(fid,'%d,\n',b1234);
%         fclose(fid);
% 
% cfinal = c1234;
% 
% fid = fopen('hiddenFileBlue.txt','w');
%         fprintf(fid,'%d,\n',c1234);
%         fclose(fid);
% 
% final = strcat(num2str(afinal),'  ', num2str(bfinal),'  ', num2str(cfinal));

fid = fopen('hiddenFile.txt','w');
        fprintf(fid,'%s,\n',afinal);
        fclose(fid);
        
end

t = Tiff('custom.tif','w');

tagstruct.ImageLength = size(imgdata,1);
tagstruct.ImageWidth = size(imgdata,2);
tagstruct.Photometric = Tiff.Photometric.RGB;
tagstruct.BitsPerSample = 8;
tagstruct.SamplesPerPixel = 3;
tagstruct.RowsPerStrip = 16;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
tagstruct.Software = 'MATLAB';
tagstruct.ImageDescription = afinal;
t.setTag(tagstruct);

t.write(imgdata);

t.close();



axes(handles.axes4),imshow('custom.tif');

%disp(eachPixelValue);
helpdlg('Pixel Value found and traced Successfully');

guidata(hObject, handles);


% --- Executes on button press in DataRetrive.
function DataRetrive_Callback(hObject, eventdata, handles)
% hObject    handle to DataRetrive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 target=handles.Stego;
        n=size(target);
        txtsz=target(n(1),n(2),1);% Text Size
        width=target(n(1),n(2),2);% Image's Width

        
        i=1;j=1;k=1;
        while k<=txtsz
        
        r1=target(i,j,1);
        r2=target(i,j,2);
        r3=target(i,j,3);
        
        R(k)=findtext(r1,r2,r3);
                
                if(i<width)
                    i=i+1;
                else
                    i=1;
                    j=j+1;
                end
                k=k+1;
        end
        
        if(handles.messageType == 0)
            fid = fopen('secret.txt','wb');
            fwrite(fid,char(R),'char');
            fclose(fid);
            helpdlg('Data retrieved back in secret.txt');

        else
        
        imwrite(R,'retrieved.bmp','bmp');
        helpdlg('Image retrieved back in retrieved.bmp');

        
        end
   

% --- Executes on button press in message.
function message_Callback(hObject, eventdata, handles)
% hObject    handle to message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Next get Message File
        [FileName,PathName] = uigetfile('*.txt','Select TEXT MESSAGE.');
        testmsg = fopen( strcat(PathName,FileName),'r' );
        %[msg] = fscanf(testmsg,'%c');
        
        
        %fid = fopen('message.txt','r');
        fid = testmsg;
        F = fread(fid);
%         s = char(F');
        fclose(fid);
        
        handles.message = F;
        
        handles.keysize1 = size(F);
        
        handles.keysize2 = 1;
        
        handles.messageType = 0; % type is 0 for text message
%         
%         disp(F);
        
        guidata(hObject, handles);
    
    %open('message.txt');

function image_message_Callback(hObject, eventdata, handles)
% hObject    handle to message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Next get Message File
    
        [FileName,PathName] = uigetfile({'*.bmp';'*.png';'*.gif';'*.jpg';'*.tif'},'Select IMAGE MESSAGE.');
        if isequal(FileName,0) || isequal(PathName,0)
       warndlg('User pressed cancel')
        else
            msg = imread( strcat(PathName,FileName) );
        
        handles.message = msg;
        
        keysize = size(msg);
        
        handles.keysize1 = keysize(1);
        
        handles.keysize2 = keysize(2);
        
        handles.messageType = 1; % type is 1 for image message
        end
        guidata(hObject, handles);
        
        
    
    %open('message.txt');

% --- Executes on button press in browsestegoimage.
function browsestegoimage_Callback(hObject, eventdata, handles)
% hObject    handle to browsestegoimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  [filename, pathname] = uigetfile({'*.bmp';'*.png';'*.gif';'*.jpg';'*.tif'}, 'Pick an Image');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
       InputImage=imread(strcat(pathname,filename));
       axes(handles.axes2);
       handles.Stego=InputImage;
       imshow(InputImage);
       
    end
 
    % Update handles structure
guidata(hObject, handles);


% --- Executes on button press in openretrievedmessage.
function openretrievedmessage_Callback(hObject, eventdata, handles)
% hObject    handle to openretrievedmessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(handles.messageType == 0)
    testmsg = fopen( 'secret.txt' );
    [msg] = fscanf(testmsg,'%c');
    % Display it on a static text label
    set(handles.text6, 'String', msg);
else
    set(handles.text6, 'String', 'Image Message');
    axes(handles.axes6);
    imshow('main.bmp');
    axes(handles.axes5);
    imshow('secret1.bmp');
end
%open('secret.txt');


% --- Executes on button press in pixelRetrieve.
function pixelRetrieve_Callback(hObject, eventdata, handles)
% hObject    handle to pixelRetrieve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% original=handles.InputImage;
% target=handles.InputImage;
% %axes(handles.axes2),imshow(original);
% 
% I = (original);

i = 1;
j = 1;
k = 1;


I = handles.PixelStego;

messageType = handles.messageType;

t = Tiff(handles.tiffFileName,'r');
 
    % Specify tag by tag name.
    desc = t.getTag('ImageDescription');
    
    
    key = str2num(desc);
    

%imwrite(target,'custom.bmp','bmp');

% message = handles.a;

eachPixelValueRed = I(:,:,1);

% eachPixelValueGreen = I(:,:,2);
% 
% eachPixelValueBlue = I(:,:,3);
% disp(eachPixelValue1);
% 
% eachPixelValue = idivide(eachPixelValue1, 3, 'round');
        if(messageType == 0)
            
            
            keysizedivide = idivide(uint32(size(key)), 3, 'floor');
    
            keysize1 = key(end-1);
    
            keysize2 = key(end);
    
            [data, data1, data2] = findtext_pixel(eachPixelValueRed, key, messageType, (keysizedivide-2));

%         disp(data);
%             i1 = 1;
%             data1 = 0;
%             while i1<=(size(data)-2)
%                 data1(i1) = data(i1);
%                 i1 = i1+1;
%             end
            fid = fopen('secret.txt','wb');
            fwrite(fid,char(data),'char');
            fclose(fid);
            helpdlg('Data retrieved back in secret.txt');
 
        else
            
            sizekey = size(key);
            
            keysizedivide = idivide(uint32(sizekey(2)), 3, 'floor');
    
            keysize1 = key(end-1);
    
            keysize2 = key(end);
    
            [datared, datagreen, datablue] = findtext_pixel(eachPixelValueRed, key, messageType, (keysizedivide - 2));
            
            size11 = keysize1;

            size12 = keysize2;
           
            abc=zeros(size11,size12,3);
            
            abc1 = zeros(size11,size12);
            abc2 = zeros(size11,size12);
            abc3 = zeros(size11,size12);
            
            datasize1 = size(datared);
            
            while((k)<datasize1(2))
                abc1(i,j) = datared(k)/255;
                abc(i,j,1) = datared(k)/255;
                abc2(i,j) = datagreen(k)/255;
                abc(i,j,2) = datagreen(k)/255;
                abc3(i,j) = datablue(k)/255;
                abc(i,j,3) = datablue(k)/255;
                if(i<size12)
                    i=i+1;
                else
                        i=1;
                        j=j+1;
                end
                k=k+1;
            end
            imwrite (abc1, 'secret11.bmp','bmp');
            imwrite (abc2, 'secret12.bmp','bmp');
            imwrite (abc3, 'secret13.bmp','bmp');
            
%             datasize2 = size(datagreen);
%             
%             while((k)<datasize2(2))
%                 abc2(i,j) = datagreen(k);
%                 if(i<size12)
%                     i=i+1;
%                 else
%                         i=1;
%                         j=j+1;
%                 end
%                 k=k+1;
%             end
%             imwrite (abc2, 'secret12.bmp','bmp');
%             
%             datasize3 = size(datagreen);
%             
%             while((k)<datasize3(2))
%                 abc3(i,j) = datagreen(k);
%                 if(i<size12)
%                     i=i+1;
%                 else
%                         i=1;
%                         j=j+1;
%                 end
%                 k=k+1;
%             end
%             imwrite (abc3, 'secret13.bmp','bmp');
            imwrite (abc, 'secret1.bmp','bmp');
            helpdlg('Image retrieved back in secret1.bmp');
            %disp(abc);
        end
   
 
 guidata(hObject, handles);


% --- Executes on button press in messageTypeText.
function messageTypeText_Callback(hObject, eventdata, handles)
% hObject    handle to messageTypeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
 if (get(hObject,'Value') == get(hObject,'Max'))
	handles.messageType = 1;
else
	handles.messageType = 0;
 end
 guidata(hObject, handles);% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of messageTypeText

% --- Executes on button press in BrowsePixelStegoImage.
function BrowsePixelStegoImage_Callback(hObject, eventdata, handles)
% hObject    handle to BrowsePixelStegoImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
 [filename, pathname] = uigetfile({'*.tif'}, 'Pick an Image');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
       InputImage=imread(strcat(pathname,filename));
       handles.tiffFileName = filename;
       axes(handles.axes4);
       handles.PixelStego=InputImage;
       imshow(InputImage);
       
    end
    guidata(hObject, handles);% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in dualpixelvaluefinding.
function dualpixelvaluefinding_Callback(hObject, eventdata, handles)
% hObject    handle to dualpixelvaluefinding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
original=handles.InputImage;
% target=handles.InputImage;
%axes(handles.axes2),imshow(original);

I = (original);

messageType = handles.messageType;

% Get edit text
% Display it on a static text label
%set(handles.text6, 'String', int2str(szi));
%abc(1,2)=1;


%imwrite(target,'custom.bmp','bmp');

message = handles.message;

eachPixelValueRed = I(:,:,1);

eachPixelValueGreen = I(:,:,2);

eachPixelValueBlue = I(:,:,3);
% disp(eachPixelValue1);
% 
% eachPixelValue = idivide(eachPixelValue1, 3, 'round');
[a, notFound1] = hidetext_pixel(eachPixelValueRed, message, messageType);

% imgdata = imread('custom.bmp');
% 


%sz2 = size(target);
%set(handles.text6, 'String', int2str(I(1:1:1)));

handles.a = a;

sizea = size(a);

% disp(sizea);

sizeaa = sizea(1)*sizea(2);

for i = 1:sizeaa
%     disp(i);
    a1234(i) = (uint32(a(i)));
    

end

% disp(a1234)

fid = fopen('hiddenFile2.txt','w');
        fprintf(fid,'%d,\n',a1234);
        fclose(fid);
        
imgdata = I;

afinal = a1234;

%afinal = strcat(num2str(a1234), num2str(b1234), num2str(c1234));

t = Tiff('custom2.tif','w');

tagstruct.ImageLength = size(imgdata,1);
tagstruct.ImageWidth = size(imgdata,2);
tagstruct.Photometric = Tiff.Photometric.RGB;
tagstruct.BitsPerSample = 8;
tagstruct.SamplesPerPixel = 3;
tagstruct.RowsPerStrip = 16;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
tagstruct.Software = 'MATLAB';
tagstruct.ImageDescription = num2str(afinal);
t.setTag(tagstruct);

t.write(imgdata);

t.close();

original=handles.DualPixelStego;
target=handles.DualPixelStego;
%fid = fopen('message.txt','r');
%F = fread(fid);
%s = char(F');
%fclose(fid);

message = afinal;

% disp(message);

F = message;

% F = fread(message);
% s = char(F');
% fclose(message);

%F = message;
%s=char(F');

% disp(F);

sz1=size(original);
size1=sz1(1)*sz1(2);
sz2=size(F);
size2=sz2(1);

if size2> size1 
    fprintf('\nImage File Size  %d\n',size1);
    fprintf('Text  File Size  %d\n',size2);
    disp('Text File is too Large');
else
    fprintf('\nImage File Size  %d\n',size1);
    fprintf('Text  File Size  %d\n',size2);
    disp('Text File is Small or Equal');
    i=1;j=1;k=1;
        while k<=size2
        a=F(k);
        o1=original(i,j,1);
        o2=original(i,j,2);
        o3=original(i,j,3);
        
        [r1,r2,r3]=hidetext(o1,o2,o3,a); 
        
        target(i,j,1)=r1;
        target(i,j,2)=r2;
        target(i,j,3)=r3;
        
            if(i<sz1(1))
                i=i+1;
            else
                i=1;
                j=j+1;
            end
            k=k+1;
        end
        width=sz1(1);
        txtsz=size2;
        n=size(original);
        target(n(1),n(2),1)=txtsz;% Text Size
        target(n(1),n(2),2)=width;% Image's Width
        
        
        %save secret.mat target;% txtsz width;
        imwrite(target,'secret2.bmp','bmp');
       
       axes(handles.axes7),imshow(target)
    
end
    

helpdlg('data hided succesfully in secret2.bmp');

guidata(hObject, handles);

% --- Executes on button press in dualpixelRetrieve.
function dualpixelRetrieve_Callback(hObject, eventdata, handles)
% hObject    handle to dualpixelRetrieve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% original=handles.InputImage;
% target=handles.InputImage;
% %axes(handles.axes2),imshow(original);
% 
% I = (original);
target=handles.DualPixelStego;
        n=size(target);
        txtsz=target(n(1),n(2),1);% Text Size
        width=target(n(1),n(2),2);% Image's Width

        
        i=1;j=1;k=1;
        while k<=txtsz
        
        r1=target(i,j,1);
        r2=target(i,j,2);
        r3=target(i,j,3);
        
        R(k)=findtext(r1,r2,r3);
                
                if(i<width)
                    i=i+1;
                else
                    i=1;
                    j=j+1;
                end
                k=k+1;
        end
        
        
            fid = fopen('secret2.txt','wb');
            fwrite(fid,char(R),'char');
            fclose(fid);

i = 1;
j = 1;
k = 1;


I = handles.PixelStego;

messageType = handles.messageType;

t = Tiff(handles.tiffFileName,'r');
 
    % Specify tag by tag name.
    key = R;
    disp(R);
    
    
%     key = str2num(desc);
    
    keysize1 = key(end-1);
    
    keysize2 = key(end);
    

%imwrite(target,'custom.bmp','bmp');

% message = handles.a;

eachPixelValueRed = I(:,:,1);

eachPixelValueGreen = I(:,:,2);

eachPixelValueBlue = I(:,:,3);
% disp(eachPixelValue1);
% 
% eachPixelValue = idivide(eachPixelValue1, 3, 'round');
[data] = findtext_pixel(eachPixelValueRed, key, messageType, keysize1, keysize2);

        if (messageType == 0)
%             i1 = 1;
%             data1 = 0;
%             while i1<=(size(data)-2)
%                 data1(i1) = data(i1);
%                 i1 = i1+1;
%             end
            fid = fopen('secret.txt','wb');
            fwrite(fid,char(data),'char');
            fclose(fid);
            helpdlg('Data retrieved back in secret.txt');
 
        else
            size11 = data(end-1);

            size12 = data(end);
            
            
            abc=zeros(size11,size12);
            
            datasize = size(data);
            
            while((k+2)<datasize(2))
                disp('k = ');
                disp(k);
                abc(i,j,1) = data(k+2);
                if(i<size12)
                    i=i+1;
                else
                        i=1;
                        j=j+1;
                end
                k=k+1;
            end
            imwrite (abc, 'secret2.bmp','bmp');
            helpdlg('Image retrieved back in secret2.bmp');
            %disp(abc);
        end
   
 
 guidata(hObject, handles);


% --- Executes on button press in browsesecondkeyimage.
function browsesecondkeyimage_Callback(hObject, eventdata, handles)
% hObject    handle to browsesecondkeyimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile({'*.bmp';'*.png';'*.gif';'*.jpg';'*.tif'}, 'Pick an Image');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
       InputImage=imread(strcat(pathname,filename));
       handles.tiffFileName = filename;
       axes(handles.axes2);
       handles.DualPixelStego=InputImage;
       imshow(InputImage);
       
    end
    guidata(hObject, handles);
