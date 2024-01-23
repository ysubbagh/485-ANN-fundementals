classdef PerceptronLayer
    properties
        weights
        bias
        numInputs
        numOutputs
        transferFunc
        lastInput
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
            n = this.weights * input + this.bias;
            output = arrayfun(@this.doFunc, n);
        end

        %---training functions---%
        %This method takes in a single argument: a vector of errors. 
        % It checks that the length of that vector matches the number of neurons, 
        % outputting an informative error message if that is not the case. 
        % Assuming the length matches, it updates the layer's weights and biases based on the error input.
        function backward(this, eVec)
            % Check if the length of the errors vector matches the number of neurons
            if length(eVec) ~= this.numOutputs
                error('Length of the errors vector must match the number of neurons.');
            end

            % Calculate weight updates
            deltaWeights = eVec' * [this.doFunc(this.weights * this.lastInput + this.bias) * this.lastInput];

            % Update weights and bias
            this.weights = this.weights + deltaWeights;
            this.bias = this.bias + eVec;
        end
    
        %print out the layer's weights and biases (to the console)
        function print(this)
            %print weights
            disp("Weights: ");
            for i = 1:this.weights

            end
            %print biases
            disp("Bias: ");
            for i = 1:this.bias

            end
        end

    end
end

%---helper functions outside of class---%
%calculate the erros of neuron given the target value and produced output
function e = errorLoss(a, t)
    e = t - a;
end


