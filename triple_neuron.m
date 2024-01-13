function f = triple_neuron(p, w, b) 
    ps = size(p);
    pw = size(w);
    assert(all(ps == pw)); %error handling
    p = transpose(p);
    n = 0;
    %loop
    for i = 1:length(p);
        n = n + (p(i) * w(i));;
    end
    f = hardlim(n + b); 
end