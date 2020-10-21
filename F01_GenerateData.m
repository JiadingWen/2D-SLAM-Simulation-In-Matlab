%% ����˵��

% ���ɰ���������Ϣ��RealData (��ʵstate ��ʵfeature �ȵ�)
% ���ɰ����˿��Ի�õ�һ������ NormalData (�������� �۲����� �ȵ�)

%% ����ͷ

% clc
% clear
% close all

%% ������������

mean_noise = 0; % �����ľ�ֵ
StandardDeviation_noise = 0.1; % �����ı�׼��
variance_noise = StandardDeviation_noise^2; % �����ķ���

%% ���� RealData

% Ԥ�����ڴ�
max_DataSize = 200;                            % ������ʵ���ݵ�����, i.e.�ڵ�����
RealData = zeros(max_DataSize,22);           % ʮһ�зֱ�Ϊ:�ڵ� ʱ��ڵ� ʱ������ 
                                             % RobotState 4~6 ��������   7~8 ʵ�ʿ������� 9~10
                                             % feature1 11~12 �۲�����1 13~14 �۲�����1 15~16 
                                             % feature2 17~18 �۲�����2 19~20 �۲�����2 21~22

% ���������������״̬
s = rng;

% ��ʼ���ڵ�1
RealData(1,1) = 0;                                                          % �ڵ� ��0��ʼ
RealData(1,2) = 0;                                                          % ʱ�� ��0s��ʼ
RealData(1,3) = 1;                                                          % ʱ������ ���ڹ̶�Ϊ1s

RealData(1,4) = 0;                                                          % RobotState ��(0,0,0)��ʼ
RealData(1,5) = 0;
RealData(1,6) = 0;                                                          % ���Ϸֱ�Ϊ x y phi

RealData(1,7) = 10;                                                         % �������� linear �̶�Ϊ10 �� ÿ��ǰ��10m
RealData(1,8) = pi/2;                                                       % �������� angular �̶�Ϊ 90 
RealData(1,9) = normrnd(mean_noise,StandardDeviation_noise,1);              % �������� linear ���Ӹ�˹�ֲ� 0 mean 0.1^2 variance 
RealData(1,10) = normrnd(mean_noise,StandardDeviation_noise,1);             % �������� angular ���Ӹ�˹�ֲ� 0 mean 0.1^2 variance 

RealData(1,11) = 5;                                                         % feature1 �������ڵ�λ�� �̶�Ϊ(5,5)
RealData(1,12) = 5;

RealData(1,13) = normrnd(mean_noise,StandardDeviation_noise,1);              % �۲�����1 range ���Ӹ�˹�ֲ� 0 mean 0.1^2 variance 
RealData(1,14) = normrnd(mean_noise,StandardDeviation_noise,1);              % �۲�����1 theta ���Ӹ�˹�ֲ� 0 mean 0.1^2 variance
RealData(1,15) = ((RealData(1,11) - RealData(1,4))^2 + (RealData(1,12) - RealData(1,5))^2)^0.5 + RealData(1,13);                  % �۲�����1 range ����۲�ģ�� 
RealData(1,16) = S_Wrap(atan2((RealData(1,12) - RealData(1,5)),(RealData(1,11) - RealData(1,4))) - RealData(1,6) + RealData(1,14));        % �۲�����1 theta ����۲�ģ�� 

RealData(1,17) = 15;                                                         % feature2 �������ڵ�λ�� �̶�Ϊ(15,5)
RealData(1,18) = 5;

RealData(1,19) = normrnd(mean_noise,StandardDeviation_noise,1);              % �۲�����2 range ���Ӹ�˹�ֲ� 0 mean 0.1^2 variance 
RealData(1,20) = normrnd(mean_noise,StandardDeviation_noise,1);              % �۲�����2 theta ���Ӹ�˹�ֲ� 0 mean 0.1^2 variance
RealData(1,21) = ((RealData(1,17) - RealData(1,4))^2 + (RealData(1,18) - RealData(1,5))^2)^0.5 + RealData(1,19);                  % �۲�����2 range ����۲�ģ�� 
RealData(1,22) = S_Wrap(atan2((RealData(1,18) - RealData(1,5)),(RealData(1,17) - RealData(1,4))) - RealData(1,6) + RealData(1,20));        % �۲�����2 theta ����۲�ģ�� 

