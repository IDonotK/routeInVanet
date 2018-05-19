function [link_matrix] = lsprInitialLink()

    global R num_node;
    global node_x node_y;
    global fis;
    
    %获取预先设计的模糊推理系统
    %fis = readfis('lspRefer');
    fis = readfis('lspFuzzy');
    
    %构造link相关矩阵
    for node_i = 1:num_node
        for node_j = 1:num_node
            d = sqrt((node_x(node_i) - node_x(node_j))^2 + (node_y(node_i) - node_y(node_j))^2);
            if (node_i ~= node_j)
                if (d <= R)
                    link_matrix(node_i,node_j) = 1 - linkStabPre(node_i,node_j); %注意Dijkstra是基于边权值最小，而模糊推理得到的稳定度是越大越好，故 1- 转换
                else
                    link_matrix(node_i,node_j) = inf;
                end
            else
                link_matrix(node_i,node_j) = 0;
            end
        end
    end
end