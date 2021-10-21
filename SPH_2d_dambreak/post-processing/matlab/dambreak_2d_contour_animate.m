%2d dambreak SPH�������
%���ӹ�����ͼ����
%SPH����������ɺ������ļ�������data�ļ����£�����ʱ�䲽��������˳�����ζ��������ļ�
% by hexuan 2021

% ѡ�������ͼ�ı���:
% ѹ��   (   ѹ��<--->1 )
% �ܶ�   (   �ܶ�<--->2 )
% λ��   (   ����λ��<--->3,   ����λ��<--->4    )
% �ٶ�   (   �����ٶ�<--->5,   �����ٶ�<--->6    )
clear;clc;clf; %���
contour_variable = 1;
switch contour_variable
    case {1}
      fluid_variable = 'fluid_pressure';
      colorbar_min = -1000; colorbar_max = 40000; %colorbar��������
    case {2}
      fluid_variable = 'fluid_density';
      colorbar_min = 990; colorbar_max = 1200; %colorbar��������
    case {3}
      fluid_variable = 'fluid_x';
      colorbar_min = 0; colorbar_max = 1; %colorbar��������
    case {4}
      fluid_variable = 'fluid_y';
      colorbar_min = 0; colorbar_max = 0.5; %colorbar��������
    case {5}
      fluid_variable = 'fluid_vx';
      colorbar_min = -6; colorbar_max = 5; %colorbar��������
    case {6}
      fluid_variable = 'fluid_vy';
      colorbar_min = -4; colorbar_max = 7; %colorbar��������
    otherwise
      fprintf('error');
end

 
dt = 0.0001;        %SPH����ģ���ʱ�䲽������λ��s��
print_step = 200;   %���ʱ�䲽���
min_step = 200;     %��ʼʱ�䲽
max_step = 80000;   %����ʱ�䲽

fmin = ones(1,(max_step-min_step)/print_step+1);
fmax = ones(1,(max_step-min_step)/print_step+1);

for current_timestep = min_step : print_step : max_step 
    %��ӡ��Ӧʱ�䲽����������ͼ��
  
filename1=strcat('..\..\data\f_xv',num2str(current_timestep),'.dat'); %strcat����ַ��������� = 'data\f_xv1000.dat'
fid = fopen(filename1); %��filename1�ļ����ļ���ʶ��Ϊfid
data = textscan(fid,'%d %f %f %f %f %f %f %f','HeaderLines',3); %��ȡ���ݣ�data�Ǿ���'HeaderLines',3��ʾ����ǰ3��
fluid_id = data{:,1}; %data��1��Ϊ�������ӱ�ţ���Ӧ�����ļ���1��
fluid_x = data{:,2}; %data��2��Ϊ�������Ӻ����꣬��Ӧ�����ļ���2��
fluid_y = data{:,3}; %data��3��Ϊ�������������꣬��Ӧ�����ļ���3��
fluid_vx = data{:,4};%data��4��Ϊ�������Ӻ����ٶȣ���Ӧ�����ļ���4��
fluid_vy = data{:,5};%data��5��Ϊ�������������ٶȣ���Ӧ�����ļ���5��
fluid_mass = data{:,6};%data��6��Ϊ����������������Ӧ�����ļ���6��
fluid_density = data{:,7};%data��6��Ϊ���������ܶȣ���Ӧ�����ļ���7��
fluid_pressure = data{:,8};%data��7��Ϊ��������ѹ������Ӧ�����ļ���8��
fclose(fid);

 fmin(1,(current_timestep- min_step)/print_step+1) = min(eval(fluid_variable)); 
 fmax(1,(current_timestep- min_step)/print_step+1) = max(eval(fluid_variable));
 if current_timestep == max_step
  colorbar_min_1 = min(fmin)
  colorbar_max_1 = max(fmax)
 end

     colour1 = ones(1,length(eval(fluid_variable))); %ɢ��ͼ����ɫ����
     for ii = 1: length(eval(fluid_variable))
          colour1(1,ii)= eval([fluid_variable,'(ii,1)']);
     end
     scatter(fluid_x,fluid_y,200,colour1,'.'); %��ɢ��ͼ
     colormap jet %������ɫ�ֲ���ȱʡĬ��Ϊ parula������ɫ���Ҽ���ѡ hsv ��hot ��gray ��jet  �� 
     caxis([colorbar_min,colorbar_max]);%colorbar��������
     barname = colorbar;   %�ֲ�����ͼ  
%      barname.Label.String = 'Pressure'; %colorbar�������

    hold on; %���أ������Ǳ���ԭͼ�����ܴ˺���Ƶ��µ����ߣ����ӻ�ͼ��
    %��ӡ�����߽�/ǽ��ͬ��������һ������    
    fid = fopen('..\..\data\xv_vp.dat');
    data = textscan(fid,'%d %f %f %f %f');
    wall_x=data{:,2};
    wall_y=data{:,3};
    plot(wall_x,wall_y,'k.')
    fclose(fid);
    
    %���ͼ�����
    titlename=strcat('current-step = ',num2str(current_timestep),32,32,32,32,'time = ',num2str(current_timestep*dt),'s'); %����ַ�����ͼ����� = ��ǰʱ�䲽+ģ������ʱ��
    title(titlename);  
    
    axis equal; % ��������߶����
    axis([-0.025,1.025,-0.025,1.025]);%�����᷶Χ
    
    k = 1;
    pause(k*dt*print_step); %�������̫�죬������ٶ�,1/k������һ�����ã�
    if current_timestep ~= max_step
        clf; %���ͼ��
    end

end
   