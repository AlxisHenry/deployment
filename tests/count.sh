art="art1 art2 art3 art4 art5 art6 art7 art8 art9 art10";
arr=($art);
echo "Length de l'array : ${#arr[@]}";

number=${1};

case ${number} in
	0) echo "0"; break;;
	$(($number <= ${#arr[@]}))) echo "$number <= ${#arr[@]}" break;;
esac

