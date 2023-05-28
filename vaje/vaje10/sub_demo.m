function [kontrolne1,kontrolne2] = sub_demo(b,c,risanje)
% Metoda demonstrira en korak subdivizije za Bezierjevo krivuljo. 
% Pri tem je b vektor kontrolnih koeficientov.
% c je subdivizijski parameter 0 <= c <= 1.
    
    [left, middle, right] = deCasteljau(b, c);

    kontrolne1 = [left middle];
    kontrolne2 = [middle right];

    if risanje
        plotBezier(b);
        plotBezier(kontrolne1);
        plotBezier(kontrolne2); 
    end

end