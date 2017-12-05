# Instructions for Speaker Setup

```
$ git clone https://github.com/PortlandDataScienceGroup/ABC.git
$ cd ABC
$ git checkout speaker
$ ./initialize.sh
$ cp creds.json credentials.json
```

Now add your github username and password to the credentials file

Once you accept all your eam invites :)

```
$ ./fetch-all.sh
```

You will be much happier administrating the talk if you have ssh keys setup

```
$ split -l 10 all_user_names.txt
```
