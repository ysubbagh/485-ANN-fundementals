% setup layer
tApp = PerceptronLayer(3, 1, "hardlim");

% Set weights and biases
tApp.weights = [1 1 1];
tApp.bias = [0];

% Test the for pinapple and apple
input = [-1 -1 1; 1 1 -1];

% Forward vectorized
output = tApp.forwardOps(input.').';

%printing
disp("Pineapple: [-1 -1 1]: " + output(1));
disp("Apple: [1 1 -1]: " + output(2));

