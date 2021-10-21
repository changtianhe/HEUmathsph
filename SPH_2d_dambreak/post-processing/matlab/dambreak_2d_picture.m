%只输出某一个时间步图像，便于检查
clear;clc;clf; %清空
print_timestep = 400;  %输入要打印的时间步
dt = 0.0001;        %SPH程序模拟的时间步长（单位：s）

%打印对应时间步的流体粒子
filename1=strcat('..\..\data\f_xv',num2str(print_timestep),'.dat'); %strcat组合字符串：比如 = 'data\f_xv1000.dat'
fid = fopen(filename1); %打开filename1文件，文件标识符为fid
data = textscan(fid,'%d %f %f %f %f %f %f %f','HeaderLines',3); %读取数据，data是矩阵，'HeaderLines',3表示跳过前3行
fluid_id = data{:,1}; %data第1列为流体粒子标号，对应数据文件第1列
fluid_x = data{:,2}; %data第2列为流体粒子横坐标，对应数据文件第2列
fluid_y = data{:,3}; %data第3列为流体粒子纵坐标，对应数据文件第3列
fluid_vx = data{:,4};%data第4列为流体粒子横方向速度，对应数据文件第4列
fluid_vy = data{:,5};%data第5列为流体粒子纵方向速度，对应数据文件第5列
fluid_density = data{:,6};%data第6列为流体粒子密度，对应数据文件第6列
fluid_pressure = data{:,7};%data第7列为流体粒子压力，对应数据文件第7列
plot(fluid_x,fluid_y,'.') %打印流体粒子坐标，形成图像
fclose(fid); %关闭文件

hold on %开关，作用是保持原图并接受此后绘制的新的曲线，叠加绘图；
%打印流动边界/墙
fid = fopen('..\..\data\xv_vp.dat'); %打开filename1文件，文件标识符为fid
%data = textscan(fid,'%d %f %f %f %f %f %f %f','HeaderLines',3); %读取数据，data是矩阵，'HeaderLines',3表示跳过前3行
data = textscan(fid,'%d %f %f %f %f');
wall_id = data{:,1}; %data第1列为流体粒子标号，对应数据文件第1列
wall_x = data{:,2}; %data第2列为流体粒子横坐标，对应数据文件第2列
wall_y = data{:,3}; %data第3列为流体粒子纵坐标，对应数据文件第3列
plot(wall_x,wall_y,'k.')
fclose(fid);

%添加图像标题
titlename=strcat('current-step = ',num2str(print_timestep),32,32,32,32,'time = ',num2str(print_timestep*dt),'s'); %组合字符串：图像标题 = 当前时间步+模拟流动时间
title(titlename); 
axis equal;
axis([-0.025,1.025,-0.025,1.025]);
