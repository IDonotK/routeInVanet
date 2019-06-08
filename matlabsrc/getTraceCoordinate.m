function [xandy] = getTraceCoordinate(routeTrace)
    global nowlocation_x nowlocation_y;
    
    xandy = [];
    for hop_id = 1:length(routeTrace)
        xandy = [xandy [nowlocation_x(routeTrace(hop_id))
                        nowlocation_y(routeTrace(hop_id))]];
    end
end