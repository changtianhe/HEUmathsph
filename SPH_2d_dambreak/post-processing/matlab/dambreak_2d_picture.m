%ֻ���ĳһ��ʱ�䲽ͼ�񣬱��ڼ��
clear;clc;clf; %���
print_timestep = 400;  %����Ҫ��ӡ��ʱ�䲽
dt = 0.0001;        %SPH����ģ���ʱ�䲽������λ��s��

%��ӡ��Ӧʱ�䲽����������
filename1=strcat('..\..\data\f_xv',num2str(print_timestep),'.dat'); %strcat����ַ��������� = 'data\f_xv1000.dat'
fid = fopen(filename1); %��filename1�ļ����ļ���ʶ��Ϊfid
data = textscan(fid,'%d %f %f %f %f %f %f %f','HeaderLines',3); %��ȡ���ݣ�data�Ǿ���'HeaderLines',3��ʾ����ǰ3��
fluid_id = data{:,1}; %data��1��Ϊ�������ӱ�ţ���Ӧ�����ļ���1��
fluid_x = data{:,2}; %data��2��Ϊ�������Ӻ����꣬��Ӧ�����ļ���2��
fluid_y = data{:,3}; %data��3��Ϊ�������������꣬��Ӧ�����ļ���3��
fluid_vx = data{:,4};%data��4��Ϊ�������Ӻ᷽���ٶȣ���Ӧ�����ļ���4��
fluid_vy = data{:,5};%data��5��Ϊ���������ݷ����ٶȣ���Ӧ�����ļ���5��
fluid_density = data{:,6};%data��6��Ϊ���������ܶȣ���Ӧ�����ļ���6��
fluid_pressure = data{:,7};%data��7��Ϊ��������ѹ������Ӧ�����ļ���7��
plot(fluid_x,fluid_y,'.') %��ӡ�����������꣬�γ�ͼ��
fclose(fid); %�ر��ļ�

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
