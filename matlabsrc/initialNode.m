function initialNode(set_node)
	global now_time;
	global area_l area_w num_node;
	global node_x node_y node_id;
	global source_x source_y source_id des_x des_y des_id;
	global neb_node_id neb_node_x neb_node_y num_neb;
	global nowlocation_x nowlocation_y;
	global mobi_model_x mobi_model_y mobi_model_startime mobi_model_speed mobi_model_direct;
	
    %城市双向6车道 十字路口：
    %   每车道宽为3.75米，总共22.5米宽
    %   车速 40~60km/h，临近十字路口(100米以内)15~30km/h,标准30~60km/s 45km/h
    %   方向 0 pi/2 pi 3*pi/2，十字路口区pi/4 7*pi/4 3*pi/4 5*pi/4
    %   单车道车流密度 10 25 30 50 辆/车道/km
    %   车辆通信半径 [100,250] 150 200
    
	now_time = 0;
	area_l = 488.75 + 11.25 + 11.25 + 488.75;
	area_w = 1000;
    single_num_node = set_node; %30
	num_node_temp = single_num_node*3*2*2;
    add_ten_road = 2*fix(num_node_temp/(1000/22.5)); %十字路口密度增大 车辆速度也减小至20km/h 7.0m/s
	num_node = num_node_temp + add_ten_road;
    
	%设置中间节点的位置和ID
    %横向道路
    %   下
	for i = 2:single_num_node*3
		node_x(i) = area_l*rand(1,1);
		node_y(i) = area_w/2 - 11.5*rand(1,1);
		node_id(i) = i;
    end
    %   上
    for i = (single_num_node*3 + 1):single_num_node*6
		node_x(i) = area_l*rand(1,1);
		node_y(i) = area_w/2 + 11.5*rand(1,1);
		node_id(i) = i;
    end
    %纵向道路
    %   左
    for i = (single_num_node*6 + 1):single_num_node*9
        node_x(i) = area_l/2 - 11.5*rand(1,1);
        node_y(i) = area_w*rand(1,1);
        node_id(i) = i;
    end
    %   右
    for i = (single_num_node*9 + 1):(single_num_node*12 - 1)
		node_x(i) = area_l/2 + 11.5*rand(1,1);
		node_y(i) = area_w*rand(1,1);
		node_id(i) = i;
    end
    
    %设置十字路口增加节点的位置和ID
    for i = (single_num_node*12):(num_node - 1)
		node_x(i) = area_l/2 - 11.5 + 2*11.5*rand(1,1);
		node_y(i) = area_w/2 - 11.5 + 2*11.5*rand(1,1);
		node_id(i) = i;
    end
    
	%设置源节点的位置和ID
	source_x = area_l/5*rand(1,1);
	source_y = area_w/2 - 11.5*rand(1,1);
%     source_x = 375;
% 	source_y = area_w/2 - 11.5*rand(1,1);
	source_id = 1;
	node_x(1) = source_x;
	node_y(1) = source_y;
	node_id(1) = source_id;
    
	%设置目的节点的位置和ID 可以调整
	des_x = 4/5*area_l + area_l/5*rand(1,1);
	des_y = area_w/2 - 11.5*rand(1,1);
%     des_x = area_l/2 + 11.5*rand(1,1);
% 	des_y = 875;
	des_id = num_node;
	node_x(num_node) = des_x;
	node_y(num_node) = des_y;
	node_id(num_node) = des_id;
       
	%初始化邻居节点表
	for node_i = 1:num_node
		for num_mem = 1:num_node
			neb_node_x(node_i,num_mem) = 0; %neb_node_x 为 num_node*num_node 的矩阵
			neb_node_y(node_i,num_mem) = 0;
			neb_node_id(node_i,num_mem) = 0;
        end
        num_neb(node_i) = num_mem; %每个节点的邻节点数目都初始化为num_node
	end
	
	%初始化节点的真实位置和对应时间
	nowlocation_x = node_x;
	nowlocation_y = node_y;
	
	%移动模型
	mobi_model_x = node_x;
	mobi_model_y = node_y;
	mobi_model_startime = zeros(1,num_node);
    
    %速度：30~60km/s，正态分布，均值45km/h，方差20，即8.3~16.7m/s 12.5m/s
    %设置源节点以及中间节点的速度
    for i = 1:(num_node_temp - 1)
        speed_temp = normrnd(12.5,20);
        while ~((speed_temp >= 8.3)&&(speed_temp <= 16.7))
            speed_temp = normrnd(12.5,20);
        end
        mobi_model_speed(i) = (30/set_node)^2*speed_temp; %车流密度影响车速
    end
    %设置十字路口增加节点的速度 影响中断率
    for i = num_node_temp:(num_node - 1)
        mobi_model_speed(i) = (30/set_node)^2*7.0;
    end
    %设置目的节点的速度
    speed_temp = normrnd(12.5,20);
        while ~((speed_temp >= 8.3)&&(speed_temp <= 16.7))
            speed_temp = normrnd(12.5,20);
        end
    mobi_model_speed(num_node) = (30/set_node)^2*speed_temp;
    
    %运动方向：[0,pi/4],[7*pi/4,2*pi]
    mobi_model_direct = zeros(1,num_node);
    %设置中间节点的运动方向
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
    %设置十字路口增加节点的运动方向，均匀分布，pi/4 7*pi/4 3*pi/4 5*pi/4
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
    %设置源节点运动方向
    mobi_model_direct(1) = 0;
    %设置目的节点运动方向
    mobi_model_direct(num_node) = 0;
%     mobi_model_direct(num_node) = pi/2;
end