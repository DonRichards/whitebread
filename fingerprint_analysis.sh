#!/bin/bash
# In case of a failue.

# These need to be ported to a config file.
COLLECTION_NAME="acwiley"
COLLECTION_URL_SUBDIRECTORY="/collections"

# Looks at the whitebread config for variables.
parse_yaml() {
  local prefix=$2
  local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
  sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
    -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
  awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
  }'
}

if [[ -f config.yml ]] ; then
  eval $(parse_yaml config.yml "config_")
  config_islandora_path="$( echo "$config_islandora_path" | sed -e 's#^http://##; s#/score/$##' | sed "s/\/.*//"  )"
else
  config_destination_directory="output"
fi

clear
CHECK_MARK="\033[0;32m\xE2\x9C\x94\033[0m"
cat << "EOF"
                                  ╓╓╗╦╦╣╣╣╣╣╣╣╣╣╣╣╣╣╣╦╗╥╓
                            ╓╦╣╣╣╣╝╜╙╙╙└└          └└╙╙╙╝╣╣╣╣╗╥
                         ╣╣╣╝╜╙─  ╓╓╗╦╦╣╣╣╣╣╣╣╣╣╣╣╣╦╦╗╥╓   └╙╙╝╣╣╦╥
                            ╓╦╣╣╣╣╝╜╙╙╙└ ─       └└╙╙╙╙╝╣╣╣╣╗╥   ╙╝╣╣╗╖
                       ╓╦╣╣╣╝╙╙─  ╓╓╦╦╣╣╣╣╣╣╣╣╣╣╣╣╣╣╦╗╥╓   ╙╙╝╣╣╦╗  ╙╙╣╝
                   ╓╦╣╣╣╜╙   ╓╦╣╣╣╝╜╙╙└─           └╙╙╙╝╣╣╣╦╥  └╙╝╣╣╗╥
                 ╦╣╣╝╙   ╦╣╣╣╩╙└       ╓╓╥╥╥╥╥╥╥╥╓        └╙╝╣╣╣╗  └╙╣╣╦╥
                 ╙└  ╓╦╣╣╝╙    ╓╥╦╣╣╣╣╣╝╨╜╙╙╙╙╙╜╨╝╣╣╣╣╣╦╥╓     ╙╝╣╣╗╥ └╙╣╣╗
                  ╓╣╣╣╜└   ╓╦╣╣╝╜╙└      ╓╓╓╓╓╓╓╓     └╙╙╣╣╣╦╥    └╙╣╣╗╖ ╙╙─
               ╓╦╣╣╝   ╓╣╣╣╝╙     ╓╦╣╣╣╣╣╝╝╜╜╜╨╝╝╣╣╣╣╣╗╥    ╙╝╣╣╗╥   └╙╣╣╗
             ╓╣╣╝└  ╔╣╣╝╙    ╓╦╣╣╣╝╙╙─              └╙╙╝╣╣╦╥   └╙╣╣╦╥   ╙╫╣╣╥
              ╙  ╓╣╣╝╙    ╓╣╣╣╝╙     ╓╦╦╣╣╣╣╣╣╣╣╣╣╣╦╗╥   └╙╝╣╣╗    ╙╣╣╗   └╚╣╣╥
              ╓╦╣╣╜    ╓╣╣╣╜    ╓╦╣╣╣╩╙╙╙─        └╙╙╝╣╣╣╗   ╙╚╣╣╗   ╙╝╣╣╥   ╙╣╝
            ╓╣╣╝└   ╓╦╣╣╜─  ╓╦╣╣╝╙└      ╓╓╥╗╗╗╗╥╥╓     ╙╚╣╣╦╥  ╙╝╣╣╥   ╙╣╣╗
          ╔╣╣╜    ╔╣╣╝└  ╓╣╣╣╜└    ╓╦╣╣╣╣╝╜╜╙╙╙╙╙╨╝╣╣╣╣╗╥  └╙╣╣╗   ╙╣╣╗   ╙╣╣╗
         ╙╝╜    ╦╣╣╙   ╦╣╣╝    ╓╣╣╣╩╙└  ╓╓╥╗╗╗╗╥╥╓    ╙╙╝╣╣╗  ╙╫╣╣╥  ╙╫╣╦╖  ╙╣╣╗
             ╓╣╣╝└  ╓╣╣╩╙   ╦╣╣╝╙  ╓╦╣╣╣╝╜╙╙╙╙╙╙╨╝╣╣╣╗╥   ╙╚╣╣╗  ╙╣╣╗   ╚╣╣╖  ╙╣╣╗
           ╓╣╣╝─  ╓╣╣╝─  ╓╣╣╩╙  ╦╣╣╝╙└     ╓╓╓╓╓    ╙╙╣╣╣╥   ╙╣╣╗  ╙╣╣╗  └╚╣╣   ╙╣╣
         ╓╣╣╝   ╔╣╣╝   ╔╣╣╝  ╔╣╣╝╙   ╓╦╣╣╣╝╝╨╨╝╝╣╣╣╣╗   ╙╣╣╦╖  └╫╣╦  ╙╣╣╥  └╫╣╗   └
        ╣╣╝─  ╔╣╣╜   ╦╣╣╜  ╦╣╣╜  ╓╦╣╣╩╙└ ╓╦╗╥╥     ╙╚╣╣╗   ╚╣╣╥  └╣╣╗  ╚╣╣╖  ╙╣╣╥
       ╚╩└  ╔╣╣╜   ╦╣╣╙  ╦╣╣╙  ╔╣╣╝└      ╙╙╙╨╣╣╣╣╗╥  └╚╣╣╥  ╚╣╣   ╙╣╣╗ └╫╣╗   ╟╣╗
          ╔╣╣╜   ╦╣╣╙  ╣╣╝╙  ╦╣╣╙  ╓╦╣╣╣╣╣╣╦╗    ╙╙╣╣╣╥  ╙╣╣╥ └╫╣╗   ╚╣╣  ╙╣╣╗  ╙╣╣
        ╓╣╣╝   ╦╣╣╙  ╣╣╩└  ╣╣╝╙ ╓╣╣╝╜└    └╙╝╣╣╗╣╣╗  ╙╣╣╗  ╚╣╣  ╙╣╣╥  └╣╣╗  ╚╣╗   ╝╝
      ╓╣╣╝   ╦╣╣╙  ╣╣╩└ ╓╣╣╝└ ╔╣╣╝  ╓╦╣╣╣╣╦╗  ╙╣╣╣╚╣╣╥ ╙╣╣╗ └╣╣╗  ╟╣╗   ╚╣╣  ╙╣╣╥
     ╣╣╝   ╦╣╣╙  ╣╣╩└ ╓╣╣╝└ ╓╣╣╝  ╦╣╣╜╙ ─└╙╝╣╣╖ ╫╣╗ ╚╣╣  ╙╣╣╗ ╚╣╣  ╙╣╣╥  ╙╣╣╗  ╫╣╗
         ╦╣╣╙  ╦╣╣╙  ╣╣╝└ ╓╣╣╝  ╣╣╝└╓╦╣╣╣╣╦╥└╫╣╗ ╚╣╬ └╫╣╗  ╟╣╗ ╙╣╣╗  ╟╣╗   ╟╣╗  ╚╣╣
       ╔╣╣╙  ╦╣╣╙  ╣╣╩└  ╣╣╝─ ╣╣╩└╔╣╣╝└   ╙╣╣╥╟╣╗ ╟╣╗  ╙╣╣╥ ╙╣╣  ╚╣╣  ╙╣╣╗  ╙╣╣  ╙╣╣
     ╔╣╣╜  ╔╣╣╜  ╦╣╣╙  ╣╣╝─ ╦╣╣╙╓╣╣╝╓╦╦╣╣╦╥ ╣╣╗╫╣╗ ╣╣    ╫╣╗  ╣╣╗ ╙╣╣╗  ╚╣╣  └╣╣╗
    ╫╣╝  ╓╣╣╝  ╔╣╣╜  ╦╣╣╙ ╔╣╣╙╓╣╣╝╔╣╣╝╙ └╚╣╣╘╣╣ ╣╣ ╚╣╣    ╙╣╣  ╣╣╗  ╙╣╣╥ └╣╣╗  ╫╣╗
       ╓╣╣╝  ╓╣╣╝  ╔╣╣╜ ╔╣╣╜╓╣╣╝╓╣╣╝  ╔╣╣ ╣╣─╣╣ ╟╣╗ ╣╣ └╣╣ ╙╣╣╖ ╚╣╣   ╟╣╗  ╙╣╣╖ ╚╣╣
      ╣╣╝─ ╓╣╣╝  ╓╣╣╝ ╓╣╣╝ ╣╣╝┌╣╣╝   ╣╣╝  ╣╣─╣╣─╘╣╣ ╫╣─ ╟╣╗  ╣╣╗ ╙╣╣╗  ╙╣╣╗  ╫╣╗  └
     ╙╝╙  ╦╣╬─ ╓╣╣╝  ╣╣╝ ╦╣╣╙╔╣╣╙  ╓╣╣╝   ╣╣ ╣╣─ ╣╣ ╟╣╗  ╣╣   ╟╣╗  ╚╣╣   ╙╣╣╗ ╙╣╣╥
        ╔╣╣╜  ╣╣╝─ ╔╣╣╙╔╣╣╙╓╣╣╝   ╔╣╣    ╟╣╣ ╣╣  ╣╣ ╟╣╣  ╣╣    ╙╣╣  ╙╣╣╗   ╙╣╣╖ ╫╣╕
       ╣╣╝  ╦╣╣└ ╓╣╣╝╔╣╣╜ ╫╣╩    ╣╣╝    ╒╣╣ ╫╣╝ ├╣╣ ╟╣╣  ╣╣  ╣╣╖└╣╣╗  ╙╣╣╗   ╚╣╣
      ╙╝─ ╔╣╣╙ ╓╣╣╝╓╣╣╝ ╔╣╣╙    ╣╣╝    ╓╣╣ ╔╣╣  ╣╣─ ╣╣─ ╟╣╣   ╫╣╗ ╙╣╣╗  ╙╣╣╗  └╣╣╗
        ╓╣╣╝ ╓╣╣╝╓╣╣╝ ╔╣╣╜   ╦╣╣╙     ╣╣╝ ╣╣╝  ╣╣╝ ╔╣╣  ╣╣ ╣╣─ ╙╣╣╥ ╙╣╣╗  ╙╣╣╗  ╙╙
       ╣╣╝ ╓╣╣╝╓╣╣╝ ╔╣╣╜ ╓╦╣╣╝╙    ╓╣╣╝╙╔╣╣╜ ╓╣╣╝ ╔╣╬  ╣╣╝╔╣╣    ╚╣╣  ╙╣╣╗  ╙╣╣╗╓
         ╔╣╣╝┌╣╣╩└└╣╣╙╓╣╣╣╝└   ╓╦╣╣╣╜╓╦╣╣╜ ╓╣╣╝─ ╫╣╝  ╣╣╝╓╣╣ ╦╦╥   ╫╣╦  ╙╝╣╣╗ └╚╣╝
       ╔╣╣╜ ╦╣╣╙   ╓╓╓╥╫╦╦╦╣╣╣╣╝╜╙╓╦╣╣╩╙ ╔╣╣╝└ ╦╣╣╜ ╔╣╣╙╔╣╣   ╙╣╣╦╥ └╚╣╣╥  ╙╣╣╦╥
        ╙   ╙╙  ╝╝╝╝╝╨╜╙╙╙╙└ ╓╥╦╣╣╣╝╙╓╦╣╣╝╙ ╓╣╣╝╙ ╓╣╣╝ ╫╣╝ ╒╣╣   ╙╣╣╗╓ ╙╣╣╗  └╙╣╣═
        ╓╓╓╓╓╓╥╥╥╥╥╗╦╦╦╣╣╣╣╣╣╝╜╙╓╓╦╣╣╣╜╙╓╦╣╣╝╙  ╔╣╣╝ ╓╣╣╝ ╓╣╣─╓╥   └╚╣╣╗ ╙╚╣╣╗╥
        ╙╝╝╨╨╜╜╜╙╙╙╙╙╙╙╓╓╓╥╗╦╣╣╣╣╩╙╙╓╦╣╣╝╜└  ╦╣╣╝╙ ╓╣╣╝  ╫╣╝  ╙╣╣╣╥   ╙╝╣╣╗ └╙╣╣─
             ╣╣╣╣╣╣╣╣╣╣╝╝╝╜╙╙╓╓╓╦╣╣╣╝╜╙  ╓╣╣╣╝╙  ╦╣╣╝  ╔╣╣╜      ╙╣╣╣╗   ╙╣╣╣╥
          ╓╓╓╓╥╥╥╥╗╗╗╦╦╦╣╣╣╣╣╣╝╜╙╙  ╓╦╣╣╣╝╙─  ╦╣╣╝╙ ╓╦╣╣╙ ╣╣╣╗      ╙╝╣╣╗   ╙╝╝
         └╜╜╜╜╜╜╙╙╙╙╙╙╙╙└└    ╓╗╦╣╣╣╝╜╙   ╓╣╣╣╝╙ ╓╦╣╣╝└     ╙╣╣╣╗      ╙╝╣╣╗
           ╓╥╥╥╓╓╓╥╥╥╗╦╦╦╣╣╣╣╣╝╜╙└  ╓╥╦╣╣╣╩╙  ╥╣╣╣╝╙  ╣╣╗      ╙╝╣╣╗      └
           ╙╙╨╨╨╨╨╜╜╙╙╙╙╙└   ╓╥╦╦╣╣╣╣╜╙╙╓╓╦╣╣╣╝╙─      ╙╝╣╣╗      ╙╝╣╣╗
              ╓╓╓╥╥╗╦╦╣╣╣╣╣╣╣╝╜╙╙└╓╓╦╦╣╣╣╝╙╙╔╦╗╥╓         ╙╝╣╣╗      ╙╙╙
              ╝╝╜╜╙╙╙╙╙ ┌╓╓╓╗╦╣╣╣╣╝╩╙╙┌      ╙╙╙╝╝╣╣╣╣╦╗╓    ╙╚╣╣╗╓
                ╓╗╦╦╣╣╣╣╣╣╝╜╣╟╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╦╗╥╓└╙╙╝╣╣╦╥   └╙╣╝
                └╙╙╙└─╓╓╦╣╣╣╝╜╙╙╓╓╓╗╦╦╦╦╦╦╦╦╗╥╥╓└╙╙╝╣╣╣╦╥ └╙╝╣╣╗
                    ╣╣╣╝╙╙ ╓╦╣╣╣╣╝╜╙╙╙╙╙╙╙╙╙╙╙╨╝╣╣╣╦╗╓ ╙╝╣╣╦╥ ╙╜─
                        ╓╦╣╣╝╙─   ╓╥╗╦╦╦╦╦╗╗╥╓    └╙╙╣╣╣╗ └╙╝╜
                        ╙╜└  ╓╦╣╣╣╝╜╙╙╙╙╙╙╙╙╨╝╣╣╣╦╗╓   ╙╣╣╗
                            ╙╝╙└                └╙╙╣╣╣╗

  This uses 3 techniques for identifying duplicates.
    * Parce the Foxml file for the hash values to identify duplicates.
    * Download all of the images and hash them to identify duplicates.
    * Download all of the images and fingerprint the image to identify duplicates.

