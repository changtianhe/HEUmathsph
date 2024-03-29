%2d dambreak SPH程序后处理
%溃坝过程动画
%SPH算例计算完成后，数据文件保存在data文件夹下，按照时间步命名，
%按顺序依次读入数据文件，用for循环将对应时间步下的图像打印到屏幕上即可。
% by hexuan 2021
clear;clc;clf; %清空
dt = 0.00005;        %SPH程序模拟的时间步长（单位：s）
print_step = 200;   %输出时间步间隔
min_step = 200;     %初始时间步
max_step = 38000;   %结束时间步
for i = min_step : print_step : max_step 
    %每次循环将对应时间步图像打印到屏幕上，i表示当前时间步
    file_id=num2str(i); %将i转换成字符串形式，赋给file_id
    dir='..\..\data\'; 
    filename1=strcat(dir,'f_xv',file_id,'.dat'); %strcat组合字符串：比如 = 'f_xv1000.dat'
    fid = fopen(filename1); %打开filename1文件，文件标识符为fid
    f_xv = textscan(fid,'%f %f %f %f %f %f %f','HeaderLines',3); % 'HeaderLines',3表示跳过前3行
    fluid_x=f_xv{:,1}; %流体粒子横坐标
    fluid_y=f_xv{:,2}; %流体粒子纵坐标
    plot(fluid_x,fluid_y,'.') %打印流体粒子坐标，形成图像
    fclose(fid); %关闭文件
    
    hold on; %开关，作用是保持原图并接受此后绘制的新的曲线，叠加绘图；
    %打印流动边界/墙，同流体粒子一样操作 
    filename2=strcat(dir,'vp_xv',file_id,'.dat'); %strcat组合字符串：比如 = 'f_xv1000.dat'
    fid = fopen(filename2); %打开filename1文件，文件标识符为fid
    vp_xv = textscan(fid,'%f %f %f %f %f %f %f','HeaderLines',3); % 'HeaderLines',3表示跳过前3行
    wall_x=vp_xv{:,1}; %流体粒子横坐标
    wall_y=vp_xv{:,2}; %流体粒子纵坐标
    plot( wall_x, wall_y,'k.') %打印流体粒子坐标，形成图像
    fclose(fid); %关闭文件
    
    %添加图像标题
    titlename=strcat('current-step = ',file_id,32,32,32,32,'time = ',num2str(i*dt),'s'); %组合字符串：图像标题 = 当前时间步+模拟流动时间
    title(titlename);  
    
    axis equal; % 横纵坐标尺度相等
    axis([-0.025,4.025,-0.025,2.025]);%坐标轴范围
    
    k = 1;
    pause(k*dt*print_step); %如果播放太快，则放慢速度,1/k倍（不一定有用）
    if i ~= max_step
        clf; %清除图像
    end
end
   