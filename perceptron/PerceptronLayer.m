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
                %stuff
            elseif((ismatrix(params{1}) && isvector(params{2})) || (ismatrix(params{2}) && isvector(params{1})))
                if(ismatrix(params{1})) %matrix is in param 1
                    %stuff
                else %matric is in param2
                    %stuff
                end
            else
                error("Invalid arguments.")
            end
            cons = params;
        end

        
    end
end