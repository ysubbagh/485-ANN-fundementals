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
        
        %---transfer functions---%
        %send to correct transfer function
        function func = doFunc(this, n)
            switch this.transferFunc
                case "hardlim"
                    func = this.hardlim(n);
                case "hardlims"
                    func = this.hardlims(n);
                otherwise
                    error("Transfer function not supported.");
            end
        end

        %hardlim
        function f = hardlim(n)
            if(n < 0)
                f = 0;
            else %if n >= 0
                f = 1;
            end
        end

        %hardlimS
        function f = hardlims(n)
            if(n < 0)
                f = -1;
            else %% n >=0
                f = 1;
            end
        end
        
        %---forward functions---%
        %forward with a loop
        function output = forwardLoop(this, input)
            output = zeros(this.numOutputs, 1);
            for i = 1:this.numOutputs
                n = this.weights(i, :) * input + this.bias(i);
                output(i) = this.doFunc(n);
            end
            
        end

        %forward using MATLAB operations
            function output = forwardOps(this, input)
            output = 0; %temp
        end
    end
end


