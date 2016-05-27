function [I]=global_thresholding(input)
   input = uint8(255*mat2gray(input)); 
   T = mean2(input); % soglia iniziale
   ok = 0;
   while(ok==0)
       G1 = input(input<T);
       G2 = input(input>=T);
       T1 = mean2(G1);
       T2 = mean2(G2);
       new_T = uint8((T1+T2)/2);
       if(new_T == T) 
           ok = 1; % abbiamo raggiunto la convergenza
       else
           ok = 0;
           T = new_T; % dobbiamo continuare
       end
   end
   
   % ora che trovato un T buono, faccio il threshold
   input(input<T) = 0;
   input(input>=T) = 255;
   I = input;
   
end