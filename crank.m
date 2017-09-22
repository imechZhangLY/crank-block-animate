%
clear;
clc;
linkClassName = 'animate-link'; %����ʵ�ֶ������ܵ�����
linkAnimateName = 'link'; %���˵Ķ���������
blockClassName = 'animate-blocks'; %����ʵ�ֶ������ܵ�����
blockAnimateName = 'blocks'; %���˵Ķ���������

l1 = 16; % �����ļ��㳤�ȣ���ʵ�ʳ���(div��width����) - 2 * borderRadius��ȡborder-radius = �߶ȵ�һ��
l2 = 28; % ���˵ļ��㳤�ȣ���ʵ�ʳ��� - 2 * borderRadius
h = 2; %���и˵Ŀ�ȣ���Ӧdiv��height����
N = 20;  %�����ֳɵ�֡��
theta = 0 : 2 * pi / N : 2 * pi; %������ˮƽ�ߵļн�
phi = asin(l1 / l2 * sin(theta)); %������ˮƽ�ߵļн�
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
