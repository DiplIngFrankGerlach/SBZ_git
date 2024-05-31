#!/bin/bash

###################################################################################################################
###################################################################################################################
###################################################################################################################
#
# Skript zum Ausfuehren eines Sappeur Compilerlaufs und zur Erzeugung aller nötigen *.h und *.cpp Dateien
#
###################################################################################################################
###################################################################################################################
###################################################################################################################



###################################################################################################################
# Setze das Sappeur Verzeichnis
###############################
export SPR_VERZ=~/Sappeur4x/ausg/haupt


source "grundlegend.sh"

killCoordinator

###################################################################################################################
# Beende den Sappeur Coordinator und starte neu
###############################################

${SPR_VERZ}/compiler/SPRCoordinator &



###################################################################################################################
# Erzeuge die generischen Klassen
###############################################
erzeugeGenerischeKlassen

###################################################################################################################
# Rufe den Sappeur Compiler 
###########################

#parallele Kompilierung abgeschaltet:
#compileAllImpls `ls *ai`
#exit 1


compile AppMain.ai

compile System.ai

compile Strings.ai 

compile ZKNuetzlich.ai 

compile CSVLeser.ai 

compile BMP_Erzeuger.ai 

compile Cookie.ai 

compile FunktionalRechner.ai 

compile Hashtables.ai 

compile Math.ai 

compile Scanner.ai 

compile TCP.ai 

compile URLDecoder.ai 

compile URLPruefer.ai 

compile UnitTestHashtable.ai 

compile UnitTest_hrq.ai 

compile ZeitUndDatum.ai 

compile http_request_parser.ai 

compile shttpd.ai 



###################################################################################################################
# erzeuge die Stack Memory Bestimmung
#####################################
erzeugeStackMemoryBestimmung



###################################################################################################################
# baue die sizeof-Defines zu einer einzigen Header-Datei um
###########################################################
erzeugeSizeofHeader

###################################################################################################################
# Beende den Sappeur Coordinator 
################################
killCoordinator
