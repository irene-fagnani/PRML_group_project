function tree = decision_tree(features, labels, depth, max_depth)
    % decision_tree Trains a decision tree classifier.
    %
    % Parameters:
    %   features - NxF matrix of feature vectors.
    %   labels - Nx1 vector of labels.
    %   depth - Current depth of the tree.
    %   max_depth - Maximum depth of the tree.
    %
    % Returns:
    %   tree - A structure representing the decision tree.
    
    % Base case: Stop if all labels are the same or max depth is reached
    if numel(unique(labels)) == 1 || depth >= max_depth
        tree = struct('type', 'leaf', 'class', mode(labels));
        return;
    end
    
    % Find the best split
    [best_feature, best_threshold] = find_best_split(features, labels);
    
    if isempty(best_feature)
        % No valid split found, create a leaf node
        tree = struct('type', 'leaf', 'class', mode(labels));
        return;
    end
    
    % Split the data
    left_indices = features(:, best_feature) <= best_threshold;
    right_indices = ~left_indices;
    
    % Recursively build the tree
    left_subtree = decision_tree(features(left_indices, :), labels(left_indices), depth + 1, max_depth);
    right_subtree = decision_tree(features(right_indices, :), labels(right_indices), depth + 1, max_depth);
    
    % Create a node
    tree = struct('type', 'node', ...
                  'feature', best_feature, ...
                  'threshold', best_threshold, ...
                  'left', left_subtree, ...
                  'right', right_subtree);
end

function [best_feature, best_threshold] = find_best_split(features, labels)
    % find_best_split Finds the best feature and threshold to split the data.
    %
    % Parameters:
    %   features - NxF matrix of feature vectors.
    %   labels - Nx1 vector of labels.
    %
    % Returns:
    %   best_feature - Index of the best feature to split on.
    %   best_threshold - Threshold value for the best split.
    
    [N, F] = size(features);
    best_feature = [];
    best_threshold = [];
    best_gini = inf;
    
    for f = 1:F
        thresholds = unique(features(:, f)); % Potential thresholds
        for t = 1:numel(thresholds)
            threshold = thresholds(t);
            
            % Split the data
            left_indices = features(:, f) <= threshold;
            right_indices = ~left_indices;
            
            % Compute Gini impurity
            gini = compute_gini(labels(left_indices)) * sum(left_indices) / N + ...
                   compute_gini(labels(right_indices)) * sum(right_indices) / N;
            
            % Update the best split
            if gini < best_gini
                best_gini = gini;
                best_feature = f;
                best_threshold = threshold;
            end
        end
    end
end

function gini = compute_gini(labels)
    % compute_gini Computes the Gini impurity of a set of labels.
    %
    % Parameters:
    %   labels - Vector of labels.
    %
    % Returns:
    %   gini - Gini impurity value.
    
    classes = unique(labels);
    gini = 1 - sum((sum(labels == classes') / numel(labels)).^2);
end
