function normalized_data=preprocess_data(data)
    % preprocess_data Normalizes data.
    % Parameters:
    %   data - Nx3 matrix of fingertip coordinates.
    % Returns:
    %   normalized_data - Normalized Nx3 matrix.
    mean_data=mean(data, 1);
    std_data=std(data, 1);
    normalized_data=(data-mean_data)./std_data;
end
