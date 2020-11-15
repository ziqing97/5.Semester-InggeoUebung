function [Hz, V, S]=messen(port)

check_dis=0;

while check_dis==0
    fprintf(port, '%R1Q,2008:1'); 		% neue Messung ausloesen
    status = fscanf(port);

    h = waitbar(0,'Warten auf die Distanzmessung...');
    steps = 6000;
    for step = 1:steps
        waitbar(step / steps)
    end
    close(h)
    
    fprintf(port, '%R1Q,2108:1'); 	% Messwerte auslesen
    Ergebnis = convertCharsToStrings(fscanf(port));
    Ergeb_cell = split(Ergebnis, ',');
    Hz = str2double(Ergeb_cell{4});
    V = str2double(Ergeb_cell{5});
    S = str2double(Ergeb_cell{6});

    check_dis = 1;
end  

