function BW = findpattern(Image)
[x,y]=size(Image);
Image_double=double(Image);                  
random_matrix =sqrt(100) * randn(x,y);        
I=Image_double+random_matrix;                           
max_Intensity=max(max(I));                  
min_Intensity=min(min(I));                   
Half_Range=(max_Intensity+min_Intensity)/2;                      
Range=0;
S0=0; n0=0;
S1=0; n1=0;
allow=0.5;                       
d=abs(Half_Range-Range);
count=0;                        

while(d>=allow)                 
    count=count+1;
    for i=1:x
        for j=1:y
            if (I(i,j)>=Half_Range)
                S0=S0+I(i,j);
                n0=n0+1;
            end
            if (I(i,j)<Half_Range)
                S1=S1+I(i,j);
                n1=n1+1;
            end
        end
    end 
    T0=S0/n0;
    T1=S1/n1;
    Range=(T0+T1)/2;
    d=abs(Half_Range-Range);
    Half_Range=Range;
end

Seg=zeros(x,y);
for i=1:x
    for j=1:y
        if(I(i,j)>=Half_Range)
            Seg(i,j)=1;              
        end
    end
end

SI=1-Seg;                            
se1=strel('square',3);               
SI1=imerode(SI,se1);                 
BW=SI-SI1; 
clear Image_double;clear random_matrix; clear I; clear max_Intensity; clear min_Intensity; clear Half_Range; clear Range;
clear S0; clear allow; clear S1; clear n1; clear n0; clear d;clear Se1;
end
