#!/bin/bash

#- Import environment variables
#- ============================
source .env;

#- Import Utils Functions
#- ===========================
source ./app/utils.sh;

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