%Test_Tachymeter_TCRP1201

clc
close all
clear all
format short g
delete(instrfind)

%% Schnittstelle RS232 fuer Datenfluss zw. Geraet und PC definieren und oeffnen
%-------------------------------------------------------------------------------
seriPort=serial('COM1','Baudrate',9600,'DataBits',8,'StopBits',1,'Parity','none','Terminator','CR/LF');
fopen(seriPort)

check='n';

roh=200/pi;

while check=='n'
    
fprintf('Uebung 6 "Tachymeter-Programmierung in Matlab:"\n0. Typ des Geraetes\n1. Lagewechsel\n2. Messen\n3. Automatische Satzmessung\n4. Programm beenden \n');
x=input('\nBitte Mess-Modus waehlen: ');
fprintf('\n');

if x==0
    TypInst=verbinden(seriPort);
    fprintf(strcat('\n* * *Die Verbindung zwischen Geraet und PC ist erfolgreich. Der Typ des Geraetes ist  ',TypInst,'.* * *\n'))
elseif x==1
    Lage=lagenwechsel(seriPort);
    fprintf(Lage)
elseif x==2
    [Hz,V,s]=messen(seriPort);
    fprintf('\nMessergebnisse sind:')
    fprintf(strcat('\n Hz: ',num2str(Hz*roh),'gon'))
    fprintf(strcat('\n V : ',num2str(V*roh),'gon'))
    fprintf(strcat('\n S : ',num2str(s),'m\n'))
elseif x==3
    ziel=input('\nBitte Anzahl der Ziele eingeben: ');
    satz=input('\nBitte Anzahl der Saetze eingeben: ');
    [data,dvnum,dhznum]=auto(seriPort,ziel,satz);
elseif x==4
    fprintf('\nProgramm ausgefuehrt.\n')
    return
end


fprintf('\n')
check=input('\nProgramm beenden? (j/n)\n','s');
fprintf('\n')

end

% fclose(seriPort);
