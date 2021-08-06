function F = atm_lyrs(x)
global S sigma c1 c2 as tl al el em eu
F = [(S/4/sigma)*(1-as)*tl - x(1)^4 + el*x(2)^4 + (1-el)*em*x(3)^4 + (1-em)*(1-el)*eu*x(4)^4 - (c1/sigma)*(x(1)-x(2));
    (S/4/sigma)*((1-tl)*(1+as*tl)-al) + el*x(1)^4 - 2*el*x(2)^4  + el*em*x(3)^4 + el*eu*(1-em)*x(4)^4 - (c2/sigma)*(x(2)-x(3)) + (c1/sigma)*(x(1)-x(2)) ;
    em*(1-el)*x(1)^4 + el*em*x(2)^4 - 2*em*x(3)^4 + eu*em*x(4)^4  + (c2/sigma)*(x(2)-x(3));
    eu*(1-el)*(1-em)*x(1)^4 + el*eu*(1-em)*x(2)^4+em*eu*x(3)^4-2*eu*x(4)^4];
