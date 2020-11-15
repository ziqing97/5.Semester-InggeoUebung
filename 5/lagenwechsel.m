function [s] =lagenwechsel(port)

fprintf(port,'%R1Q,2026:');      % Befehl senden
antwort=fscanf(port);            % Antwort abholen
ind=strfind(antwort,','); 		 % Zeichen in der Antwort suchen
l=ind(end)+1;

%Abfrage, ob sich das Geraet in Lage I oder II befindet.
if antwort(l) == '0'		%falls Antwort == '0' -> Lage I
	fprintf('Lage I\n');
else %sonst -> Lage II
	fprintf('Lage II\n');
end


%Abfrage, ob die Lage gewechselt werden soll.
ant=input('Lage wechseln? (j/n)\n','s');
if ant=='j'
	fprintf(port, '%R1Q,9028:'); 			%Befehl senden (Lage wechseln)
    s2_=fscanf(port); 	
    s='\n* * * Die Lage wurde gewechselt. * * *\n';
else
    s='\n* * * weiter * * *\n';
end


