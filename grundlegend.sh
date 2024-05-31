#!/bin/bash

###################################################################################################################
###################################################################################################################
###################################################################################################################
#
# Bash Funktionen zur Unterstuetzung des Sappeur Uebersetzungslaufs
#
###################################################################################################################
###################################################################################################################
###################################################################################################################

#######################################
# compile a Sappeur implementation file
#######################################
compile()
{
    ${SPR_VERZ}/compiler/SPRcomp $1 -outputPath output -operatingSystem Linux -sappeurDirectory ${SPR_VERZ} 
}

########################################################
# kompiliere eine Sappeur Datei im Hintergrund(parallel)
########################################################
compileBG()
{
    ${SPR_VERZ}/compiler/SPRcomp $1 -outputPath output -operatingSystem Linux -sappeurDirectory ${SPR_VERZ} &
}

######################################################
# warte solange prozesse des angegebenen Namens laufen
######################################################
laeuftProzess()
{
   pname=$1
   while ps -ef | grep -w ${pname}|egrep  $USER | grep -v grep > /dev/null; do
     echo "${pname} laeuft"
   done
}

####################################################################
# kompiliere alle genannten Sappeur implementations-Dateien parallel
####################################################################
compileAllImpls()
{
   for file in $@; do
       if [ -f "$file" ]; then
          echo $file
          compileBG $file 
       else
           echo "File not found: $file"
       fi
   done

   laeuftProzess SPRcomp
}


##################################
# kill the Coordinator, if it runs
##################################
killCoordinator()
{
   OS=$(uname -s)

   if [[ "$OS" == "Linux" ]]; then
      pid=`ps -ef|egrep SPRCoordinator|egrep $USER|egrep -v grep|sed 's/ \+/ /g'|cut -d " " -f2`
      if [[ $pid =~ ^[0-9]+$ ]]; then #if pid valid
         kill $pid
      fi 
   elif [[ "$OS" == "CYGWIN"* ]]; then
      pid=`ps -ef|egrep SPRCoordinator|egrep $USER|egrep -v grep|sed 's/ \+/ /g'|cut -d " " -f3`
      if [[ $pid =~ ^[0-9]+$ ]]; then  #if pid valid
         kill $pid
      fi 
   else
       echo "The operating system is not recognized."
   fi
}

killCoordinator

###################################################################################################################
# Beende den Sappeur Coordinator und starte neu
###############################################

${SPR_VERZ}/compiler/SPRCoordinator &


###################################################################################################################
# Erzeuge die generischen Klassen
###############################################
erzeugeGenerischeKlassen()
{
   echo "Import { \"Strings.ad\", \"ZKNuetzlich.ad\" }" > Strings.ai
   m4 Strings.ai.m4 >> Strings.ai
   m4 String.ad.m4 > Strings.ad

   m4 Hashtable.ad.m4 > Hashtable.ad
   echo "Import { \"Strings.ad\", \"Hashtable.ad\" }" > Hashtables.ai
   m4 Hashtables.ai.m4 >> Hashtables.ai
}

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

erzeugeStackMemoryBestimmung()
{
   # Schritt 1
   egrep SPR_BESTIMME_MAXIMALE_STACK_GROESSE_FUNKTION output/determStackMemory_*cpp |\
          cut -d ":" -f2|cut -d " " -f2|sed "s/$/;/g"|sed "s/^/extern void /g" > output/determineStackMemoryNeeds.cpp

   #Schritt 2
   echo "void determineStackNeeds()" >> output/determineStackMemoryNeeds.cpp
   echo "{" >> output/determineStackMemoryNeeds.cpp
   egrep SPR_BESTIMME_MAXIMALE_STACK_GROESSE_FUNKTION output/determStackMemory_*cpp |\
      cut -d ":" -f2|cut -d " " -f2|sed "s/$/;/g"|sed "s/^/    /g" >> output/determineStackMemoryNeeds.cpp
   echo "}" >> output/determineStackMemoryNeeds.cpp

}


###################################################################################################################
# baue die sizeof-Defines zu einer einzigen Header-Datei um
###########################################################
erzeugeSizeofHeader()
{
   cat output/sizeofDefine*.h > output/sizeofAlle.h
   sort output/sizeofAlle.h |uniq > /tmp/SappeurSizeofTemp_$$
   mv  /tmp/SappeurSizeofTemp_$$ output/sizeofAlle.h
}

###################################################################################################################
# Beende den Sappeur Coordinator 
################################
killCoordinator
