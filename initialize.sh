for color in $(cat ./teams.txt);
do
    git remote add ${color} git@github.com:PortlandDataScienceGroup/${color}.git
done;
