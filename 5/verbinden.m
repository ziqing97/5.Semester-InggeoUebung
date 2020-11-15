function s=verbinden(port)
    fprintf(port, '%R1Q,5004:');    % Befehl senden = Test für die Verbindung !
    antwort=fscanf(port);           % Antwort abholen
    ind=strfind(antwort,'"');       % Zeichen in der Antwort suchen
    s=antwort(ind(1):ind(2));
end