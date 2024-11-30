function C = digit_classify(testdata)
    % digit_classify Classifies a 3D motion data sample.
    %
    % Parameters:
    %   testdata - An Nx3 matrix of fingertip coordinates.
    % Returns:
    %   C - Predicted digit class (integer).
    
    % Preprocess the test data
    preprocessed_data = preprocess_data(testdata);
    
    % Extract features
    features = extract_features(preprocessed_data);
    
    % Load pre-trained model
    load('trained_model.mat', 'model'); % 'model' is the trained classifier
    
    % Classify the input sample
    C = predict_forest(model, features); % model 10x1 cell, features 1x3 array
end
