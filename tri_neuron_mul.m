function f = tri_neuron_mul(p, w, b) 
    ps = size(p);
    pw = size(w);
    assert(all(ps == pw)); %error handling
    f = hardlim(b + (p.' * w));
end