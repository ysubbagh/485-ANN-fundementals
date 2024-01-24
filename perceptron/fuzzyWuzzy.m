% setup layer
fuzzyLayer = PerceptronLayer(2, 1, "hardlim");

%inputs
input = [
    0.5 0.8; 
    0.3 0.5;
    0.7 0.8;
    0.9 0.7;
];

%target values
targets = [0; 0; 1; 1];

%train
%fuzzyLayer.train(input', targets);

fuzzyLayer.print();