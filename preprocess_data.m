function normalized_data = preprocess_data(data)
    % preprocess_data Normalizes the 3D fingertip motion data.
    %
    % Parameters:
    %   data - Nx3 matrix of fingertip coordinates.
    % Returns:
    %   normalized_data - Normalized Nx3 matrix.
    
    % Subtract the mean and divide by the standard deviation
    mean_data = mean(data, 1);
    std_data = std(data, 1);
    normalized_data = (data - mean_data) ./ std_data;
end
