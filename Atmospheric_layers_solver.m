clear all

global S sigma c1 c2 as tl al el em eu
%set parameter values for physical constants
S = 1367; %insolation, in W/m^2
sigma = 5.67e-8; %Stefan-Boltzmann constant, W/m^2-K^4
%set variable parameters
c1 = 8.0; %convection coefficient, in W/m^2-K
c2 = 4.0; %convection coefficient, in W/m^2-K for three atmospheric layer model
as = 0.13; %surface albedo for visible SWR
tl = 0.54; %atmospheric transmission for visible light
al = 0.23; %atmospheric albedo for visible light
el = 0.9; %emissivity of lower atmospheric layer
em = 0.80; %emissivity of middle atmospheric layer
eu = 0.1; %emissivity of upper atmospheric layer
%set counter for number of atmospheric layers (1,2 or 3)
num_layer = 2;

if num_layer == 1
    x0 = [300  255 ];  % Make a starting guess at the solution
    options = optimoptions('fsolve','Display','iter'); % Option to display output
    [x,fval] = fsolve(@atm_lyrs_one,x0,options); % Call solver
    T_surface = x(1)
    T_atmosphere = x(2)
    %One atmospheric layer
    TOA = el*sigma*x(2)^4+(1-el)*sigma*x(1)^4
    Down_flux = el*sigma*x(2)^4
    Convection = c1*(x(2)-x(1))
    
elseif num_layer == 2
    x0 = [300  255 220];  % Make a starting guess at the solution
    options = optimoptions('fsolve','Display','iter'); % Option to display output
    [x,fval] = fsolve(@atm_lyrs_two,x0,options) % Call solver
    %Two atmospheric layers
    TOA = eu*sigma*x(3)^4+ (1-eu)*el*sigma*x(2)^4 + (1-el)*(1-eu)*sigma*x(1)^4
    Down_flux = el*sigma*x(2)^4 + (1-el)*eu*sigma*x(3)^4
    Convection = c1*(x(2)-x(1))
    Direct_IR_trans = (1-el)*(1-eu)

elseif num_layer == 3
    x0 = [300 270 255 220];  % Make a starting guess at the solution
    options = optimoptions('fsolve','Display','iter'); % Option to display output
    [x,fval] = fsolve(@atm_lyrs_three,x0,options) % Call solver
    %Three atmospheric layers
    TOA = eu*sigma*x(4)^4 + (1-eu)*em*sigma*x(3)^4 + (1-em)*(1-eu)*el*sigma*x(2)^4 + (1-el)*(1-em)*(1-eu)*sigma*x(1)^4
    Down_flux = el*sigma*x(2)^4 + (1-el)*em*sigma*x(3)^4 + (1-el)*(1-em)*eu*sigma*x(4)^4
    Convection = c1*(x(2)-x(1))
    Direct_IR_trans = ((1-el)*(1-eu)*(1-em)*sigma*x(1)^4+(1-eu)*(1-em)*el*sigma*x(2)^4)/(sigma*x(1)^4+el*sigma*x(2)^4)

else 'error'
end
