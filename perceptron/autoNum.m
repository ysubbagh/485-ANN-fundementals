% setup layer
binImg = PerceptronLayer(30, 3, "hardlim");

%inputs
p0 = [-1 1 1 1 -1 1 -1 -1 -1 1 1 -1 -1 -1 1 1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1 1 1 -1]';
p1 = [-1 1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1]';
p2 = [1 1 1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 1 1 -1 -1 -1 1 -1 -1 -1 -1 1 1 1 1]';
inputPattern = [p0 p1 p2];

%targets
t0 = [1 0 0]';
t1 = [0 1 0]';
t2 = [0 0 1]';
targets = [t0 t1 t2];

%train
binImg = binImg.train(inputPattern, targets);