# This file contain all functions about program
# ==================================================

# Start the program
# -----------------
# @return {void}
ProgramStarter ()
{
  #- Delete project from dist folder if exists
  rm -rf $LOCAL_DIST_FOLDER/$(ls dist/ | grep -v -E '(.gitignore|readme.md)');
  Applications --l;
  Applications --r;
}