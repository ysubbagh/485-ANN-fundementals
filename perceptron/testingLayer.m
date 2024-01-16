% setup layer
t1 = PerceptronLayer(2, 2, "hardlim");

% Set weights and biases for logical AND and OR operations (trial and error)
t1.weights = [1 1; 1 1];
t1.bias = [-1; 0];

% Test the forward methods with binary input patterns
inputPatterns = [0 0; 0 1; 1 0; 1 1];


% Forward with loop
outputWithLoop = zeros(size(inputPatterns, 1), t1.numOutputs);
for i = 1:size(inputPatterns, 1)
    outputWithLoop(i, :) = t1.forwardLoop(inputPatterns(i, :).');
end

% Forward vectorized
outputVectorized = t1.forwardOps(inputPatterns.').';
