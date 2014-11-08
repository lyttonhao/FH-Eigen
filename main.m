%implement "Hallucinating Face by Eigentransformation
%by Li Yanghao

%clear all;clc;
addpath('Utilities');

%parameters
par.nFactor = 3;
par.psf =   fspecial('gauss', 7, 1.6);              % The simulated PSF
par.train_path = 'Data\Face_Training2\';
par.train_type = '*.jpg';
par.test_path = 'Data\Face_Testing2\';
par.test_type = '*.jpg';
par.alpha = 0.1;   %parameter in second condition

[El, Eh, mY, mX, Y, X, Vl, Dh] = Get_PCA_Train( par );

SR_by_PCA( par, El, Eh, mY, mX, X, Vl, Dh );
