%
clear;
clc;
linkClassName = 'animate-link'; %连杆实现动画功能的类名
linkAnimateName = 'link'; %连杆的动画的名字
blockClassName = 'animate-blocks'; %滑块实现动画功能的类名
blockAnimateName = 'blocks'; %连杆的动画的名字

l1 = 16; % 曲柄的计算长度，是实际长度(div的width属性) - 2 * borderRadius，取border-radius = 高度的一半
l2 = 28; % 连杆的计算长度，是实际长度 - 2 * borderRadius
h = 2; %所有杆的宽度，对应div的height属性
N = 20;  %动画分成的帧数
theta = 0 : 2 * pi / N : 2 * pi; %曲柄与水平线的夹角
phi = asin(l1 / l2 * sin(theta)); %连杆与水平线的夹角
l3 = l1 * cos(theta) + sqrt(l1^2 * cos(theta).^2 + l2^2 - l1^2);
xc = l3 - l2 / 2 * cos(phi);
yc = l1/2 * sin(theta);

rotate2 = round(180 / pi * phi);
x3 = round((l3 - l1 - l2) * 100) / 100;
xc = round((xc - l1 - 0.5 * l2) * 100) / 100;
yc = -round(yc * 100) / 100;
filename = 'cssAnimate.txt';
fidin = fopen(filename, 'w+');

j = 1;
tline = '.%s{animation: 4s %s linear infinite;}\n';
fprintf(fidin,tline,linkClassName,linkAnimateName);
tline = '@keyframes %s {\n';
fprintf(fidin,tline,linkAnimateName);
for i = 0 : 100 / N : 100
    tline='\t%d%%{transform: rotate(%2.0fdeg) translate(%3.2fvw, %3.2fvw); transform-origin: %3.2fvw %3.2fvw;}\n';
    fprintf(fidin,tline,[i;rotate2(j);xc(j);yc(j);0.5 * l2 + 0.5 * h + xc(j); yc(j) + 0.5 * h]);
    j = j + 1;
end
tline = '}\n';
fprintf(fidin,tline);

j = 1;
tline = '.%s{animation: 4s %s linear infinite;}\n';
fprintf(fidin,tline,blockClassName,blockAnimateName);
tline = '@keyframes %s {\n';
fprintf(fidin,tline,blockAnimateName);
for i = 0 : 100 / N : 100
    tline='\t%d%%{transform: translate(%3.2fvw);}\n';
    fprintf(fidin,tline,[i;x3(j)]);
    j = j + 1;
end
tline = '}\n';
fprintf(fidin,tline);
fclose(fidin);
