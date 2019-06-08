function initialNode(set_node)
	global now_time;
	global area_l area_w num_node;
	global node_x node_y node_id;
	global source_x source_y source_id des_x des_y des_id;
	global neb_node_id neb_node_x neb_node_y num_neb;
	global nowlocation_x nowlocation_y;
	global mobi_model_x mobi_model_y mobi_model_startime mobi_model_speed mobi_model_direct;
	
    %����˫��6���� ʮ��·�ڣ�
    %   ÿ������Ϊ3.75�ף��ܹ�22.5�׿�
    %   ���� 40~60km/h���ٽ�ʮ��·��(100������)15~30km/h,��׼30~60km/s 45km/h
    %   ���� 0 pi/2 pi 3*pi/2��ʮ��·����pi/4 7*pi/4 3*pi/4 5*pi/4
    %   �����������ܶ� 10 25 30 50 ��/����/km
    %   ����ͨ�Ű뾶 [100,250] 150 200
    
	now_time = 0;
	area_l = 488.75 + 11.25 + 11.25 + 488.75;
	area_w = 1000;
    single_num_node = set_node; %30
	num_node_temp = single_num_node*3*2*2;
    add_ten_road = 2*fix(num_node_temp/(1000/22.5)); %ʮ��·���ܶ����� �����ٶ�Ҳ��С��20km/h 7.0m/s
	num_node = num_node_temp + add_ten_road;
    
	%�����м�ڵ��λ�ú�ID
    %�����·
    %   ��
	for i = 2:single_num_node*3
		node_x(i) = area_l*rand(1,1);
		node_y(i) = area_w/2 - 11.5*rand(1,1);
		node_id(i) = i;
    end
    %   ��
    for i = (single_num_node*3 + 1):single_num_node*6
		node_x(i) = area_l*rand(1,1);
		node_y(i) = area_w/2 + 11.5*rand(1,1);
		node_id(i) = i;
    end
    %�����·
    %   ��
    for i = (single_num_node*6 + 1):single_num_node*9
        node_x(i) = area_l/2 - 11.5*rand(1,1);
        node_y(i) = area_w*rand(1,1);
        node_id(i) = i;
    end
    %   ��
    for i = (single_num_node*9 + 1):(single_num_node*12 - 1)
		node_x(i) = area_l/2 + 11.5*rand(1,1);
		node_y(i) = area_w*rand(1,1);
		node_id(i) = i;
    end
    
    %����ʮ��·�����ӽڵ��λ�ú�ID
    for i = (single_num_node*12):(num_node - 1)
		node_x(i) = area_l/2 - 11.5 + 2*11.5*rand(1,1);
		node_y(i) = area_w/2 - 11.5 + 2*11.5*rand(1,1);
		node_id(i) = i;
    end
    
	%����Դ�ڵ��λ�ú�ID
	source_x = area_l/5*rand(1,1);
	source_y = area_w/2 - 11.5*rand(1,1);
%     source_x = 375;
% 	source_y = area_w/2 - 11.5*rand(1,1);
	source_id = 1;
	node_x(1) = source_x;
	node_y(1) = source_y;
	node_id(1) = source_id;
    
	%����Ŀ�Ľڵ��λ�ú�ID ���Ե���
	des_x = 4/5*area_l + area_l/5*rand(1,1);
	des_y = area_w/2 - 11.5*rand(1,1);
%     des_x = area_l/2 + 11.5*rand(1,1);
% 	des_y = 875;
	des_id = num_node;
	node_x(num_node) = des_x;
	node_y(num_node) = des_y;
	node_id(num_node) = des_id;
       
	%��ʼ���ھӽڵ��
	for node_i = 1:num_node
		for num_mem = 1:num_node
			neb_node_x(node_i,num_mem) = 0; %neb_node_x Ϊ num_node*num_node �ľ���
			neb_node_y(node_i,num_mem) = 0;
			neb_node_id(node_i,num_mem) = 0;
        end
        num_neb(node_i) = num_mem; %ÿ���ڵ���ڽڵ���Ŀ����ʼ��Ϊnum_node
	end
	
	%��ʼ���ڵ����ʵλ�úͶ�Ӧʱ��
	nowlocation_x = node_x;
	nowlocation_y = node_y;
	
	%�ƶ�ģ��
	mobi_model_x = node_x;
	mobi_model_y = node_y;
	mobi_model_startime = zeros(1,num_node);
    
    %�ٶȣ�30~60km/s����̬�ֲ�����ֵ45km/h������20����8.3~16.7m/s 12.5m/s
    %����Դ�ڵ��Լ��м�ڵ���ٶ�
    for i = 1:(num_node_temp - 1)
        speed_temp = normrnd(12.5,20);
        while ~((speed_temp >= 8.3)&&(speed_temp <= 16.7))
            speed_temp = normrnd(12.5,20);
        end
        mobi_model_speed(i) = (30/set_node)^2*speed_temp; %�����ܶ�Ӱ�쳵��
    end
    %����ʮ��·�����ӽڵ���ٶ� Ӱ���ж���
    for i = num_node_temp:(num_node - 1)
        mobi_model_speed(i) = (30/set_node)^2*7.0;
    end
    %����Ŀ�Ľڵ���ٶ�
    speed_temp = normrnd(12.5,20);
        while ~((speed_temp >= 8.3)&&(speed_temp <= 16.7))
            speed_temp = normrnd(12.5,20);
        end
    mobi_model_speed(num_node) = (30/set_node)^2*speed_temp;
    
    %�˶�����[0,pi/4],[7*pi/4,2*pi]
    mobi_model_direct = zeros(1,num_node);
    %�����м�ڵ���˶�����
    for i = 2:single_num_node*3
        mobi_model_direct(i) = 0;
    end
    for i = (single_num_node*3 + 1):single_num_node*6
        mobi_model_direct(i) = pi;
    end
    for i = (single_num_node*6 + 1):single_num_node*9
        mobi_model_direct(i) = 3*pi/2;
    end
    for i = (single_num_node*9 + 1):(single_num_node*12 - 1)
        mobi_model_direct(i) = pi/2;
    end
    %����ʮ��·�����ӽڵ���˶����򣬾��ȷֲ���pi/4 7*pi/4 3*pi/4 5*pi/4
    for i = num_node_temp:(num_node - 1)
        direct_flag = rand(1,1);
        if direct_flag <= 0.25
            mobi_model_direct(i) = pi/4;
        elseif (direct_flag > 0.25)&&(direct_flag <= 0.5)
            mobi_model_direct(i) = 3*pi/4;
        elseif (direct_flag > 0.5)&&(direct_flag <= 0.75)
            mobi_model_direct(i) = 5*pi/4;
        else
            mobi_model_direct(i) = 7*pi/4;
        end
    end
    %����Դ�ڵ��˶�����
    mobi_model_direct(1) = 0;
    %����Ŀ�Ľڵ��˶�����
    mobi_model_direct(num_node) = 0;
%     mobi_model_direct(num_node) = pi/2;
end