function forest=random_forest(features, labels, num_trees, max_depth)
    % random_forest Trains a random forest classifier.
    % Parameters:
    %   features - NxF matrix of feature vectors.
    %   labels - Nx1 vector of labels.
    %   num_trees - Number of trees in the forest.
    %   max_depth - Maximum depth for each tree.
    % Returns:
    %   forest - A cell array of decision trees.
    
    N=size(features, 1);
    forest=cell(num_trees, 1);
    
    for t=1:num_trees
        sample_indices=randsample(N, N, true);
        sampled_features=features(sample_indices, :);
        sampled_labels=labels(sample_indices);
        % train the decision tree
        forest{t} = decision_tree(sampled_features, sampled_labels, 0, max_depth);
    end
end

function prediction=predict_forest(forest, features)
    % predict_forest Predicts labels using a random forest.
    % Parameters:
    %   forest - A cell array of decision trees.
    %   features - NxF matrix of feature vectors.
    % Returns:
    %   prediction - Predicted labels (Nx1 vector).
    num_trees=numel(forest);
    predictions=zeros(size(features, 1), num_trees);
    
    for t=1:num_trees
        predictions(:, t)=predict_tree(forest{t}, features);
    end
    %Aggregate predictions (majority voting)
    prediction=mode(predictions, 2);
end
