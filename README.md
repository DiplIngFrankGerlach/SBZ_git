<img src="https://upload.wikimedia.org/wikipedia/commons/b/ba/Flag_of_Germany.svg" width="150" height="100">
Sichere Informatik aus Deutschland


# SBZ

Sichere Befehlszeile ist eine hochsichere Alternative zur Secure Shell (SSH).
Im Gegensatz zu SSH ist SBZ ein minimalistisches System von nur 5662 Zeilen
Sappeur-Quellcode. OpenSSH ist dagegen 143636 Zeilen C-Quellcode. Wesentlich
geringere Größe bedeutet auch wesentlich weniger Angriffsfläche für 
kybernetische Angreifer.

Durch diesen geringen Umfang von SBZ ist eine Untersuchung auf Fehler leicht möglich.

Die Version 1.1 ist ein Technologie-Demonstrator und soll vor allem das
Prinzip aufzeigen. 

Benutzung: 

Folgende Schlüsseldatei muß auf Server und Client installiert sein(server, port und Schlüssel unbedingt ändern)
```
$ cat ~/.sbz/Schluessel.csv
di-fg.de:8111,WasserfallEisenachVogelweideMartellBarbarossaRommel
localhost:8111,WasserfallEisenachVogelweideMartellBarbarossaRommel
8111,WasserfallEisenachVogelweideMartellBarbarossaRommel
```

## Auf dem Rechenzentrums-Rechner
```
$ ./sbz server 8111
```

## Auf dem Arbeitsrechner:
```
$ ./sbz client meinServer.de:8111  "ps -ef"
```


## Quelle
SBZ wurde von Dipl. Ing. Frank Gerlach (http://di-fg.de) in Brackenheim, Württmberg, Deutschland entwickelt.

## Nutzungsbedingungen

1.) SBZ darf für nichtkommerzielle Zwecke kostenlos eingesetzt werden.

2.) Kommerzielle Nutzung erfordert einen schriftlichen Lizenzvertrag mit Frank Gerlach.

3.) Der Nutzer verpflichtet sich, keine Schadenersatzansprüche wegen
    Programmierfehlern innerhalb von SBZ zu stellen. Es handelt sich
    bisher um einen Protoyp.




