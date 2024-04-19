# SBZ

Sichere Befehlszeile ist eine hochsichere Alternative zur Secure Shell (SSH).
Im Gegensatz zu SSH ist SBZ ein minimalistisches System von nur 5371 Zeilen
Sappeur-Quellcode.
Durch diesen geringen Umfang ist eine Untersuchung auf Fehler leicht möglich.

Die Version 1.0 ist ein Technologie-Demonstrator und soll vor allem das
Prinzip aufzeigen. 

Benutzung: 

## Auf dem RZ-Rechner:
$ ./sbz server VogelweideSchillerGoetheUlmIlmenauKiel


## Auf dem Arbeitsrechner:
$ ./sbz client meinServer.de VogelweideSchillerGoetheUlmIlmenauKiel "ps -ef"

