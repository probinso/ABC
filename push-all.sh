for color in $(cat ./teams.txt);
do
    git push -u ${color} master
done;