FOXML
* Get PIDS list
* Use whitebread to get the Foxml files
* Download and hash every OBJ for a collection
* export foxml hash values
* sort both the foxml & brute force hashes
* identify duplicate hashes in both lists
* output duplicates into 2 PID lists

Requires:
- https://github.com/realpython/image-fingerprinting
- pipenv

Setup:
- 'pip install pillow==2.6.1 imagehash==0.3 glob2`
- pipenv shell
- ./fingerprint_analysis.sh


+-----------------------------------------+------------------------------------------------------------------+
|             Leftover Files              |                                                                  |
+-----------------------------------------+------------------------------------------------------------------+
| PIDS.txt                                | PIDS of a Solr query.                                            |
| shasum_file.log                         | Medium size images raw hash value.                               |
| shasum_clean.log                        | Cleaned up copy of shasum_file.log file.                         |
| FOXML_hashes.txt                        | Hash values found in FOXML files for the OBJ.0                   |
| shasum_clean_duplicates.txt             | Duplicated Hashes found in the FOXML files.                      |
| duplicates_found_by_brute_force.log     | PIDs of duplicate Hash values generated by the downloaded files. |
| FOXML_hashes_duplicates.txt             | Duplicated Hashes found in the FOXML files.                      |
| duplicates_found_by_foxml.log           | PIDs of duplicate Hash values fond in the FOXML files.           |
| missing_obj.log                         | PID is for a book/newspaper/compound/collection                  |
| output/*.xml                            | FOXML files                                                      |
| output/*.jpg                            | Medium size images downloaded from the collection.               |
| duplicates_found_by_finger_printing.log | Raw duplicate list.                                              |
| results_pids_to_remove.txt              | Newest PIDs be number of duplicates excluding the original PID.  |
| results.txt                             | Formatted list of PIDs that were duplicates paired together.     |
+-----------------------------------------+------------------------------------------------------------------+


EOF
echo -e "\e[91m\e[7m‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo -e "______________________________________ Not suitable for text collections _____________________________________"
echo -e "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\e[27m\e[0m\n\n\n"

echo -e "Looking at collection \"\e[96m$(curl "https://${config_islandora_path}${COLLECTION_URL_SUBDIRECTORY}/islandora/object/collections:${COLLECTION_NAME}" -so - | grep -iPo '(?<=<title>)(.*)(?=</title>)')\e[0m\" \n\t\e[93mhttps://${config_islandora_path}${COLLECTION_URL_SUBDIRECTORY}/islandora/object/collections:${COLLECTION_NAME}\e[0m \n"
echo -e "FOXML & Images will be save to \e[96m$(pwd)/${config_destination_directory}/\e[0m \n\n"

echo -e "\n\n\n\e[93m+---------------- House cleaning -----------------------------------------------------------------------------+\e[0m\n"
# In case anything this script was interuption this kills any service locking the directory.
[[ -d fingerprint_analysis_tmp ]] || lsof +D "./fingerprint_analysis_tmp/" | awk '{print $2}' | tail -n +2 | xargs kill -9
[[ -d $config_destination_directory ]] || lsof +D "./${config_destination_directory}" | awk '{print $2}' | tail -n +2 | xargs kill -9

rm -rf fingerprint_analysis_tmp
rm -rf db.shelve
rm -rf $config_destination_directory/*.xml
rm -rf $config_destination_directory/*.jpeg
rm -rf $config_destination_directory/*.jpg
mkdir -p fingerprint_analysis_tmp
touch fingerprint_analysis_tmp/duplicates_found_by_finger_printing.log

echo -e "\\r\t\t ${CHECK_MARK}\e[32m complete.\e[0m\n\n"
mkdir -p $config_destination_directory/

function validate_url(){
  if [[ `wget -S --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
    return 0
  else
    return 1
  fi
}

echo -e "\n\n\n\e[93m+---------------- Curl from Solr the PIDS and export to a file.-----------------------------------------------+\e[0m\n"
curl "http://${config_islandora_path}:8080/solr/collection1/select?q=PID%3A${COLLECTION_NAME}%5C%3A*&sort=PID+asc&rows=100000&fl=PID&df=RELS_EXT_hasModel_uri_ms%253Ainfo%255C%253Afedora%252Fislandora%255C%253ApageCModel&wt=csv" > fingerprint_analysis_tmp/PIDS.txt

PIDS=($(< fingerprint_analysis_tmp/PIDS.txt))
echo -e "\\r \n \e[93m${#PIDS[@]}\e[0m pids found.\n\n\t\t ${CHECK_MARK} \e[32mCreate a PID list is complete.\e[0m\n\n"

if [[ -f run.py ]] ; then
  echo -e "\n\n\n\e[93m+---------------- Running whitebread to download foxml files to '$config_destination_directory'. -------------------------------------+\e[0m\n"
  # Grab the Foxml files for this collection
  pipenv run python run.py -o grab_foxml -p "${COLLECTION_NAME}"
  echo -e "\\r\b\b\t\t\t ${CHECK_MARK} \e[32mFoxml download complete.\e[0m\n"
fi

if [[ -f run.py ]] ; then
  # This downloads and hashes each PID's OBJ and outputs the hash to a file.
  # If there is no OBJ it outputs the PID to file to help identify possibly parent objects.
  echo -e "\n\n\n\e[93m+---------------- Download each image and outputing the hash to a file. --------------------------------------+\e[0m\n"
  pipenv run python run.py -o grab_other -p "${COLLECTION_NAME}" -ds JPG
  echo -e "\\r\n\t\t ${CHECK_MARK} \e[32mImage download complete.\e[0m\n"
fi

# use this if whitebread isn't installed. This will download and hash each image.
if [[ ! -f config.yml ]] ; then
  COUNTER=0
  for pid in "${PIDS[@]}"; do
    clear
    echo -e "\n\e[45m_____________________________________________________________________________ $((100-(((${#PIDS[@]}-$COUNTER)*100)/${#PIDS[@]}))) % _____________________________________________________________________________\e[0m"
    let COUNTER=COUNTER+1
    if [[ ! $pid == 'PID' ]]; then
      echo -e "https://${config_islandora_path}${COLLECTION_URL_SUBDIRECTORY}/islandora/object/${pid}/datastream/JPG/download \n"
      if `validate_url "https://${config_islandora_path}${COLLECTION_URL_SUBDIRECTORY}/islandora/object/${pid}/datastream/JPG/download"`; then
        wget --no-check-certificate --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 100 "https://${config_islandora_path}${COLLECTION_URL_SUBDIRECTORY}/islandora/object/${pid}/datastream/JPG/download" -O "$config_destination_directory/${pid//:/_}.jpg"
        echo "$(sha1sum $config_destination_directory/${pid}.jpg)" >> fingerprint_analysis_tmp/shasum_file.log
        echo -e "\t\e[32m$config_destination_directory/${pid} removed\e[0m\n"
      else
        echo -e "\e[31mPID is for a book/newspaper/compound/collection\e[0m\n\n\n"
        echo "$pid" 2>&1 >> fingerprint_analysis_tmp/missing_obj.log
      fi
    fi
  done
fi

if [[ -f fingerprint_analysis_tmp/shasum_file.log ]]; then
  echo -e "\n\n\n\e[93m+---------------- Sorting shasums. ---------------------------------------------------------------------------+\e[0m\n"
  sed 's/ .*//' fingerprint_analysis_tmp/shasum_file.log > fingerprint_analysis_tmp/shasum_clean.log
  # Sort the hashes
  sort -o fingerprint_analysis_tmp/shasum_clean.log fingerprint_analysis_tmp/shasum_clean.log
  echo -e "${CHECK_MARK}\e[32m complete.\e[0m\n"
