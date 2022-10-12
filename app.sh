#!/bin/bash

# Import environment variables
# ============================
source .env;

# Import Helpers
# ============================
for Helper in $HELPERS; do source $Helper; done

app () {
  
  ProgramStarter;
  LocalApplications; 
  DistantApplications;

}

app;