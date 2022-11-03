#!/bin/bash

#- Import environment variables
#- ============================
source $(dirname "$0")/.env;

#- Import Utils Functions
#- ===========================
source $(dirname "$0")/app/utils.sh;

#- Import Tools Functions
#- ===========================
source $(dirname "$0")/app/tools.sh;

#- Import Helpers
#- ============================
for Helper in $HELPERS; do source $Helper; done

# Start the program
# -----------------
# @return {app}
app () {
  ProgramStarter;
}

app;
