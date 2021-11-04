 %������ͼ
 %����ѡ������ܶȡ��ٶȻ�ѹ����ͼ
clear;clc;clf; %���
print_timestep = 20000;  %����Ҫ���Ƶ�ʱ�䲽
dt = 0.00005;        %SPH����ģ���ʱ�䲽������λ��s��
% ѡ�������ͼ�ı���:
% ѹ��   (   ѹ��<--->1 )
% �ܶ�   (   �ܶ�<--->2 )
% λ��   (   ����λ��<--->3,   ����λ��<--->4    )
% �ٶ�   (   �����ٶ�<--->5,   �����ٶ�<--->6    )
% ѡ�������ͼ�ı���:
% ѹ��   (   ѹ��<--->1 )
% �ܶ�   (   �ܶ�<--->2 )
% λ��   (   ����λ��<--->3,   ����λ��<--->4    )
% �ٶ�   (   �����ٶ�<--->5,   �����ٶ�<--->6    )
contour_variable = 2;
switch contour_variable
    case {1}
      fluid_variable = 'fluid_pressure';wall_variable = 'wall_pressure';
      colorbar_min = -1000; colorbar_max = 12000; %colorbar��������
      titlevar = 'pressure' ; %ͼƬ����
    case {2}
      fluid_variable = 'fluid_density';wall_variable = 'wall_density';
      colorbar_min = 998; colorbar_max = 1012; %colorbar��������
      titlevar = 'density' ; %ͼƬ����
    case {3}
      fluid_variable = 'fluid_x';wall_variable = 'wall_x';
      colorbar_min = 0; colorbar_max = 4; %colorbar��������
      titlevar = 'x�������� ' ; %ͼƬ����
    case {4}
      fluid_variable = 'fluid_y';wall_variable = 'wall_y';
      colorbar_min = 0; colorbar_max = 2; %colorbar��������
       titlevar = 'y�������� ' ; %ͼƬ����
    case {5}
      fluid_variable = 'fluid_vx';wall_variable = 'wall_vx';
      colorbar_min = -1; colorbar_max = 5; %colorbar��������
      titlevar = 'x�����ٶ� ' ; %ͼƬ����
    case {6}
      fluid_variable = 'fluid_vy';wall_variable = 'wall_vy';
      colorbar_min = -1; colorbar_max = 3; %colorbar��������
      titlevar = 'y�����ٶ� ' ; %ͼƬ����
    otherwise
      fprintf('error');
end

%��ӡ��Ӧʱ�䲽����������ͼ��
filename1=strcat('..\..\data\f_xv',num2str(print_timestep),'.dat'); %strcat����ַ��������� = 'data\f_xv1000.dat'
fid = fopen(filename1); %��filename1�ļ����ļ���ʶ��Ϊfid
data = textscan(fid,'%f %f %f %f %f %f %f','HeaderLines',3); %��ȡ���ݣ�data�Ǿ���'HeaderLines',3��ʾ����ǰ3��
fluid_x = data{:,1}; %data��1��Ϊ�������Ӻ����꣬��Ӧ�����ļ���1��
fluid_y = data{:,2}; %data��2��Ϊ�������������꣬��Ӧ�����ļ���2��
fluid_vx = data{:,3};%data��3��Ϊ�������Ӻ����ٶȣ���Ӧ�����ļ���3��
fluid_vy = data{:,4};%data��4��Ϊ�������������ٶȣ���Ӧ�����ļ���4��
fluid_density = data{:,5};%data��5��Ϊ���������ܶȣ���Ӧ�����ļ���5��
fluid_pressure = data{:,6};%data��6��Ϊ��������ѹ������Ӧ�����ļ���6��
fclose(fid);

%  c1 = ones(1,length(fluid_x));
%  for i = 1: length(fluid_x)
%      c1(1,i)= fluid_density(i,1); %ѡ����Ʊ�������ͼ
%  end

colour1 = ones(1,length(eval(fluid_variable))); %ɢ��ͼ����ɫ����
     for ii = 1: length(eval(fluid_variable))
          colour1(1,ii)= eval([fluid_variable,'(ii,1)']);
     end

