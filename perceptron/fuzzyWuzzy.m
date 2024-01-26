% setup layer
fuzzyLayer = PerceptronLayer(2, 1, "hardlim");

%inputs
input = [
    1 4; 
    1 5;
    2 4;
    2 5;
    3 1;
    3 2;
    4 1;
    4 2;
];

%target values
targets = [0; 0; 0; 0; 1; 1; 1; 1;];

%train
fuzzyLayer = fuzzyLayer.train(input, targets);

%printing for validation
fuzzyLayer.print();
output = fuzzyLayer.forwardOps(input.').';
for(i = 1: size(input, 1))
    disp("input: ");
    disp(input(i, :));
    disp("target: " + targets(i, :) + " | output: " + output(i, :));
end