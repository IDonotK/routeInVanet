function [rsd] = routeChangeDegree(routeTrace_x,routeTrace_y)
    global R;
    
    trace_num = length(routeTrace_x(:,1));
    hop_num = length(routeTrace_x(1,:));
    
    %计算各trace的每条链路值
    link_len = []; %链路长度
    link_angle = []; %链路相对于水平正向的角度值
    link_off = []; %链路通断值 0表示通，1表示断
    for i = 1:trace_num
        for j = 1:(hop_num - 1)
            d =sqrt((routeTrace_x(i,j + 1) - routeTrace_x(i,j))^2 + (routeTrace_y(i,j + 1) - routeTrace_y(i,j))^2);
            link_len(i,j) = d;
            link_angle(i,j) = atan2(routeTrace_y(i,j + 1) - routeTrace_y(i,j),routeTrace_x(i,j + 1) - routeTrace_x(i,j))*180/pi; %atan2 -pi~pi
            if(d <= R)
                link_off(i,j) = 0;
            else
                link_off(i,j) = 1;
            end
        end
    end
    
    %计算链路值相对于now_time=0时刻的变化量
    deta_len = [];
    deta_angle = [];
    for i = 1:(trace_num - 1)
        for j = 1:(hop_num - 1)
            deta_len(i,j) = link_len(i + 1,j) - link_len(1,j);
            deta_angle(i,j) = link_angle(i + 1,j) - link_angle(1,j); %不考虑step_time时间内的运动轨迹，正值表示链路顺时针转动，负值表示链路逆时针转动
        end
    end
    
    %计算链路值变化量的均方差 表示每条链路变化的一致性 但是如果每条链路长度都变长很多呢？
    %kexi_len = std(deta_len,0,2); %kexi_len为列向量
    %kexi_angle = std(deta_angle,0,2);
    
    %计算链路值变化量的均值
    kexi_len = mean(abs(deta_len),2);
    kexi_angle = mean(abs(deta_angle),2);
    
    %kexi_len kexi_angle归一化 sigmoid函数
    kexi_len_1 = [];
    kexi_angle_1 = [];
    for i = 1:(trace_num - 1)
        kexi_len_1 = [kexi_len_1 (1 - 1.2^(-(kexi_len(i))))];
        kexi_angle_1 = [kexi_angle_1 (1 - 1.2^(-(kexi_angle(i))))];
    end
    
    %计算各trace的链路通断率
    link_off_rate = []; %原始路由必定是100%通
    for i = 2:trace_num
        link_off_rate = [link_off_rate sum(link_off(i,:))/(hop_num - 1)];
    end
    %计算路由变化度 加权 链路中断率可以单独作为一个性能指标，但是路由变化度需要和其它协议进行比较
    %link_len_angle = 0.85*kexi_len_1 + 0.15*kexi_angle_1;
    %link_len_angle = kexi_len_1;
    rsd = 0.65*kexi_len_1 + 0.25*kexi_angle_1 + 0.1*link_off_rate;
end
