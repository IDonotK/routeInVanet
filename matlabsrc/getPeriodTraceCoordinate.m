function [routeTrace_x,routeTrace_y] = getPeriodTraceCoordinate(routeTrace)
    global now_time step_time sum_time;
    global nowlocation_x nowlocation_y;
    
    xandy = getTraceCoordinate(routeTrace);
    routeTrace_x = xandy(1,:);
    routeTrace_y = xandy(2,:);
    
    nowlocation_x_temp = nowlocation_x;
    nowlocation_y_temp = nowlocation_y;
    
    step_time = 0.5;
    sum_time = 25;
    for now_time = 0.5:step_time:sum_time
        updateNowLocation();   %now_time应为全局变量，方便更新位置
        xandy = getTraceCoordinate(routeTrace);
        routeTrace_x = [routeTrace_x
                        xandy(1,:)];
        routeTrace_y = [routeTrace_y
                        xandy(2,:)];
        nowlocation_x = nowlocation_x_temp;
        nowlocation_y = nowlocation_y_temp;
    end
end