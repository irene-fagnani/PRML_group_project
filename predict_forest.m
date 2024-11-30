function prediction = predict_forest(forest, features)
    % predict_forest Predicts labels using a random forest.
    %
    % Parameters:
    %   forest - Cell array of decision trees (10x1 cell array).
    %   features - NxF matrix of feature vectors.
    %
    % Returns:
    %   prediction - Predicted labels (Nx1 vector).

    num_trees = numel(forest); % Number of trees in the forest
    N = size(features, 1); % Number of samples
    all_predictions = zeros(N, num_trees); % Store predictions from each tree

    % Predict using each tree
    for t = 1:num_trees
        all_predictions(:, t) = predict_tree(forest{t}, features);
    end

    % Aggregate predictions (majority voting)
    prediction = mode(all_predictions, 2); % Majority vote across trees
end
