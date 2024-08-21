function output = Box(IMG,w,h,S,rect)
[R,C] = size(IMG);
B = IMG;
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

for i = xmin:v1
    for j = ymin:v2
        B(i,j) = 0;
    end
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

