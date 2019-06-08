function [route_trace] = GPSR()
    %���賵���ڵ�λ�����ӳ��ڵ��ƶ����Բ���
    global R;
    global source_x source_y source_id des_x des_y des_id;
    global neb_node_id neb_node_x neb_node_y num_neb;
    global neb_node_source_x neb_node_source_y neb_node_source_id;
    global nowlocation_x nowlocation_y;
    
    %��ʼ��·����Ϣ
    route_hop = 1;
    present_node_id(route_hop) = source_id; %��Դ�ڵ���Ϊ·���ĵ�һ���ڵ�

    %Դ�ڵ���㵽Ŀ�Ľڵ�ľ���
	min_mem_1 = sqrt((source_x-des_x)^2 + (source_y-des_y)^2);
    
	%Դ�ڵ�������ڵ�ID
	next_hop_node_coordinate = source_id;
    
    num_source_neb = num_neb(1);
    
	%Դ�ڵ��ж���Ŀ�Ľڵ��ǲ����ھ�
	if  min_mem_1 <= R  %Դ��Ŀ�Ľڵ����ھӣ�ֱ�ӷ��ͣ�����Ŀ�Ľڵ���Ϊ�����ڵ�
        next_hop_node_coordinate = des_id;
	else                      
		if num_source_neb ~= 0  %ԴĿ�Ĳ����ھӣ����ڽڵ��ǿ���ʼ̰��ת��
            flag_no_void_source = 0;
            for i_num_source_neb = 1:num_source_neb
                if sqrt((neb_node_source_x(i_num_source_neb)-des_x)^2 + (neb_node_source_y(i_num_source_neb)-des_y)^2) < min_mem_1
                    min_mem_1 = sqrt((neb_node_source_x(i_num_source_neb)-des_x)^2+(neb_node_source_y(i_num_source_neb)-des_y)^2);
                    next_hop_node_coordinate = neb_node_source_id(i_num_source_neb);
                    flag_no_void_source = 1;
                end
            end
		end
		if flag_no_void_source == 0   %̰��ʧ�ܣ��������ַ���ת��
			b_in = atan((source_y-0)/(source_x-0));
			if b_in < 0
				b_in = b_in+2*pi;
			end
			sita_min = 3*pi;
			for i_num_source = 1:num_source_neb
				b_a = atan((source_y-neb_node_source_y(i_num_source_neb))/(source_x-neb_node_source_x(i_num_source_neb)));
				if b_a < 0
					b_a = b_a + 2*pi;
				end
				sita_b = b_a - b_in;
				if sita_b < 0
					sita_b = sita_b + 2*pi;
				end
				if sita_b < sita_min
					sita_min = sita_b;
					a_min = neb_node_source_id(i_num_source_neb);
					return;
				end
			end
			next_hop_node_coordinate = a_min;  %������ID�ҵ�
		end
    end
    
    %���ڵ���뵽·����
    pre_hop_node_id(route_hop) = present_node_id(route_hop);
    route_hop = route_hop + 1;
    present_node_id(route_hop) = next_hop_node_coordinate;
    
    while sqrt((nowlocation_x(present_node_id(route_hop))-des_x)^2 + (nowlocation_y(present_node_id(route_hop))-des_y)^2) > R %��Ŀ�Ľڵ����ھӣ�ֱ�ӷ����ݸ�Ŀ�Ľڵ�
		%��Ŀ�Ľڵ㲻���ھӽڵ㣬��Ҫ��̰�����ܱ�ת��
		%���㵱ǰ�ڵ㵽Ŀ�Ľڵ�ľ��룬Ѱ�����ھӽڵ��о���Ŀ�Ľڵ�����Ľڵ�
		min_mem_2 = sqrt((nowlocation_x(present_node_id(route_hop))-des_x)^2 + (nowlocation_y(present_node_id(route_hop))-des_y)^2);
		if num_neb(present_node_id(route_hop)) ~= 0
			flag_no_void = 0;
			for i_num_node_neb = 1:num_neb(present_node_id(route_hop))
				if sqrt((neb_node_x(present_node_id(route_hop),i_num_node_neb)-des_x)^2 + (neb_node_y(present_node_id(route_hop),i_num_node_neb)-des_y)^2) < min_mem_2
					min_mem_2 = sqrt((neb_node_x(present_node_id(route_hop),i_num_node_neb)-des_x)^2 + (neb_node_y(present_node_id(route_hop),i_num_node_neb)-des_y)^2);
					next_hop_node_coordinate_temp = neb_node_id(present_node_id(route_hop),i_num_node_neb);
					flag_no_void = 1;
				end
			end
			if flag_no_void == 1
				next_hop_node_coordinate = next_hop_node_coordinate_temp;
			elseif flag_no_void == 0    %right hand rule
                b_in = atan((nowlocation_y(present_node_id(route_hop))-nowlocation_y(pre_hop_node_id(route_hop-1)))/(nowlocation_x(present_node_id(route_hop))-nowlocation_x(pre_hop_node_id(route_hop-1))));
                if b_in < 0
                    b_in = b_in + 2*pi;
                end
                sita_min = 3*pi;
                flag_a_min_avail = 0;
                for i_num_node_neb = 1:num_neb(present_node_id(route_hop))
                    if nowlocation_x(pre_hop_node_id(route_hop)) ~= neb_node_x(present_node_id(route_hop),i_num_node_neb)
                        b_a = atan((nowlocation_y(present_node_id(route_hop))-neb_node_y(present_node_id(route_hop),i_num_node_neb))/(nowlocation_x(present_node_id(route_hop))-neb_node_x(present_node_id(route_hop),i_num_node_neb)));
                        if b_a < 0
                            b_a = b_a + 2*pi;
                        end
                        if (b_a-b_in) < 0
                            sita_b = (b_a-b_in) + 2*pi;
                        else 
                            sita_b = b_a - b_in;
                        end
                        if sita_b < sita_min
                            sita_min = sita_b;
                            a_min = neb_node_id(present_node_id(route_hop),i_num_node_neb);
                            flag_a_min_avail = 1;
                        end
                    end
                end
                if flag_a_min_avail == 1
                    next_hop_node_coordinate = a_min;
                else
                    error('Routing unsucessful');
                end
            end    
        end
        %���ڵ���뵽·����
        pre_hop_node_id(route_hop) = present_node_id(route_hop);
        route_hop = route_hop + 1;
        present_node_id(route_hop) = next_hop_node_coordinate;
    end
    
    %��Ŀ�Ľڵ����·����
    pre_hop_node_id(route_hop) = present_node_id(route_hop);
    route_hop = route_hop + 1;
    present_node_id(route_hop) = des_id;
    
    route_trace = present_node_id;
end