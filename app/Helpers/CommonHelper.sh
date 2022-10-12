# This file will contains all global function
# ===========================================

ProgramStarter ()
{
  clear;
}

ExitProgram ()
{
	exit;
}

# @param {string} $1
# @param {string} $applications
AppSelectionTemplate ()
{ 
  arr=($applications);
  while true; do
    clear;
    if [ "$1" == "--l" ]; then
      echo -e "Local Application Selection\n";
      echo -e "";
  
      echo -e "\e[3mPlease enter your choice number (1-${#arr[@]})\e[0m\n";
    elif [ "$1" == "--d" ]; then
      echo -e "Distant Application Selection\n";
    fi
    GenereteAppChoices $applications;
    echo -n -e "\nChoose the desired application (:q for cancel) [\033[0;33m:q\033[0m]: "; read app;
    case $app in
      [1-${#arr[@]}]*) echo "Selected application : $(echo $applications | cut -d ' ' -f $app). Please wait"; sleep 12; break;;
      *) echo -e "\n\033[1;31mOperation Canceled. The program will stop...\033[0m\n"; sleep 1; ExitProgram; break;;
    esac
  done
}

# @param {string} $applications
GenereteAppChoices ()
{
  i=0;
	for app in $applications; do
		i=$(($i + 1))
		echo "$i. $app"
	done	
}