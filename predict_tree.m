function prediction = predict_tree(tree, features)
    % predict_tree Predicts labels using a single decision tree.
    %
    % Parameters:
    %   tree - Decision tree structure. (10x1 cell)
    %   features - NxF matrix of feature vectors.
    %
    % Returns:
    %   prediction - Predicted labels (Nx1 vector).
    
    N = size(features, 1);
    prediction = zeros(N, 1);
    
    for i = 1:N
        node = tree;
        while strcmp(node.type, 'node')
            if features(i, node.feature) <= node.threshold
                node = node.left;
            else
                node = node.right;
            end
        end
        prediction(i) = node.class;
    end
end
