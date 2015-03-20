function varianza_intraclasse = getVarianzaGlobaleIntraClasse(locs,FISA)
    
    varianza_intraclasse = 0;
    k = 1;
    for k=1:size(locs,1) - 1
        
        % misuro la varianza del gruppo dal segnaposto K a K+1 e l'aggiungo
        % alla stima generale
        try
            varianza_intraclasse = varianza_intraclasse + var(FISA(locs(k):locs(k+1)));
        catch e
            disp (e.getMessage());
        end
        
    end
    
end
