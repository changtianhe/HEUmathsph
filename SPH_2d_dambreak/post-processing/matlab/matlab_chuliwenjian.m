clear;
clc;
hold on
%���ȴ�����ļ�.txt��fid���ڴ洢�ļ���λ��
fid = fopen('�����ļ�.txt') ;
%��fgetl ��ǰ�� 7�� ע��fgetl������Կյ��У���������յ��У���fgetl�����һ���յ��ַ���
for i = 1 : 7
tline = fgetl(fid) ; %fgetl һ�ν�����һ�У���������һ�е��ַ���
if ~ischar(tline), break, end %����Ƿ����ɹ�����ʧ�����˳�ѭ��
disp(tline) %��ʾ������е����ݣ���Ҳ���԰����洢��ĳ���ַ���������
end %ѭ����������ʱfid ͣ����fgetl������һ��ĩ�ˡ�
%����ǰ7�к���fscanf������
fscanf(fid,'%c')
%��������Ὣ�ļ����������µ��������ַ��ĸ�ʽ���룬���������Ļ�ϣ�
%�����ָ�����������ַ�ͨ��ʹ��fscanf(fid,'%c',N)��NΪ����Ҫ���ĸ��������Ҫ�����Ļ�ʹ��'%d'��'%f'
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