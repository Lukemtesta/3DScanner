
%% Input Parameters: SIFT

for i=0:30

    imgName = ['Square ' num2str(i) '.png'];

    %% Prepare Image for SIFT i/p format

    I = imread( imgName );

    if length( size(I) ) == 3 
        I = rgb2gray(I);
    end

    I = single(I);

    %% Run SIFT: Returns keypoints (kp)

    kp = vl_sift( I );

    figure(1)
    imshow( imread(imgName) )
    hold on
    scatter( kp(1,:), kp(2,:), 'wx')
    
end



%% Input Parameters: Harris

for i=0:30
    
    imgName = ['Square ' num2str(i) '.png'];
    
    %% Prepare Image for SIFT i/p format

    I = imread( imgName );

    if length( size(I) ) == 3 
        I = rgb2gray(I);
    end

    %% Run SIFT: Returns keypoints (kp)

    kp = torr_charris_jc( I, 4 );

    figure(1)
    imshow( imread(imgName) )
    hold on
    scatter( kp(:,1), kp(:,2), 'rx')
    pause(1)
    
end
