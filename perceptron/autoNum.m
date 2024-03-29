%create layer 
binImg = PerceptronLayer(30, 3 , "hardlim");

%inputs
p0 = [-1 1 1 1 -1 1 -1 -1 -1 1 1 -1 -1 -1 1 1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1 1 1 -1];
p1 = [-1 1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1];
p2 = [1 1 1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 1 1 -1 -1 -1 1 -1 -1 -1 -1 1 1 1 1];
inputPattern = [p0; p1; p2;];

%targets
targets = [1 0 0; 0 1 0; 0 0 1;];

%train
binImg = binImg.train(inputPattern, targets);

%print for validation
%printCon(binImg.weights);

% Number of noisy versions
numVersions = 100;

% Levels of noise
noiseLevels = [2, 4, 6, 8];

% Initialize accuracy matrix
accuracyMatrix = zeros(length(noiseLevels), 1);

for i = 1:length(noiseLevels)
    noiseLevel = noiseLevels(i);
    correctCount = 0;

    % Generate and classify noisy versions
    for j = 1:numVersions
        % Generate noisy versions
        noisyInput = addNoise(inputPattern, noiseLevel);

        % Classify using the trained network
        output = binImg.forwardOps(noisyInput');

        % Check correctness
        if isCorrectlyClassified(output, targets)
            correctCount = correctCount + 1;
        end
    end

    % Calculate accuracy
    accuracyMatrix(i) = (correctCount / numVersions) * 100;
end

% Plot the graph
plot(noiseLevels, accuracyMatrix, '-o');
xlabel('Number of Pixels Flipped');
ylabel('Classification Accuracy (%)');
title('Network Performance with Noisy Inputs');
grid on;

%------- corruption of images / eval performance -----%
%edited input patterns
bad_p0 = addNoise(p0, 10);
bad_p1 = addNoise(p1, 10);
bad_p2 = addNoise(p2, 10);
badInput = [bad_p0; bad_p1; bad_p2;];

n0_weight = binImg.weights(1, :);
n1_weight = binImg.weights(2, :);
n2_weight = binImg.weights(3, :);

printOut(n0_weight);


function pvec = addNoise(pvec, num)
    % ADDNOISE Add noise to "binary" vector
    % pvec pattern vector (-1 and 1)
    % num number of elements to flip randomly
    % Handle special case where there's no noise
    if num == 0
        return;
    end
    % first, generate a random permutation of all indices into pvec
    inds = randperm(length(pvec));
    % then, use the first n elements to flip pixels
    pvec(inds(1:num)) = -pvec(inds(1:num));
end

%----different printing functions----%
%print the image out to a color map, use for weights (output) because of
%color scale
function printOut(vec)
    %adjust to be printed, resshaped for matrix, inverted for grey scale
    matrix = 1 - rot90(flipud(reshape(vec, 5, 6)), 3);
    % Display the matrix using imagesc
    imshow(matrix, 'InitialMagnification', 'fit', 'Colormap', gray);
end

% Print to console, can be used for output or input
function printCon(vec)
    %adjust to be printed, resshaped for matrix
    matrix = rot90(flipud(reshape(vec, 5, 6)), 3);
    %print by row
    for i = 1:size(matrix, 1)
        for j = 1:size(matrix, 2)
            if matrix(i, j) == -1
                fprintf(' ');
            else
                fprintf('■');
            end
        end
        fprintf('\n');
    end
end

% Function to check correctness
function correct = isCorrectlyClassified(output, target)
    [~, predictedClass] = max(output);
    [~, trueClass] = max(target);
    correct = predictedClass == trueClass;
end
