%2d dambreak SPH程序后处理
%溃坝过程云图动画
%SPH算例计算完成后，数据文件保存在data文件夹下，按照时间步命名，按顺序依次读入数据文件
% by hexuan 2021

% 选择绘制云图的变量:
% 压力   (   压力<--->1 )
% 密度   (   密度<--->2 )
% 位置   (   横向位置<--->3,   纵向位置<--->4    )
% 速度   (   横向速度<--->5,   纵向速度<--->6    )
clear;clc;clf; %清空
contour_variable = 1;
switch contour_variable
    case {1}
      fluid_variable = 'fluid_pressure';
      colorbar_min = -1000; colorbar_max = 40000; %colorbar的上下限
    case {2}
      fluid_variable = 'fluid_density';
      colorbar_min = 990; colorbar_max = 1200; %colorbar的上下限
    case {3}
      fluid_variable = 'fluid_x';
      colorbar_min = 0; colorbar_max = 1; %colorbar的上下限
    case {4}
      fluid_variable = 'fluid_y';
      colorbar_min = 0; colorbar_max = 0.5; %colorbar的上下限
    case {5}
      fluid_variable = 'fluid_vx';
      colorbar_min = -6; colorbar_max = 5; %colorbar的上下限
    case {6}
      fluid_variable = 'fluid_vy';
      colorbar_min = -4; colorbar_max = 7; %colorbar的上下限
    otherwise
      fprintf('error');
end

 
dt = 0.0001;        %SPH程序模拟的时间步长（单位：s）
print_step = 200;   %输出时间步间隔
min_step = 200;     %初始时间步
max_step = 80000;   %结束时间步

fmin = ones(1,(max_step-min_step)/print_step+1);
fmax = ones(1,(max_step-min_step)/print_step+1);

for current_timestep = min_step : print_step : max_step 
    %打印对应时间步的流体粒子图像
  
filename1=strcat('..\..\data\f_xv',num2str(current_timestep),'.dat'); %strcat组合字符串：比如 = 'data\f_xv1000.dat'
fid = fopen(filename1); %打开filename1文件，文件标识符为fid
data = textscan(fid,'%d %f %f %f %f %f %f %f','HeaderLines',3); %读取数据，data是矩阵，'HeaderLines',3表示跳过前3行
fluid_id = data{:,1}; %data第1列为流体粒子标号，对应数据文件第1列
fluid_x = data{:,2}; %data第2列为流体粒子横坐标，对应数据文件第2列
fluid_y = data{:,3}; %data第3列为流体粒子纵坐标，对应数据文件第3列
fluid_vx = data{:,4};%data第4列为流体粒子横向速度，对应数据文件第4列
fluid_vy = data{:,5};%data第5列为流体粒子纵向速度，对应数据文件第5列
fluid_mass = data{:,6};%data第6列为流体粒子质量，对应数据文件第6列
fluid_density = data{:,7};%data第6列为流体粒子密度，对应数据文件第7列
fluid_pressure = data{:,8};%data第7列为流体粒子压力，对应数据文件第8列
fclose(fid);

 fmin(1,(current_timestep- min_step)/print_step+1) = min(eval(fluid_variable)); 
 fmax(1,(current_timestep- min_step)/print_step+1) = max(eval(fluid_variable));
 if current_timestep == max_step
  colorbar_min_1 = min(fmin)
  colorbar_max_1 = max(fmax)
 end

     colour1 = ones(1,length(eval(fluid_variable))); %散点图的颜色参数
     for ii = 1: length(eval(fluid_variable))
          colour1(1,ii)= eval([fluid_variable,'(ii,1)']);
     end
     scatter(fluid_x,fluid_y,200,colour1,'.'); %画散点图
     colormap jet %更改颜色分布，缺省默认为 parula，在颜色条右键可选 hsv ，hot ，gray ，jet  等 
     caxis([colorbar_min,colorbar_max]);%colorbar的上下限
     barname = colorbar;   %分布条柱图  
%      barname.Label.String = 'Pressure'; %colorbar添加名字

    hold on; %开关，作用是保持原图并接受此后绘制的新的曲线，叠加绘图；
    %打印流动边界/墙，同流体粒子一样操作    
    fid = fopen('..\..\data\xv_vp.dat');
    data = textscan(fid,'%d %f %f %f %f');
    wall_x=data{:,2};
    wall_y=data{:,3};
    plot(wall_x,wall_y,'k.')
    fclose(fid);
    
    %添加图像标题
    titlename=strcat('current-step = ',num2str(current_timestep),32,32,32,32,'time = ',num2str(current_timestep*dt),'s'); %组合字符串：图像标题 = 当前时间步+模拟流动时间
    title(titlename);  
    
    axis equal; % 横纵坐标尺度相等
    axis([-0.025,1.025,-0.025,1.025]);%坐标轴范围
    
    k = 1;
    pause(k*dt*print_step); %如果播放太快，则放慢速度,1/k倍（不一定有用）
    if current_timestep ~= max_step
        clf; %清除图像
    end

end
   