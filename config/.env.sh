# This script will configure .env needed variables	   
	
configuration () {

	clear;

	echo -e "\n[\e[0;32m Configure your .env file \e[0m]\n"

	# SET DIST SERVER IP ADDRESS
    echo -e "  Database name [\e[0;33mnull\e[0m]";
    printf '> ';
    read DIST_SERVER_IP;
        
	# SET DIST SERVER USER
    echo -e "\n  Username [\e[0;33mnull\e[0m]";
    printf '> ';
    read DIST_SERVER_USER;

	echo -e "";

	ENV="DIST_SERVER_IP DIST_SERVER_USER";

    # SED .ENV FILE
    for VAR in ${ENV}; do
        sed "s/$VAR=/&${!VAR}/" -i .env;
    done

}

configuration;