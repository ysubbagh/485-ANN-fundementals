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
        function cons = PerceptronLayer(p1, p2, p3)
            if(nargin ~= 3)
                error("Invalid number of arguments.")
            elseif(isscalar(p1) && isscalar(p2))
                %set the input and output to the scalers
                cons.numInputs = p1;
                cons.numOutputs = p2;
                %pre-allocate matrix and vector
                cons.weights = rand(cons.numOutputs, cons.numInputs) * 2 - 1;
                cons.bias = rand(cons.numOutputs, 1) * 2 - 1;
            elseif((ismatrix(p1) && isvector(p2)) || (ismatrix(p2) && isvector(p1)))
                if(ismatrix(p1)) %matrix is in param 1
                    cons.weights = p1;
                    cons.bias = p2;
                else %matric is in param2
                    cons.weights = p2;
                    cons.bias = p1;
                end
                %setup scalers
                cons.numInputs = size(cons.weights, 2);
                cons.numOutputs = size(cons.weights, 1);
            else
                error("Invalid arguments.")
            end
            if(isstring(p3))
                cons.transferFunc = p3;
            else
                error("Invalid transfer function argument");
            end
        end
        
        %---transfer functions---%
        %transfer function FACTORY
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
        function f = hardlim(this, n)
            if(n < 0)
                f = 0;
            else %if n >= 0
                f = 1;
            end
        end

        %hardlimS
        function f = hardlims(this, n)
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