%% �ڵ�++
for i = 2:max_DataSize
    
    RealData(i,1) = i-1; 
    RealData(i,2) = RealData(i-1,2) + RealData(i-1,3);
    RealData(i,3) = RealData(i-1,3);
    
    RealData(i,4) = RealData(i-1,4) + (RealData(i-1,7)+ RealData(i-1,9))*RealData(i-1,3)*cos(RealData(i-1,6));    % ����ģ�� �������ģ��
    RealData(i,5) = RealData(i-1,5) + (RealData(i-1,7)+ RealData(i-1,9))*RealData(i-1,3)*sin(RealData(i-1,6));
    RealData(i,6) = S_Wrap(RealData(i-1,6) + (RealData(i-1,8)+ RealData(i-1,10))*RealData(i-1,3));
    
    RealData(i,7) = 10;                                                         % �������� linear �̶�Ϊ10 �� ÿ��ǰ��10m
    RealData(i,8) = pi/2;                                                       % �������� angular �̶�Ϊ 90 
    RealData(i,9) = normrnd(mean_noise,StandardDeviation_noise,1);              % �������� linear ���Ӹ�˹�ֲ� 0 mean 0.1^2 variance 
    RealData(i,10) = normrnd(mean_noise,StandardDeviation_noise,1);             % �������� angular ���Ӹ�˹�ֲ� 0 mean 0.1^2 variance 

    RealData(i,11) = 5;                                                         % feature1 �������ڵ�λ�� �̶�Ϊ(5,5)
    RealData(i,12) = 5;

    RealData(i,13) = normrnd(mean_noise,StandardDeviation_noise,1);              % �۲�����1 range ���Ӹ�˹�ֲ� 0 mean 0.1^2 variance 
    RealData(i,14) = normrnd(mean_noise,StandardDeviation_noise,1);              % �۲�����1 theta ���Ӹ�˹�ֲ� 0 mean 0.1^2 variance
    RealData(i,15) = ((RealData(i,11) - RealData(i,4))^2 + (RealData(i,12) - RealData(i,5))^2)^0.5 + RealData(i,13);                  % �۲�����1 range ����۲�ģ�� 
    RealData(i,16) = S_Wrap(atan2((RealData(i,12) - RealData(i,5)),(RealData(i,11) - RealData(i,4))) - RealData(i,6) + RealData(i,14));        % �۲�����1 theta ����۲�ģ�� 

    RealData(i,17) = 15;                                                         % feature2 �������ڵ�λ�� �̶�Ϊ(15,5)
    RealData(i,18) = 5;

    RealData(i,19) = normrnd(mean_noise,StandardDeviation_noise,1);              % �۲�����2 range ���Ӹ�˹�ֲ� 0 mean 0.1^2 variance 
    RealData(i,20) = normrnd(mean_noise,StandardDeviation_noise,1);              % �۲�����2 theta ���Ӹ�˹�ֲ� 0 mean 0.1^2 variance
    RealData(i,21) = ((RealData(i,17) - RealData(i,4))^2 + (RealData(i,18) - RealData(i,5))^2)^0.5 + RealData(i,19);                  % �۲�����2 range ����۲�ģ�� 
    RealData(i,22) = S_Wrap(atan2((RealData(i,18) - RealData(i,5)),(RealData(i,17) - RealData(i,4))) - RealData(i,6) + RealData(i,20));        % �۲�����2 theta ����۲�ģ�� 
    
end

% ���� RealDta
save M_RealData RealData

%% ���� NormalData

% Ԥ�����ڴ�
NormalData = zeros(max_DataSize,9); % ���зֱ�Ϊ:�ڵ� ʱ��ڵ� ʱ������ �������� 4~5 �۲�����1 6~7 �۲�����2 8~9

% �� RealData ����ȡ NormalData
NormalData(:,1) = RealData(:,1); % �ڵ�
NormalData(:,2) = RealData(:,2); % ʱ��ڵ�
NormalData(:,3) = RealData(:,3); % ʱ������

NormalData(:,[4 5]) = RealData(:,[7 8]); % ��������

NormalData(:,[6 7]) = RealData(:,[15 16]); % �۲�����1
NormalData(:,[8 9]) = RealData(:,[21 22]); % �۲�����2

% ���� NormalData
save M_NormalData NormalData






