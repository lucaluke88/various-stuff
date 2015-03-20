function [classified_input] = classificatore( input )
    % questa parte è opzionale ! mi serve solo per velocizzare il tutto in
    % caso non voglia dare l'input io
    if nargin == 0
        input = crea_sample_image(30);
    end
    [reduced_input, fis, fisa, locs] = spectral_analysis(input);
    % costruzione del classificatore
    classificatoreSVM = build_svm_classifier(reduced_input, fis, fisa, locs);
    % riduzione ulteriore della dimensionalità dei dati
    reduced_input = pp_by_KL_distance(reduced_input,classificatoreSVM);
    classified_input = svmclassify(reduced_input,classificatoreSVM);
end
