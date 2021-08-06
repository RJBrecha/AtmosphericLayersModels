function F = atm_lyrs(x)
global S sigma c1 as tl al el eu
F = [(S/4/sigma)*(1-as)*tl - x(1)^4 + el*x(2)^4 + (1-el)*eu*x(3)^4  - (c1/sigma)*(x(1)-x(2));
    (S/4/sigma)*((1-tl)*(1+as*tl)-al )+ el*x(1)^4 - 2*el*x(2)^4  + el*eu*x(3)^4   + (c1/sigma)*(x(1)-x(2)) ;
    eu*(1-el)*x(1)^4 + el*eu*x(2)^4 - 2*eu*x(3)^4  ];
