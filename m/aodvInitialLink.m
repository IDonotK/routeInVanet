function [link_matrix] = aodvInitialLink()

    global R num_node;
    global node_x node_y;
    
    %构造link相关矩阵
    for node_i = 1:num_node
        for node_j = 1:num_node
            d = sqrt((node_x(node_i) - node_x(node_j))^2 + (node_y(node_i) - node_y(node_j))^2);
            if (node_i ~= node_j)
                if (d <= R)
                    link_matrix(node_i,node_j) = 1; %基于最少跳数
                else
                    link_matrix(node_i,node_j) = inf;
                end
            else
                link_matrix(node_i,node_j) = 0;
            end
        end
    end
end