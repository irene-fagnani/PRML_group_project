clc;
clear all;

train_classifier('training_data');


% Load a test sample (example)
test_sample = load('training_data\stroke_9_0010.mat');
test_sample=test_sample.pos;
% Classify the sample
predicted_digit = digit_classify(test_sample);

% Display the result
fprintf('Predicted digit: %d\n', predicted_digit);