%scatter(fluid_x,fluid_y,40,c1,'o','filled');
 scatter(fluid_x,fluid_y,40,colour1,'.');
 colormap jet %������ɫ�ֲ���ȱʡĬ��Ϊ parula������ɫ���Ҽ���ѡ hsv ��hot ��gray ��jet  �� 
 caxis([colorbar_min,colorbar_max]);%colorbar��������
 barname = colorbar;   %�ֲ�����ͼ  
%  barname.Label.String = 'pressure (Pa)'; %colorbar�������

hold on %���أ������Ǳ���ԭͼ�����ܴ˺���Ƶ��µ����ߣ����ӻ�ͼ��
% %��ӡ�����߽�/ǽ
% fid = fopen('..\..\data\vp_xv.dat'); %��filename1�ļ����ļ���ʶ��Ϊfid
% %data = textscan(fid,'%f %f %f %f %f %f %f','HeaderLines',3); %��ȡ���ݣ�data�Ǿ���'HeaderLines',3��ʾ����ǰ3��
% data = textscan(fid,'%f %f %f %f');
% wall_x = data{:,1}; %data��2��Ϊ�������Ӻ����꣬��Ӧ�����ļ���2��
% wall_y = data{:,2}; %data��3��Ϊ�������������꣬��Ӧ�����ļ���3��
% plot(wall_x,wall_y,'k.')
% fclose(fid);

%��ӡ��Ӧʱ�䲽�ı߽�����ͼ��
filename2=strcat('..\..\data\vp_xv',num2str(print_timestep),'.dat'); %strcat����ַ��������� = 'data\vp_xv1000.dat'
fid = fopen(filename2); %��filename1�ļ����ļ���ʶ��Ϊfid
data2 = textscan(fid,'%f %f %f %f %f %f %f','HeaderLines',3); %��ȡ���ݣ�data�Ǿ���'HeaderLines',3��ʾ����ǰ3��
wall_x = data2{:,1}; %data��1��Ϊ�߽����Ӻ����꣬��Ӧ�����ļ���1��
wall_y = data2{:,2}; %data��2��Ϊ�߽����������꣬��Ӧ�����ļ���2��
wall_vx = data2{:,3};%data��3��Ϊ�߽����Ӻ����ٶȣ���Ӧ�����ļ���3��
wall_vy = data2{:,4};%data��4��Ϊ�߽����������ٶȣ���Ӧ�����ļ���4��
wall_density = data2{:,5};%data��5��Ϊ�߽������ܶȣ���Ӧ�����ļ���5��
wall_pressure = data2{:,6};%data��6��Ϊ�߽�����ѹ������Ӧ�����ļ���6��
fclose(fid);

%  c2 = ones(1,length(wall_x));
%  for i = 1: length(wall_x)
%      c2(1,i)= wall_density(i,1); %ѡ����Ʊ�������ͼ
%  end
colour2 = ones(1,length(eval(wall_variable))); %ɢ��ͼ����ɫ����
     for ii = 1: length(eval(wall_variable))
          colour2(1,ii)= eval([wall_variable,'(ii,1)']);
     end

%scatter(fluid_x,fluid_y,40,c1,'o','filled');
 scatter(wall_x,wall_y,20,colour2,'.');
%  colormap jet %������ɫ�ֲ���ȱʡĬ��Ϊ parula������ɫ���Ҽ���ѡ hsv ��hot ��gray ��jet  �� 
%  caxis([colorbar_min,colorbar_max]);%colorbar��������
%  barname = colorbar;   %�ֲ�����ͼ  

%���ͼ�����
titlename=strcat('current-step = ',num2str(print_timestep),32,32,32,32,'time = ',num2str(print_timestep*dt),'s',32,32,32,titlevar); %����ַ�����ͼ����� = ��ǰʱ�䲽+ģ������ʱ��
title(titlename); 
axis equal;
axis([-0.025,4.025,-0.025,2.025]);