fi

echo -e "\n\n\n\e[93m+---------------- Iterates over the output folder of foxml files to look at the hashes. ----------------------+\e[0m\n"
grep -nr -A1 '<foxml:datastreamVersion ID="OBJ.0"' output | grep "DIGEST" | sed -e 's,.*=,,' | sed 's/^"\(.*\)".*/\1/' > fingerprint_analysis_tmp/FOXML_hashes.txt
# sort the FOXML hashes
sort -o fingerprint_analysis_tmp/FOXML_hashes.txt fingerprint_analysis_tmp/FOXML_hashes.txt
echo -e "\\r\t\t ${CHECK_MARK}\e[32m complete.\e[0m\n"


if [[ -f fingerprint_analysis_tmp/shasum_clean.log ]]; then
  echo -e "\n\n\n\e[93m+---------------- Find duplicates from the bruteforce approach -----------------------------------------------+\e[0m\n"
  for dupl in $(cut -d " " -f1 fingerprint_analysis_tmp/shasum_clean.log | uniq -d); do
    grep -n -- "$dupl" fingerprint_analysis_tmp/shasum_clean.log >> fingerprint_analysis_tmp/shasum_clean_duplicates.txt;
  done
  echo -e "\\r\t\t ${CHECK_MARK}\e[32m complete.\e[0m\n"
