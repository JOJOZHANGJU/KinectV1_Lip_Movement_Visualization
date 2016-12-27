[txtPath] = textread('txtpath.txt','%s');
[picPath] = textread('picpath.txt','%s');
[row,cols] = size(txtPath);
visualPath = 'XXX\LipTopic\LipTopicProject\Step2DataPostprocessing\Synchronized\QYX\VowelI\3WB\K\VI\';
for a = 1:row
    filetxt = txtPath{a};
    filepic = picPath{a};
    filesT = dir(fullfile(filetxt,'*.txt'));
    T = cell(length(filesT),1);
    for Tnum = 1:length(filesT)
        T{Tnum,1} = filesT(Tnum).name;
    end
    [TT,INDEX] = sort_nat(T);
    filesP = dir(fullfile(filepic,'*.png'));
    M = moviein(length(filesP));
    for k = 1:length(filesT)
        txtfilepath =  TT{k};
        picfilepath =  filesP(k).name;
        [index,x,y,z] = textread([filetxt,'\',txtfilepath],'%f%f%f%f');
        for i = 1:length(z)
            xx(i) = 320 + int32((0.75 / z(i)) * x(i) * 320 / (z(i) * tan(28.5 * pi / 180)));
            yy(i) = 240 - int32((0.75 / z(i)) * y(i) * 240 / (z(i) * tan(21.5 * pi / 180)));
        end
        im = imread([filepic,'\',picfilepath]);
%          J = imresize(im, 0.5);
        imshow(im);
        title(filepic);
        hold on
        innerlipX = [xx(1:8),xx(1)];
        outerlipX = [xx(9:18),xx(9)];
        innerlipY = [yy(1:8),yy(1)];
        outerlipY = [yy(9:18),yy(9)];
        plot(innerlipX,innerlipY,'k-','MarkerSize',1);
        plot(outerlipX,outerlipY,'k-','MarkerSize',1);
        
        %M(:,k) = getframe;
        imm = getframe; %%%可视化
        im=frame2im(imm);%%%可视化
        hold off
        
        imwrite(im,[visualPath,picfilepath]);
        %disp([visualPath,picfilepath]);
    end
    %movie(M,1,100);
end