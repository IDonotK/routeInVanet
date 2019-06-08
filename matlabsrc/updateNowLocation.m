function updateNowLocation()
    global num_node
    for i = 1:num_node
        getNowLocation(i);
    end
end