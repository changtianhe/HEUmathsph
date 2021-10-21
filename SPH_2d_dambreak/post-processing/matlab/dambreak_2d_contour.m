 %������ͼ
 %����ѡ������ܶȡ��ٶȻ�ѹ����ͼ
clear;clc;clf; %���
print_timestep = 4000;  %����Ҫ���Ƶ�ʱ�䲽
dt = 0.0001;        %SPH����ģ���ʱ�䲽������λ��s��

%��ӡ��Ӧʱ�䲽����������ͼ��
filename1=strcat('..\..\data\f_xv',num2str(print_timestep),'.dat'); %strcat����ַ��������� = 'data\f_xv1000.dat'
fid = fopen(filename1); %��filename1�ļ����ļ���ʶ��Ϊfid
data = textscan(fid,'%d %f %f %f %f %f %f %f','HeaderLines',3); %��ȡ���ݣ�data�Ǿ���'HeaderLines',3��ʾ����ǰ3��
fluid_id = data{:,1}; %data��1��Ϊ�������ӱ�ţ���Ӧ�����ļ���1��
fluid_x = data{:,2}; %data��2��Ϊ�������Ӻ����꣬��Ӧ�����ļ���2��
fluid_y = data{:,3}; %data��3��Ϊ�������������꣬��Ӧ�����ļ���3��
fluid_vx = data{:,4};%data��4��Ϊ�������Ӻ����ٶȣ���Ӧ�����ļ���4��
fluid_vy = data{:,5};%data��5��Ϊ�������������ٶȣ���Ӧ�����ļ���5��
fluid_mass = data{:,6};%data��6��Ϊ����������������Ӧ�����ļ���6��
fluid_density = data{:,7};%data��7��Ϊ���������ܶȣ���Ӧ�����ļ���7��
fluid_pressure = data{:,8};%data��8��Ϊ��������ѹ������Ӧ�����ļ���8��
fclose(fid);

 c1 = ones(1,length(fluid_x));
 for i = 1: length(fluid_x)
     c1(1,i)= fluid_pressure(i,1); %ѡ����Ʊ�������ͼ
 end


%scatter(fluid_x,fluid_y,40,c1,'o','filled');
 scatter(fluid_x,fluid_y,200,c1,'.');
 colormap jet %������ɫ�ֲ���ȱʡĬ��Ϊ parula������ɫ���Ҽ���ѡ hsv ��hot ��gray ��jet  �� 
 colorbar_min = -500;colorbar_max = 5000;
 caxis([colorbar_min,colorbar_max]);%colorbar��������
 barname = colorbar;   %�ֲ�����ͼ  
%  barname.Label.String = 'pressure (Pa)'; %colorbar�������

hold on %���أ������Ǳ���ԭͼ�����ܴ˺���Ƶ��µ����ߣ����ӻ�ͼ��
%��ӡ�����߽�/ǽ
fid = fopen('..\..\data\xv_vp.dat'); %��filename1�ļ����ļ���ʶ��Ϊfid
%data = textscan(fid,'%d %f %f %f %f %f %f %f','HeaderLines',3); %��ȡ���ݣ�data�Ǿ���'HeaderLines',3��ʾ����ǰ3��
data = textscan(fid,'%d %f %f %f %f');
wall_id = data{:,1}; %data��1��Ϊ�������ӱ�ţ���Ӧ�����ļ���1��
wall_x = data{:,2}; %data��2��Ϊ�������Ӻ����꣬��Ӧ�����ļ���2��
wall_y = data{:,3}; %data��3��Ϊ�������������꣬��Ӧ�����ļ���3��
plot(wall_x,wall_y,'k.')
fclose(fid);

%���ͼ�����
titlename=strcat('current-step = ',num2str(print_timestep),32,32,32,32,'time = ',num2str(print_timestep*dt),'s'); %����ַ�����ͼ����� = ��ǰʱ�䲽+ģ������ʱ��
title(titlename); 
axis equal;
axis([-0.025,1.025,-0.025,1.025]);
