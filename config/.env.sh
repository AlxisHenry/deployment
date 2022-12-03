# This script will configure .env needed variable

function sedPath {
	path=$((echo $1|sed -r 's/([\$\.\*\/\[\\^])/\\\1/g'|sed 's/[]]/\[]]/g')>&1)
}

function configuration () {
    clear;
    echo -e "\n[\e[0;32m Environment variables configuration \e[0m]\n"
    # SET REMOTE SERVER IP ADDRESS
    echo -e "  Remote server ip address [\e[0;33mnull\e[0m]";
    printf '> ';
    read REMOTE_SERVER_IP; 
    # SET REMOTE SERVER USER
    echo -e "\n  Remote server user [\e[0;33mnull\e[0m]";
    printf '> ';
    read REMOTE_SERVER_USER;
    # SET REMOTE PATH TO APPS FOLDER
    echo -e "\n  Path to distant  applications folder [REMOTE] [\e[0;33mnull\e[0m]";
    printf '> ';
    read REMOTE_PATH_TO_ROOT;
    # SET LOCAL PATH TO APPS FOLDER
    echo -e "\n  Path to local applications folder [LOCAL] [\e[0;33mnull\e[0m]";
    printf '> ';
    read PATH_TO_ROOT;
    echo -e "";
    ENV="REMOTE_SERVER_IP REMOTE_SERVER_USER REMOTE_PATH_TO_ROOT PATH_TO_ROOT";
    # SED .ENV FILE
    for v in ${ENV}; do
	val=$(sed "s/)
        #sed "s/${v}=/&${!v}/" -i .env;
    done
}

configuration;
