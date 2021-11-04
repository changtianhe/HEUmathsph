clear;
clc;
hold on
%首先打开你的文件.txt。fid用于存储文件的位置
fid = fopen('我是文件.txt') ;
%用fgetl 读前面 7行 注意fgetl不会忽略空的行，如果遇到空的行，则fgetl会读入一个空的字符串
for i = 1 : 7
tline = fgetl(fid) ; %fgetl 一次仅读入一行，并返回这一行的字符串
if ~ischar(tline), break, end %检查是否读入成功，若失败则退出循环
disp(tline) %显示读入的行的内容，你也可以把它存储到某个字符串变量中
end %循环结束，此时fid 停留在fgetl最后读的一行末端。
%读完前7行后，用fscanf继续读
fscanf(fid,'%c')
%这条命令会将文件中所有余下的内容以字符的格式读入，并输出到屏幕上，
%你可以指定它读多少字符通过使用fscanf(fid,'%c',N)，N为你想要读的个数，如果要读数的话使用'%d'或'%f'
data=load('..\..\data\f_xv400.dat'); 
num=data(:,1);
x=data(:,2);
y=data(:,3);
plot(x,y,'.')
data=load('..\..\data\vp_xv400.dat'); 
num=data(:,1);
x=data(:,2);
y=data(:,3);
plot(x,y,'.')
axis equal;
 axis([-0.05,4.1,-0.0025,4.5]);