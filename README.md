# Introduction

This talk is an introductary workshop to collaborating in git. The `speaker` branch provides administration tools to run manage this talk for a large audience. This may be overkill on the order of less than 10, but should scale to nearly 40 people with little overhead.

# Goal

The students are atomatically enrolled onto teams, and assigned `issues` that contain a commic pannel, with an emphasised letter. The student's goal is to commit the text from their `issues` to `README.md`, ordered by their assigned letter. Participants will be assigned multiple letters.

# Setup - Stage One

```
$ git clone https://github.com/PortlandDataScienceGroup/ABC.git
$ cd ABC
$ git checkout speaker
$ cp creds.json credentials.json
```

Now add your github username and password to the `credentials.json` file

```json
{
    "username":"my_neato_username",
    "password":"super_secret_password",
    "organization":"PortlandDataScienceGroup"
}
```

Place the usernames of your admins into `admins.txt`

```text
probinso
kinga-k-farkas
cedarmora
```

Place the team names into `teams.txt`

```text
yellow
orange
pink
purple
blue
```

Initialize your repositories

```bash
$ ./build-repos.sh credentials.json teams.txt admins.txt
```

# Setup - Stage Two

make a list of all user usernames `all_user_names.txt`

---


Once you accept all your team invites :)

```
$ ./fetch-all.sh
```

You will be much happier administrating the talk if you have ssh keys setup

```
$ split -l 10 all_user_names.txt
```
