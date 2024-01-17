% setup layer
t1 = PerceptronLayer(2, 2, "hardlim");

% Set weights and biases for logical AND and OR operations (trial and error)
t1.weights = [1 1; 1 1];
t1.bias = [-1; 0];

% Test the forward methods with binary input patterns
input = [0 0; 0 1; 1 0; 1 1];


% Forward with loop
outputWithForwardLoop = zeros(size(input, 1), t1.numOutputs);
for i = 1:size(input, 1)
    outputWithForwardLoop(i, :) = t1.forwardLoop(input(i, :).');
end

% Forward vectorized
outputForwardOps = t1.forwardOps(input.').';
