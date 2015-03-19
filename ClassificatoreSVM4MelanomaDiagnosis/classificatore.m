function [reduced_input] = classificatore( input )
    
    % questa parte è opzionale ! mi serve solo per velocizzare il tutto in
    % caso non voglia dare l'input io
    if nargin == 0
        input = crea_sample_image(30);
    end
    reduced_input = spectral_analysis(input);
end
