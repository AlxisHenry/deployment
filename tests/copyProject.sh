# Copy the project to the tests folder
mkdir -p ~/bin/project-managing/tests/cciapp 

elements=$(ls -A /var/www/cciapp/ | grep -v -E '(.git|vendor|docs|*.sh|docker-compose.yml|*.md)')
echo $elements;

for el in $elements; do
	cp -r /var/www/cciapp/$el ~/bin/project-managing/tests/cciapp
done