function train_classifier(training_data_folder)
    % train_classifier Trains a digit classification model.
    %
    % Parameters:
    %   training_data_folder - Path to the folder containing training files.

    % Train a Random Forest manually
    max_depth = 10; % Maximum tree depth
    num_trees = 10; % Number of trees in the forest
    
    % Initialize feature and label arrays
    features = [];
    labels = [];
    
    % Load training data
    files = dir(fullfile(training_data_folder, 'stroke_*.csv'));
    for i = 1:length(files)
        % Extract label from filename
        filename = files(i).name;
        parts = strsplit(filename, '_');
        label = str2double(parts{2});
        
        % Load and preprocess data
        data = load(fullfile(training_data_folder, filename));        
        features = [features; extract_features(preprocess_data(data))];
        labels = [labels; label];
    end
    
    % Train a Random Forest classifier

    % this is to test if our written model is right
    %model = fitcensemble(features, labels, 'Method', 'Bag', 'NumLearningCycles', 100, 'Learners', 'tree');

    model = random_forest(features, labels, num_trees, max_depth);    
    
    % Save the trained model
    save('trained_model.mat', 'model');
end
