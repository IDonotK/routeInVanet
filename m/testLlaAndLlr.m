function testLlaAndLlr()
    %初始化节点
    initialNode(30);

    %初始化邻节点表
    setNodeNebTable(150);
    
    global source_x source_y des_x des_y num_node;
    global node_x node_y;
    global now_time step_time sum_time;
    global nowlocation_x nowlocation_y;
    
    nowlocation_x_temp = nowlocation_x;
    nowlocation_y_temp = nowlocation_y;
    
    %LSPR
    now_time = 0;
    nowlocation_x = nowlocation_x_temp;
    nowlocation_y = nowlocation_y_temp;
    [~,routeTrace1] = LSPR();
    [routeTrace_x1,routeTrace_y1] = getPeriodTraceCoordinate(routeTrace1);
    rsd1 = routeChangeDegree(routeTrace_x1,routeTrace_y1);
    
    %AODV
    now_time = 0;
    nowlocation_x = nowlocation_x_temp;
    nowlocation_y = nowlocation_y_temp;
    [~,routeTrace2] = AODV();
    [routeTrace_x2,routeTrace_y2] = getPeriodTraceCoordinate(routeTrace2);
    rsd2 = routeChangeDegree(routeTrace_x2,routeTrace_y2);
    
    %GPSR
    now_time = 0;
    nowlocation_x = nowlocation_x_temp;
    nowlocation_y = nowlocation_y_temp;
    routeTrace3 = GPSR();
    [routeTrace_x3,routeTrace_y3] = getPeriodTraceCoordinate(routeTrace3);
    rsd3 = routeChangeDegree(routeTrace_x3,routeTrace_y3);
    
    
    %绘图
    %画出LSPR路由移动图
    figure(1)
%     plot(source_x,source_y,'rd');
%     text(source_x + 2,source_y,'S','FontSize',18);
%     hold on;
%     plot(des_x,des_y,'rd');
%     text(des_x + 2,des_y,'D','FontSize',18);
%     hold on;
%     scatter(node_x(2:(num_node - 1)),node_y(2:(num_node - 1)),8,'k');
%     hold on;
    for i = 1:length(routeTrace_x1(:,1))
        if(i == 1)
            plot(routeTrace_x1(i,:),routeTrace_y1(i,:),'r-o','LineWidth',2);
            hold on;
        else
            plot(routeTrace_x1(i,:),routeTrace_y1(i,:),'b--','LineWidth',1);
            hold on;
        end
    end
    %横向
    plot_l = max(routeTrace_x1(length(routeTrace_x1(:,1)),:));
    hold on;
    plot([0 488.75],[488.75 488.75],'k-');
    hold on;
    plot([0 488.75],[500 500],'k--');
    hold on;
    plot([0 488.75],[500-3.75 500-3.75],'g--');
    hold on;
    plot([0 488.75],[500-2*3.75 500-2*3.75],'g--');
    hold on;
    plot([0 488.75],[500+3.75 500+3.75],'g--');
    hold on;
    plot([0 488.75],[500+2*3.75 500+2*3.75],'g--');
    hold on;
    plot([0 488.75],[511.25 511.25],'k-');
    hold on;
    plot([511.25 plot_l],[488.75 488.75],'k-');
    hold on;
    plot([511.25 plot_l],[500 500],'k--');
    hold on;
    plot([511.25 plot_l],[500-3.75 500-3.75],'g--');
    hold on;
    plot([511.25 plot_l],[500-2*3.75 500-2*3.75],'g--');
    hold on;
    plot([511.25 plot_l],[500+3.75 500+3.75],'g--');
    hold on;
    plot([511.25 plot_l],[500+2*3.75 500+2*3.75],'g--');
    hold on;
    plot([511.25 plot_l],[511.25 511.25],'k-');
    hold on;
    %纵向
    plot([488.75 488.75],[0 488.75],'k-');
    hold on;
    plot([500 500],[0 488.75],'k--');
    hold on;
    plot([511.25 511.25],[0 488.75],'k-');
    hold on;
    plot([488.75 488.75],[511.25 1000],'k-');
    hold on;
    plot([500 500],[511.25 1000],'k--');
    hold on;
    plot([511.25 511.25],[511.25 1000],'k-');
    hold on;
    xlabel('横向道路(m)');
    ylabel('纵向道路(m)');
    title('LSPR路由移动图');
    
     %画出AODV路由移动图
    figure(2)
