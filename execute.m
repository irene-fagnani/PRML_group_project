
clc;
clear all;
folderPath='training_data';
fileList=dir(fullfile(folderPath, '*.mat'));
numFiles=length(fileList);
randomIndices=randperm(numFiles);
testRatio=0.2; 
numTestFiles=round(testRatio*numFiles);
testIndices=randomIndices(1:numTestFiles);
trainIndices=randomIndices(numTestFiles+1:end);
testFiles={fileList(testIndices).name};
trainFiles={fileList(trainIndices).name};
for i = 1:length(trainFiles)
    data=load(fullfile(folderPath, trainFiles{i})); 
end

train_classifier('training_data'); 

corrected_classified=0;
for i=1:length(testFiles)
    test_sample=load(fullfile(folderPath, testFiles{i}));
        test_sample=test_sample.pos;
        predicted_digit=digit_classify(test_sample);
        fileName=testFiles{i};
        pattern='stroke_(\d+)_'; 
        tokens=regexp(fileName, pattern, 'tokens');
        true_digit=str2double(tokens{1}{1});
        if(predicted_digit==true_digit)
            corrected_classified=corrected_classified+1;
        end
   
end

fprintf('Accuracy: %.2f%%\n', (corrected_classified/numTestFiles)*100)
