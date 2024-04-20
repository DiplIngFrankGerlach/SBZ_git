# SBZ

Sichere Befehlszeile ist eine hochsichere Alternative zur Secure Shell (SSH).
Im Gegensatz zu SSH ist SBZ ein minimalistisches System von nur 5662 Zeilen
Sappeur-Quellcode. OpenSSH ist dagegen 143636 Zeilen C-Quellcode.

Durch diesen geringen Umfang von SBZ ist eine Untersuchung auf Fehler leicht möglich.

Die Version 1.1 ist ein Technologie-Demonstrator und soll vor allem das
Prinzip aufzeigen. 

Benutzung: 

$ cat ~/.sbz/Schluessel.csv

di-fg.de:8111,WasserfallEisenachVogelweideKaltWunnensteinZugspitze
localhost:8111,WasserfallEisenachVogelweideKaltWunnensteinZugspitze
8111,WasserfallEisenachVogelweideKaltWunnensteinZugspitze

## Auf dem RZ-Rechner:
$ ./sbz server 8111


## Auf dem Arbeitsrechner:
$ ./sbz client meinServer.de:8111  "ps -ef"

