clear all
close all
clc

opts = delimitedTextImportOptions("NumVariables", 17);
opts.DataLines = [1, Inf];
opts.Delimiter = "\t";
opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "VarName5", "VarName6", "VarName7", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17"];
opts.SelectedVariableNames = ["VarName5", "VarName6", "VarName7"];
opts.VariableTypes = ["string", "string", "string", "string", "double", "double", "double", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17"], "EmptyFieldRule", "auto");
coordinate = readtable("F:\Studium\5-Ingenieurgeodaesie\Uebung\6\coordinate.txt", opts);
coordinate = table2array(coordinate);
clear opts


plot(coordinate(:,1),coordinate(:,2))
Kreis1 = coordinate(1:4,1:2);
Kreis2 = coordinate(9:12,1:2);

% Schaetzungswert
[xm1_0, ym1_0] = P2Km(Kreis1(1,1),Kreis1(1,2),Kreis1(2,1),Kreis1(2,2),Kreis1(3,1),Kreis1(3,2));
R1_0 = sqrt((Kreis1(1,1) - xm1_0)^2 + (Kreis1(1,2) - ym1_0)^2);
R1_1 = sqrt((Kreis1(2,1) - xm1_0)^2 + (Kreis1(2,2) - ym1_0)^2);