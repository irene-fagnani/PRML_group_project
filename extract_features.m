function features=extract_features(data)
    % extract_features Extracts features from preprocessed data.
    % Parameters:
    %   data - Nx3 normalized matrix of fingertip coordinates.
    % Returns:
    %   features - A 1xF vector of extracted features.
    % Feature 1: Stroke duration (number of points)
    duration=size(data, 1);
    % Feature 2: Total path length
    path_length=sum(sqrt(sum(diff(data).^2, 2)));
    % Feature 3: Curvature (sum of absolute changes in direction)
    diffs=diff(data);
    magnitudes=sqrt(sum(diffs.^2, 2));
    directions=diffs./magnitudes;
    curvature=sum(sum(abs(diff(directions)), 2, 'omitnan'));
    features=[duration, path_length, curvature];
end
