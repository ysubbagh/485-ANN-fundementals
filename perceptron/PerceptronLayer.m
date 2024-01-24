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
        function this = PerceptronLayer(p1, p2, p3)
            if(nargin ~= 3)
                error("Invalid number of arguments.")
            elseif(isscalar(p1) && isscalar(p2))
                %set the input and output to the scalers
                this.numInputs = p1;
                this.numOutputs = p2;
                %pre-allocate matrix and vector
                this.weights = rand(this.numOutputs, this.numInputs) * 2 - 1;
                this.bias = rand(this.numOutputs, 1) * 2 - 1;
            elseif((ismatrix(p1) && isvector(p2)) || (ismatrix(p2) && isvector(p1)))
                if(ismatrix(p1)) %matrix is in param 1
                    this.weights = p1;
                    this.bias = p2;
                else %matric is in param2
                    this.weights = p2;
                    this.bias = p1;
                end
                %setup scalers
                this.numInputs = size(this.weights, 2);
                this.numOutputs = size(this.weights, 1);
            else
                error("Invalid arguments.")
            end
            if(isstring(p3))
                this.transferFunc = p3;
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
        function this = backward(this, eVec)
            % Check if the length of the errors vector matches the number of neurons
            if size(eVec, 2) ~= this.numOutputs
                error('Length of the errors vector must match the number of neurons.');
            end

            % Update weights and bias
            this.weights = this.weights + eVec' * this.lastInput;
            this.bias = this.bias + eVec;
        end
    
        %print out the layer's weights and biases (to the console)
        function print(this)
            %print weights
            disp("Weights: ");
            disp(this.weights);
            %print biases
            disp("Bias: ");
            disp(this.bias);
        end

        %modify the weights and biases using a supervised training rule
        function train(this, inputs, target)
           %setup error vector
           eVec = ones(size(target));


           %train until error is 0 for all
           count = 1;
           while any(eVec ~= 0)
                %get output values
                output = this.forwardOps(inputs.').';
                this.lastInput = output(count, :);

                %get error
                eVec = PerceptronLayer.errorLoss(output, target);
                disp("eVec:");
                disp(eVec);

                %modify values
                this.backward(eVec);

                %mod counter
                count = count + 1;
                if count > size(output, 1)
                    count = 1;
                end
           end
            
        end

    end

    %outside of PerceptronLayer class
    methods (Static)
        %calculate the erros of neuron given the target value and produced output
        function e = errorLoss(a, t)
            e = t - a;
        end

    end
end