fi

echo -e "\n\n\n\e[93m+---------------- Find duplicates in the Foxml files. --------------------------------------------------------+\e[0m\n"
if [[ -f fingerprint_analysis_tmp/FOXML_hashes.txt ]]; then
  for dup in $(cut -d " " -f1 fingerprint_analysis_tmp/FOXML_hashes.txt | uniq -d); do
    grep -n -- "$dup" fingerprint_analysis_tmp/FOXML_hashes.txt >> fingerprint_analysis_tmp/FOXML_hashes_duplicates.txt;
  done
fi
echo -e "\\r\t\t ${CHECK_MARK}\e[32m complete.\e[0m\n"

if [[ -f fingerprint_analysis_tmp/shasum_clean_duplicates.txt && -f fingerprint_analysis_tmp/FOXML_hashes_duplicates.txt ]]; then
  echo -e "\n\n\n\e[93m+-----------------------------------------++-----------------------------------------------------------------+\e[0m"
  BRUTES=($(< fingerprint_analysis_tmp/shasum_clean_duplicates.txt))
  FOXES=($(< fingerprint_analysis_tmp/FOXML_hashes_duplicates.txt))

  echo -e "Brute force found ${#BRUTES} duplicates. \n Foxml found ${#FOXES} duplicates."
  echo "outputing both to a file"
  for hash_to_pids_brute in "${BRUTES[@]}"; do
    if grep -r --quiet $(echo "${hash_to_pids_brute}" | cut -d':' -f2-) output ; then
      grep -nr $(echo "${hash_to_pids_brute}" | cut -d':' -f2-) output | grep "DIGEST" | cut -d'-' -f1 | cut -d'.' -f1 | cut -d'/' -f2 >> fingerprint_analysis_tmp/duplicates_found_by_brute_force.log
    else
      echo $( echo "${hash_to_pids_brute} NOT FOUND" | cut -d':' -f2-)
    fi
  done
  sort -o fingerprint_analysis_tmp/duplicates_found_by_brute_force.log fingerprint_analysis_tmp/duplicates_found_by_brute_force.log
  echo -e "\\r\t\t ${CHECK_MARK}\e[32m complete.\e[0m\n"

  echo "Going over the foxml files"
  if [[ -f shasum_file.log ]]; then
    for hash_to_pids_foxes in "${FOXES[@]}"; do
      if grep -r --quiet $(echo "${hash_to_pids_foxes}" | cut -d':' -f2-) fingerprint_analysis_tmp/shasum_file.log ; then
        echo -e $(grep -nr $(echo "${hash_to_pids_foxes}" | cut -d':' -f2-) fingerprint_analysis_tmp/shasum_file.log | grep "DIGEST" | cut -d'-' -f1 | cut -d'.' -f1 | cut -d'/' -f2)
        grep -nr $(echo "${hash_to_pids_foxes}" | cut -d':' -f2-) fingerprint_analysis_tmp/shasum_file.log | grep "DIGEST" | cut -d'-' -f1 | cut -d'.' -f1 | cut -d'/' -f2 >> fingerprint_analysis_tmp/duplicates_found_by_foxml.log
      else
        echo "Didn't find $( echo ${hash_to_pids_foxes} | cut -d':' -f2-)"
      fi
    done
  fi
  echo -e "\\r\t\t ${CHECK_MARK}\e[32m complete.\e[0m\n"

  sort -o fingerprint_analysis_tmp/duplicates_found_by_foxml.log fingerprint_analysis_tmp/duplicates_found_by_foxml.log
  echo -e "\\r\t\t ${CHECK_MARK}\e[32m Foxml loop complete. \e[0m\n\n\n"
