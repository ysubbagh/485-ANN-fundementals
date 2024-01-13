classdef PerceptronLayer
    properties
        weights
        bias
        numInputs
        numOutputs
        transferFunc
    end
    methods
        %constructor
        function cons = PerceptronLayer(params)
            if(nargin ~= 3)
                error("Invalid number of arguments.")
            elseif(isscalar(params{1}) && isscalar(params{2}))
                %set the input and output to the scalers
                cons.numInputs = params{1};
                cons.numOutputs = params{2};
                %pre-allocate matrix and vector
                cons.weights = rand(cons.numOutputs, cons.numInputs) * 2 - 1;
                cons.bias = rand(cons.numOutputs, 1) * 2 - 1;
            elseif((ismatrix(params{1}) && isvector(params{2})) || (ismatrix(params{2}) && isvector(params{1})))
                if(ismatrix(params{1})) %matrix is in param 1
                    cons.weights = params{1};
                    cons.bias = params{2};
                else %matric is in param2
                    cons.weights = params{2};
                    cons.bias = params{1};
                end
                %setup scalers
                cons.numInputs = size(cons.weights, 2);
                cons.numOutputs = size(cons.weights, 1);
            else
                error("Invalid arguments.")
            end
            if(isstring(params{3}))
                cons.transferFunc = params{3};
            else
                error("Invalid transfer function argument");
            end
        end

        %hardlim
        function f = hardlim(n)
            f = n;
        end

        %hardlims
        function f = hardlims(n)
            f = n;
        end

        %forward with a loop
        function f = forwardLoop(vec)
            f = vec;
        end

        %forward using MATLAB operations
        function f = forwardOps(vec)
            f = vec;
        end
    end
end