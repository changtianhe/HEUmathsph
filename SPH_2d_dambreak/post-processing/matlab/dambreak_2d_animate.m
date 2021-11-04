%2d dambreak SPH�������
%���ӹ��̶���
%SPH����������ɺ������ļ�������data�ļ����£�����ʱ�䲽������
%��˳�����ζ��������ļ�����forѭ������Ӧʱ�䲽�µ�ͼ���ӡ����Ļ�ϼ��ɡ�
% by hexuan 2021
clear;clc;clf; %���
dt = 0.00005;        %SPH����ģ���ʱ�䲽������λ��s��
print_step = 200;   %���ʱ�䲽���
min_step = 200;     %��ʼʱ�䲽
max_step = 38000;   %����ʱ�䲽
for i = min_step : print_step : max_step 
    %ÿ��ѭ������Ӧʱ�䲽ͼ���ӡ����Ļ�ϣ�i��ʾ��ǰʱ�䲽
    file_id=num2str(i); %��iת�����ַ�����ʽ������file_id
    dir='..\..\data\'; 
    filename1=strcat(dir,'f_xv',file_id,'.dat'); %strcat����ַ��������� = 'f_xv1000.dat'
    fid = fopen(filename1); %��filename1�ļ����ļ���ʶ��Ϊfid
    f_xv = textscan(fid,'%f %f %f %f %f %f %f','HeaderLines',3); % 'HeaderLines',3��ʾ����ǰ3��
    fluid_x=f_xv{:,1}; %�������Ӻ�����
    fluid_y=f_xv{:,2}; %��������������
    plot(fluid_x,fluid_y,'.') %��ӡ�����������꣬�γ�ͼ��
    fclose(fid); %�ر��ļ�
    
    hold on; %���أ������Ǳ���ԭͼ�����ܴ˺���Ƶ��µ����ߣ����ӻ�ͼ��
    %��ӡ�����߽�/ǽ��ͬ��������һ������ 
    filename2=strcat(dir,'vp_xv',file_id,'.dat'); %strcat����ַ��������� = 'f_xv1000.dat'
    fid = fopen(filename2); %��filename1�ļ����ļ���ʶ��Ϊfid
    vp_xv = textscan(fid,'%f %f %f %f %f %f %f','HeaderLines',3); % 'HeaderLines',3��ʾ����ǰ3��
    wall_x=vp_xv{:,1}; %�������Ӻ�����
    wall_y=vp_xv{:,2}; %��������������
    plot( wall_x, wall_y,'k.') %��ӡ�����������꣬�γ�ͼ��
    fclose(fid); %�ر��ļ�
    
    %����ͼ�����
    titlename=strcat('current-step = ',file_id,32,32,32,32,'time = ',num2str(i*dt),'s'); %����ַ�����ͼ����� = ��ǰʱ�䲽+ģ������ʱ��
    title(titlename);  
    
    axis equal; % ��������߶����
    axis([-0.025,4.025,-0.025,2.025]);%�����᷶Χ
    
    k = 1;
    pause(k*dt*print_step); %�������̫�죬������ٶ�,1/k������һ�����ã�
    if i ~= max_step
        clf; %���ͼ��
    end
end
   