%     plot(source_x,source_y,'rd');
%     text(source_x + 2,source_y,'S','FontSize',18);
%     hold on;
%     plot(des_x,des_y,'rd');
%     text(des_x + 2,des_y,'D','FontSize',18);
%     hold on;
%     scatter(node_x(2:(num_node - 1)),node_y(2:(num_node - 1)),8,'k');
%     hold on;
    for i = 1:length(routeTrace_x2(:,1))
        if(i == 1)
            plot(routeTrace_x2(i,:),routeTrace_y2(i,:),'r-o', 'LineWidth', 2);
            hold on;
        else
            plot(routeTrace_x2(i,:),routeTrace_y2(i,:),'b--', 'LineWidth', 1);
            hold on;
        end
    end
    %横向
    plot_l = max(routeTrace_x2(length(routeTrace_x2(:,1)),:));
    hold on;
    plot([0 488.75],[488.75 488.75],'k-');
    hold on;
    plot([0 488.75],[500 500],'k--');
    hold on;
    plot([0 488.75],[500-3.75 500-3.75],'g--');
    hold on;
    plot([0 488.75],[500-2*3.75 500-2*3.75],'g--');
    hold on;
    plot([0 488.75],[500+3.75 500+3.75],'g--');
    hold on;
    plot([0 488.75],[500+2*3.75 500+2*3.75],'g--');
    hold on;
    plot([0 488.75],[511.25 511.25],'k-');
    hold on;
    plot([511.25 plot_l],[488.75 488.75],'k-');
    hold on;
    plot([511.25 plot_l],[500 500],'k--');
    hold on;
    plot([511.25 plot_l],[500-3.75 500-3.75],'g--');
    hold on;
    plot([511.25 plot_l],[500-2*3.75 500-2*3.75],'g--');
    hold on;
    plot([511.25 plot_l],[500+3.75 500+3.75],'g--');
    hold on;
    plot([511.25 plot_l],[500+2*3.75 500+2*3.75],'g--');
    hold on;
    plot([511.25 plot_l],[511.25 511.25],'k-');
    hold on;
    %纵向
    plot([488.75 488.75],[0 488.75],'k-');
    hold on;
    plot([500 500],[0 488.75],'k--');
    hold on;
    plot([511.25 511.25],[0 488.75],'k-');
    hold on;
    plot([488.75 488.75],[511.25 1000],'k-');
    hold on;
    plot([500 500],[511.25 1000],'k--');
    hold on;
    plot([511.25 511.25],[511.25 1000],'k-');
    hold on;
    xlabel('横向道路(m)');
    ylabel('纵向道路(m)');
    title('AODV路由移动图');
    
    %画出GPSR路由移动图
    figure(3)
%     plot(source_x,source_y,'rd');
%     text(source_x + 2,source_y,'S','FontSize',18);
%     hold on;
%     plot(des_x,des_y,'rd');
%     text(des_x + 2,des_y,'D','FontSize',18);
%     hold on;
%     scatter(node_x(2:(num_node - 1)),node_y(2:(num_node - 1)),8,'k');
%     hold on;
    for i = 1:length(routeTrace_x3(:,1))
        if(i == 1)
            plot(routeTrace_x3(i,:),routeTrace_y3(i,:),'r-o', 'LineWidth', 2);
            hold on;
        else
            plot(routeTrace_x3(i,:),routeTrace_y3(i,:),'b--', 'LineWidth', 1);
            hold on;
        end
    end
    %横向
    plot_l = max(routeTrace_x3(length(routeTrace_x3(:,1)),:));
    hold on;
    plot([0 488.75],[488.75 488.75],'k-');
    hold on;
    plot([0 488.75],[500 500],'k--');
    hold on;
    plot([0 488.75],[500-3.75 500-3.75],'g--');
    hold on;
    plot([0 488.75],[500-2*3.75 500-2*3.75],'g--');
    hold on;
    plot([0 488.75],[500+3.75 500+3.75],'g--');
    hold on;
    plot([0 488.75],[500+2*3.75 500+2*3.75],'g--');
    hold on;
    plot([0 488.75],[511.25 511.25],'k-');
    hold on;
    plot([511.25 plot_l],[488.75 488.75],'k-');
    hold on;
    plot([511.25 plot_l],[500 500],'k--');
    hold on;
    plot([511.25 plot_l],[500-3.75 500-3.75],'g--');
    hold on;
    plot([511.25 plot_l],[500-2*3.75 500-2*3.75],'g--');
    hold on;
    plot([511.25 plot_l],[500+3.75 500+3.75],'g--');
    hold on;
    plot([511.25 plot_l],[500+2*3.75 500+2*3.75],'g--');
    hold on;
    plot([511.25 plot_l],[511.25 511.25],'k-');
    hold on;
    %纵向
    plot([488.75 488.75],[0 488.75],'k-');
    hold on;
    plot([500 500],[0 488.75],'k--');
    hold on;
    plot([511.25 511.25],[0 488.75],'k-');
    hold on;
    plot([488.75 488.75],[511.25 1000],'k-');
    hold on;
    plot([500 500],[511.25 1000],'k--');
    hold on;
    plot([511.25 511.25],[511.25 1000],'k-');
    hold on;
    xlabel('横向道路(m)');
    ylabel('纵向道路(m)');
    title('GPSR路由移动图');

    time_i = 1:step_time*2:sum_time*2;
    figure(4)
    plot(time_i,rsd1,'-o');
    hold on;
    plot(time_i,rsd2,'-^');
    hold on;
    plot(time_i,rsd3,'-d');
    legend('LSPR','AODV','GPSR');
    xlabel('Time(s)');
    ylabel('Route Change Degree');
    grid on;
    title('路由变化度 车流密度:30veh/(lane*km) 通信半径:150m');

    figure(5)
    time_i = [0 time_i];
    rsd1 = smooth(rsd1,15);
    rsd2 = smooth(rsd2,15);
    rsd3 = smooth(rsd3,15);
    rsd11 = [0 rsd1'];
    rsd22 = [0 rsd2'];
    rsd33 = [0 rsd3'];
    plot(time_i,rsd11,'-o');
    hold on;
    plot(time_i,rsd22,'-^');
    hold on;
    plot(time_i,rsd33,'-d');
    legend('LSPR','AODV','GPSR');
    xlabel('Time(s)');
    ylabel('Route Change Degree');
    grid on;
    title('路由变化度 车流密度:25veh/(lane*km) 通信半径:150m');
end