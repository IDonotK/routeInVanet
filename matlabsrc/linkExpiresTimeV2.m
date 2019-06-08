function [let] = linkExpiresTimeV2(node_i,node_j)
    global R;
    global mobi_model_x mobi_model_y mobi_model_speed mobi_model_direct;
    time_count = 0;
    time_step = 0.1;
    temp_x_i = mobi_model_x(node_i);
    temp_y_i = mobi_model_y(node_i);
    temp_x_j = mobi_model_x(node_j);
    temp_y_j = mobi_model_y(node_j);
    d = sqrt((temp_x_i - temp_x_j)^2 + (temp_y_i - temp_y_j)^2);
    while (d <= R)&&(time_count <= 100)
        time_count = time_count + time_step;
        
        temp_x_i = mobi_model_x(node_i) + mobi_model_speed(node_i)*time_count*cos(mobi_model_direct(node_i));
        temp_y_i = mobi_model_y(node_i) + mobi_model_speed(node_i)*time_count*sin(mobi_model_direct(node_i));
        [temp_x_i,temp_y_i] = rightLocation(temp_x_i,temp_y_i);
        
        temp_x_j = mobi_model_x(node_j) + mobi_model_speed(node_j)*time_count*cos(mobi_model_direct(node_j));
        temp_y_j = mobi_model_y(node_j) + mobi_model_speed(node_j)*time_count*sin(mobi_model_direct(node_j));
        [temp_x_j,temp_y_j] = rightLocation(temp_x_j,temp_y_j);
        
        d = sqrt((temp_x_i - temp_x_j)^2 + (temp_y_i - temp_y_j)^2);
    end
    let = time_count;
end