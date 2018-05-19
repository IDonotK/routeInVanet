function [ret1,ret2] = routeExpiresTime(routeTrace)
    ret_set = [];
    for hop_id = 1:(length(routeTrace) - 1)
        ret_set(hop_id) = linkExpiresTimeV2(routeTrace(hop_id),routeTrace(hop_id + 1));
    end
    ret1 = min(ret_set);
    ret2 = mean(ret_set);
end