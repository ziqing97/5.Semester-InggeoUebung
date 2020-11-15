function [data,dV,dHZ]=auto(port,ziel,satz)

% P=cell(ziel*satz,1);
% Hz=cell(ziel*satz,2);
% V=cell(ziel*satz,2);
% S=cell(ziel*satz,2);

autostart='n';
roh=200/pi;


kopfzeile={'Punkt','Hz[gon] Lage I','Hz[gon] Lage II','V[gon] Lage I','V[gon] Lage II','S[m] Lage I','S[m] Lage II'};

data = cell(ziel*satz , 7);
data(1, :) = kopfzeile;

Lage=lagenwechsel(port);
fprintf('\n')
fprintf(Lage)
fprintf('\n')
dHZ = zeros(ziel-1,1);
dV = zeros(ziel-1,1);
fprintf(port,'%R1Q,18005:1');
fscanf(port)
while autostart == 'n'
    fprintf('\n Jetzt beginnt die Lernphase des Geraetes. \n')
    for i = 1:ziel
        fprintf(port,'%R1Q,9037:1,1,0'); 	
        ant = fscanf(port);
        [Hz, V, S] = messen(port);
        data{satz*(i-1)+2, 1} = num2str(i);
        data{satz*(i-1)+2, 2} = num2str(Hz);
        data{satz*(i-1)+2, 4} = num2str(V);
        data{satz*(i-1)+2, 6} = num2str(S);  
        answer = input('\n bitte naechste Punkte einziehen und j geben, damit Lernphase weiter gehen kann \n','s');
    end
    fprintf('\n Die Lernphase ist beendet')
    Wiederholung = input('\n Lernphase wiederholen? \n','s');
    if Wiederholung == 'j'
        continue
    else
        for i = 1 : ziel - 1
            dHZ(i) = str2double(data(satz*(i)+2, 2)) - str2double(data(satz*(i-1)+2, 2));
            dV(i) = str2double(data(satz*(i)+2, 4)) - str2double(data(satz*(i-1)+2, 4));
        end
        autostart = 'j';
    end
end
dHZ1 = dHZ;
dV1 =dV;
dHZ2 = -dHZ;
dV2 = -dV;
    fprintf(port,'%R1Q,18005:1');%ATR einschalten
    ATR_status=fscanf(port);
% Erste Satz, Lage II
fprintf(port, '%R1Q,9028:'); 
s2_=fscanf(port); 	
for i = ziel:-1:1
        fprintf(port,'%R1Q,9037:1,1,0'); 	
        ant = fscanf(port);
    [Hz, V, S] = messen(port);
    data{satz*(i-1)+2, 3} = num2str(Hz);
    data{satz*(i-1)+2, 5} = num2str(V);
    data{satz*(i-1)+2, 7} = num2str(S);
    if i~= 1
    k = sprintf('%3.4f,%3.4f',dHZ2(i-1),dV1(i-1));
    kk = strcat('%R1Q,6007:',k);
    fprintf(port,kk);
    status = fscanf(port);
    end
end



for j = 2:satz
    fprintf(port, '%R1Q,9028:'); 			%Befehl senden (Lage wechseln)
    s2_=fscanf(port);
    % Lage I
    for i = 1:ziel
         fprintf(port,'%R1Q,9037:1,1,0'); 	
        ant = fscanf(port);
        [Hz, V, S] = messen(port);
        data{satz*(i-1)+j+1, 1} = num2str(i);
        data{satz*(i-1)+j+1, 2} = num2str(Hz);
        data{satz*(i-1)+j+1, 4} = num2str(V);
        data{satz*(i-1)+j+1, 6} = num2str(S);
        if i ~= ziel
        k = sprintf('%3.4f,%3.4f',dHZ1(i),dV1(i));
        kk = strcat('%R1Q,6007:',k);
        fprintf(port,kk);
        status = fscanf(port);
        end 
    end
    % Lage II
    fprintf(port, '%R1Q,9028:'); 			%Befehl senden (Lage wechseln)
    s2_=fscanf(port);
    for i = ziel:-1:1 
        fprintf(port,'%R1Q,9037:1,1,0'); 	
        ant = fscanf(port);
        [Hz, V, S] = messen(port);
        data{satz*(i-1)+j+1, 3} = num2str(Hz);
        data{satz*(i-1)+j+1, 5} = num2str(V);
        data{satz*(i-1)+j+1, 7} = num2str(S);
        if i~= 1
        k = sprintf('%3.4f,%3.4f',dHZ2(i-1),dV1(i-1));
        kk = strcat('%R1Q,6007:',k);
        fprintf(port,kk);
        status = fscanf(port);
        end 
    end
end
fprintf('Ende der Messung');
end



