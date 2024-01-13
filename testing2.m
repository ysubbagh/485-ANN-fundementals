t1 = triple_neuron([4 4], [.5 2], 1);
disp("t1 (for-loop): " + t1);

t3 = tri_neuron_mul([4 4], [.5 2], 1);

t2 = dot([4 4], [.5 2]) + 1;
t2 = hardlim(t2);

disp("t2 (dot product): " + t2);