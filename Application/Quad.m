%% 
function output = Quad(IMG,w,h,S,qud)
[R,C] = size(IMG);
Final_img = zeros(R,C);
X1 = qud(7);
Y1 = qud(3);
X2 = qud(8);
Y2 = qud(4);
X3 = qud(5);
Y3 = qud(1);
X4 = qud(6);
Y4 = qud(2);

m1 = (X2-X1)/(Y2-Y1);
m2 = (X3-X2)/(Y3-Y2);
m3 = (X4-X3)/(Y4-Y3);
m4 = (X1-X4)/(Y1-Y4);

c1 = X1 - m1*Y1;
c2 = X2 - m2*Y2;
c3 = X3 - m3*Y3;
c4 = X4 - m4*Y4;

Ymax = max(qud(1:4));
Ymin = min(qud(1:4));

if Ymax == Y1
    y2ndmax = Y2;
elseif Ymax == Y2
    y2ndmax = Y1;
end
if Ymin == Y3
    y3rdmax = Y4;
elseif Ymin == Y4
    y3rdmax = Y3;
end

Flag1 = 0;
Flag2 = 0;
Flag3 = 0;
Flag4 = 0;

rng = floor((Ymax-Ymin)/(w)); 

for i = 1:(rng - w)
    y1 = Ymax - i*w;
    y2 = y1 - w;
    if y1 < y2ndmax
        Flag1 = 1;
    end
    if y2 < y2ndmax
        Flag2 = 1;
    end
    if y1 < y3rdmax
        Flag3 = 1;
    end
    if y2 < y3rdmax
        Flag4 = 1;
    end

   
    if Flag1 ==0 && Flag2 ==0 && Ymax == Y2
            x11 = Line(m2,y1,c2);
            x21 = Line(m1,y1,c1);
            x12 = Line(m2,y2,c2);
            x22 = Line(m1,y2,c1);         
    elseif Flag1 ==0 && Flag2 ==1 && Flag4 ==0 && Ymax == Y2
            x11 = Line(m2,y1,c2);
            x21 = Line(m1,y1,c1);
            x12 = Line(m2,y2,c2);
            x22 = Line(m4,y2,c4);
    elseif Flag1 ==1 && Flag3 ==0 && Flag4 ==0 && Ymax == Y2
            x11 = Line(m2,y1,c2);
            x21 = Line(m4,y1,c4);
            x12 = Line(m2,y2,c2);
            x22 = Line(m4,y2,c4);

    elseif Flag1 ==0 && Flag2 ==0 && Ymax == Y1
            x11 = Line(m1,y1,c1);
            x21 = Line(m4,y1,c4);
            x12 = Line(m1,y2,c1);
            x22 = Line(m4,y2,c4);
    elseif Flag1 ==0 && Flag2 ==1 && Flag4 ==0 && Ymax == Y1
            x11 = Line(m1,y1,c1);
            x21 = Line(m4,y1,c4);
            x12 = Line(m2,y2,c2);
            x22 = Line(m4,y2,c4);
    elseif Flag1 ==1 && Flag3 ==0 && Flag4 ==0 && Ymax == Y1
            x11 = Line(m2,y1,c2);
            x21 = Line(m4,y1,c4);
            x12 = Line(m2,y2,c2);
            x22 = Line(m4,y2,c4);

    elseif Flag1 ==1 && Flag3 ==0 && Flag4 ==1 && Ymin == Y4  
            x11 = Line(m2,y1,c2);
            x21 = Line(m4,y1,c4);
            x12 = Line(m3,y2,c3);
            x22 = Line(m4,y2,c4);
    elseif Flag3 ==1 && Flag4 ==1 && Ymin == Y4 
            x11 = Line(m3,y1,c3);
            x21 = Line(m4,y1,c4);
            x12 = Line(m3,y2,c3);
            x22 = Line(m4,y2,c4);
    elseif Flag1 ==1 && Flag3 ==0 && Flag4 ==1 && Ymin == Y3 
            x11 = Line(m2,y1,c2);
            x21 = Line(m4,y1,c4);
            x12 = Line(m2,y2,c2);
            x22 = Line(m3,y2,c3);
    elseif Flag3 ==1 && Flag4 ==1 && Ymin==Y3  
            x11 = Line(m2,y1,c2);
            x21 = Line(m3,y1,c3);
            x12 = Line(m2,y2,c2);
            x22 = Line(m3,y2,c3);
    end
    
        
    if x11 < x21
            x11 = ceil(x11);
            x21 = floor(x21);
    else
            x11 = floor(x11);
            x21 = ceil(x21);
    end
    if x12 < x22
            x12 = ceil(x12);
            x22 = floor(x22);
    else
            x12 = floor(x12);
            x22 = ceil(x22);
    end
    if abs(x11 - x21) < abs(x12 - x22)
        hight = abs(x11 - x21);
        width = w;
        rect = [x11 y1 width hight];
        Final_img = Final_img + box(IMG,w,h,S,rect);
    else
        hight = abs(x12 - x22);
        width = w;
        rect = [x12 y1 width hight];
        Final_img = Final_img + box(IMG,w,h,S,rect);
    end
end
output = Final_img;
end

%% Straigt line function
function output = Line(m,x,c)
output = m*x + c;
end
%% Box function
function output = box(IMG,w,h,S,rect)
[R,C] = size(IMG);
B = zeros(R,C);
f = 0;
v1 = 0;
v2 = 0;

if isempty(rect) == 1
    V1 = R - h;
    V2 = C - w;
    xmin = 1;
    ymin = 1;
    v1 = R;
    v2 = C;
    f = 1;
else
    xmin = rect(1);
    ymin = rect(2);
    width = rect(3);
    hight = rect(4);
    v1 = hight + xmin;
    v2 = width + ymin;

    V1 = v1 - h;
    V2 = v2 - w;
end

if v1 > R
    error("hight of rectangle execeds")
    return
end

if v2 > C
    error("width of rectangle execeds")
    return
end

if V1 < 0 && f == 0
    error("hight of filter element execeds")
    return
end

if V2 < 0 && f == 0
    error("width of filter element execeds")
    return 
end

for i = xmin:V1
    for j = ymin:V2
        upb = IMG(i,j:j+w);
        lowb = IMG(i+h,j:j+w);
        rgtb = IMG(i:i+h,j+w);
        lftb = IMG(i:i+h,j);
        
        if strcmp(S,"white") == 1
            if sum(upb) >=1 && sum(lowb) >=1 && sum(rgtb) >=1 && sum(lftb) >=1
                m = j+1:j+w-1;
                for k = i+1:i+h-1
                    B(k,m) = 1;
                end
            end
            
        elseif strcmp(S,"black") == 1
            if sum(upb) <=0 && sum(lowb) <=0 && sum(rgtb) <=0 && sum(lftb) <=0
                 m = j+1:j+w-1;
                 for k = i+1:i+h-1
                     B(k,m) = 1;
                 end
            end
        elseif strcmp(S,"white_abs") == 1
            if sum(upb) == w+1 && sum(lowb) == w+1 && sum(rgtb) == h+1 && sum(lftb) == h+1
                m = j+1:j+w-1;
                for k = i+1:i+h-1
                    B(k,m) = 1;
                end
            end
        end
    end
end
output = B;
end








