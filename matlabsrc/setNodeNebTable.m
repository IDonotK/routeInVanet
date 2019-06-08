function setNodeNebTable(set_R)
    global R num_node;
    global node_x node_y node_id;
    global neb_node_id neb_node_x neb_node_y num_neb;
    global neb_node_source_x neb_node_source_y neb_node_source_id;
    global neb_node_des_x neb_node_des_y neb_node_des_id;
    
    R = set_R;
    %������Ϊ�ڵ㽨���ھӽڵ��
	%ע�⣺Դ��Ŀ�Ľڵ㶼�����ڸ����ھӽڵ���ھӽڵ������
	for node_i = 1:num_node
	num_mem = 0;
		for node_j = 1:num_node
			if (node_j ~= node_i) && (sqrt((node_x(node_i) - node_x(node_j))^2 + (node_y(node_i) - node_y(node_j))^2) <= R)
				num_mem = num_mem + 1;
				neb_node_x(node_i,num_mem) = node_x(node_j);
				neb_node_y(node_i,num_mem) = node_y(node_j);
				neb_node_id(node_i,num_mem) = node_id(node_j); %neb_node_id ÿһ�д����������μ�¼���ھӽڵ�ID 
			end
		end
		num_neb(node_i) = num_mem;
	end
	
	%������¼Դ�ڵ���ھӽڵ��
	neb_node_source_x = neb_node_x(1,:);
	neb_node_source_y = neb_node_y(1,:);    
	neb_node_source_id = neb_node_id(1,:);
	
	%������¼Ŀ�Ľڵ���ھӽڵ��
	neb_node_des_x = neb_node_x(num_node,:);
	neb_node_des_y = neb_node_y(num_node,:);    
	neb_node_des_id = neb_node_id(num_node,:);
end