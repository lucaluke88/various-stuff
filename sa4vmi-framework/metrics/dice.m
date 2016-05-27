function [score]=dice(segIm,grndTruth)

score = 2*nnz(segIm==grndTruth)/(nnz(segIm) + nnz(grndTruth));


end