fi

echo -e "\n\n\n\e[93m+---------------- Rename images so python app doesn't fail and fix dot extension. ----------------------------+\e[0m\n"
# if file contains `:` rename to `_`.
for i in $config_destination_directory/*.*; do
  if [[ $i == *":"* ]]; then
    mv "$i" "${i//:/_}" 2>/dev/null;
  fi
done

# if `.jpeg` rename to `.jpg`.
for i in $config_destination_directory/*.jpeg; do
  if [[ $i == *".jpeg" ]]; then
    for i in $config_destination_directory/*.jpeg; do mv "$i" "${i//.jpeg/.jpg}" 2>/dev/null; done
  fi
done
echo -e "\\r\t\t ${CHECK_MARK}\e[32m Rename complete. \e[0m\n\n\n"

echo -e "\n\n\n\e[93m+---------------- Remove empty files. ------------------------------------------------------------------------+\e[0m \n"
find $config_destination_directory/ -size 0 -delete
echo -e "\\r\t\t ${CHECK_MARK}\e[32m Empty files removed. \e[0m \n\n\n"

echo -e "\n\n\n\e[93m+---------------- Fingerprinting the entire images directory.-------------------------------------------------+\e[0m \n"
if [[ -f index.py ]]; then
  pipenv run python index.py --dataset "${config_destination_directory}" --shelve db.shelve & pid=$!
  spin='-\|/'
  i=0

  while kill -0 $pid 2>/dev/null
  do
    i=$(( (i+1) %4 ))
    printf "\r${spin:$i:1}"
    sleep .1
  done
fi
echo -e "\b\n\n\n\t\t${CHECK_MARK}\e[32m Fingerprinting directory complete. \e[0m\n\n\n"

echo -e "\n\n\n\e[93m+---------------- Looping through each file for duplicate fingerprints. --------------------------------------+\e[0m\n"
COUNTER=0
IMAGE_COUNT=$(ls -lR $config_destination_directory/*.jpg | wc -l)
for filename in $config_destination_directory/*.jpg; do
  let COUNTER=COUNTER+1
  found_or_not=$(pipenv run python search.py --dataset "${config_destination_directory}" --shelve db.shelve --query "${filename}")
  if [ "${found_or_not}" != 'nothing' ]; then
    echo -ne "\b\b\b\b\b\b\b\b\t\t Found ${found_or_not} for ${filename}\t \t $(($IMAGE_COUNT-$COUNTER)) | $IMAGE_COUNT"\\r
    echo "${found_or_not}" >> fingerprint_analysis_tmp/duplicates_found_by_finger_printing.log
  else
    echo -ne "\\r\t\t Found a match for \e[36m${filename}\e[0m \t \t - \e[96m$(($IMAGE_COUNT-$COUNTER))\e[0m | \e[91m$IMAGE_COUNT\e[0m - \t \e[93m$((${COUNTER}*100/${IMAGE_COUNT}))%\e[0m"
  fi
done
echo -e "\\r\t\t ${CHECK_MARK} \e[32m Fingerprint loop complete. \e[0m\n\n\n"

echo -e "\n\n\n\e[93m+---------------- Sorting and mapping of fingerprints. -------------------------------------------------------+\e[0m\n"
COUNTER=0
SUBCOUNTER=0
grep -v "^Found " fingerprint_analysis_tmp/duplicates_found_by_finger_printing.log > temp && mv temp fingerprint_analysis_tmp/duplicates_found_by_finger_printing_x.log
grep -v -e '^[[:space:]]*$' fingerprint_analysis_tmp/duplicates_found_by_finger_printing_x.log | sort -u | sort -V > temp && mv temp fingerprint_analysis_tmp/duplicates_found_by_finger_printing_x.log

mapfile -t unsorted_pids < fingerprint_analysis_tmp/duplicates_found_by_finger_printing.log
mapfile -t sorted_unique_pids < fingerprint_analysis_tmp/duplicates_found_by_finger_printing_x.log
echo -e "\\r\t\t ${CHECK_MARK}\e[32m Sorting and mapping complete. \e[0m\n\n\n"

echo -e "\n\n\n\e[93m+---------------- Find all duplicated fingerprints and match them to their PID(s). ---------------------------+\e[0m\n"
for (( i = 0; i < "${#unsorted_pids[@]}"; i++ )); do
  for (( j = 0; j < "${#sorted_unique_pids[@]}"; j++ )); do
    if [[ "${unsorted_pids[$i]}" == "${sorted_unique_pids[$j]}" ]]; then
      if [[ "${unsorted_pids[$i-1]}" == "Found"* ]] ; then
        let COUNTER=COUNTER+1
        echo -e "\n${unsorted_pids[$i-1]}" >> fingerprint_analysis_tmp/results.txt
      else
        echo -e "${unsorted_pids[$i]}" >> fingerprint_analysis_tmp/results_pids_to_remove.txt
      fi
      echo "${sorted_unique_pids[$j]}" >> fingerprint_analysis_tmp/results.txt
      sorted_unique_pids[$j]="0"
      let SUBCOUNTER=SUBCOUNTER+1
    fi
  done
  echo -ne " \\r\tChecking and building a list. Currently checking \e[96m$i\e[0m of \e[92m${#unsorted_pids[@]}\e[0m \t \e[93m$((${i}*100/${#unsorted_pids[@]}))%\e[0m complete.   Duplicated Objects:\e[92m$COUNTER\e[0m   Duplicate Objects:\e[92m$SUBCOUNTER\e[0m"
done
echo -e "\\r\b\b\b\b\b\b\b\b\t\t ${CHECK_MARK}\e[32m Fingerprint matching complete. \e[0m\t\t\t\t\t\n\n\n"
sed -i '/^$/d' fingerprint_analysis_tmp/results_pids_to_remove.txt

echo -e "\n\n\n\e[93m+---------------- Final house cleaning. ----------------------------------------------------------------------+\e[0m\n"
rm -f fingerprint_analysis_tmp/duplicates_found_by_finger_printing_x.log
rm -rf $config_destination_directory/*.xml
rm -rf $config_destination_directory/*.jpeg
rm -rf $config_destination_directory/*.jpg
rm -f db.shelve
echo -e "\\r\t\t ${CHECK_MARK}\e[32m Fingerprint matching complete. \e[0m\n\n\n"

echo -e "\e[35m+-----------------------------------------+------------------------------------------------------------------+\e[0m"
echo -e "\n\n\n\t\e[35m ${COUNTER} Objects that were duplicated.\e[0m\n"
echo -e "\t\e[35m $((${SUBCOUNTER}-${COUNTER})) duplicate objects needing to be removed\e[0m\n\n"
echo -e "\e[35m+-----------------------------------------+------------------------------------------------------------------+\e[0m\n\n"
echo -e "\n\n\n\tDuplicated Objects list is saved to \e[34mLightfingerprint_analysis_tmp/results.txt\e[0m"
echo -e "\n\n\tFor a list of only the PIDS to remove use \e[34mLightfingerprint_analysis_tmp/results_pids_to_remove.txt\e[0m\n"


cat << "EOFA"


This skips the lowest numbered PID in each match and outputs the remaining PIDS.

Example:
    Lowest PID is omitted.

+----------------+--------------------+
|      PID       | Omitted / included |
+----------------+--------------------+
| islandora:3268 | X--- omitted       |
| islandora:3271 |  <-- included      |
| islandora:3726 |  <-- included      |
| islandora:3729 |  <-- included      |
+----------------+--------------------+










EOFA
