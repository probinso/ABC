# Introduction

This talk is an introductary workshop to collaborating in git. The `speaker` branch provides administration tools to run manage this talk for a large audience. This may be overkill on the order of less than 10, but should scale with little overhead to a large audience.

The current paired slides are located [here](https://github.com/probinso/introduction-git).

### Dependencies

**This has been successfully tested in a linux system, unsuccessful on darwin/macosx**

This material depends on Github api, so would cost effort to support other hosts. It also requires that you have a Github `organization` setup that you are administrator for. (These programs are availible in most unix package managers, including `homebrew`)

- bash
- git
- jq
- curl
- sed
- shuf

# Goal

The students are atomatically enrolled onto teams, and assigned `issues` that contain a comic pannel, with an emphasised letter. The student's goal is to commit the text from their `issues` to `README.md`, ordered by their assigned letter. Participants will be assigned multiple letters.

# Setup - For Lead Speaker

In order to administrate this workshop, you will need to have `ssh-keys` setup for permissions on `github`.

**Note that `\*.json` is included in `.gitigore`, so password contents files shouldn't be added to ledger**

```
$ git clone git@github.com:probinso/ABC.git
$ cd ABC
$ git checkout speaker
$ cp creds.json credentials.json
$ chmod 600 credentials.json
```

Now add your github username and password to the `credentials.json` file. Also your `organization` must already exist, on `Github`, and you must be an admin.

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

**TEAM NAMES WILL NAME REPOSITORIES THAT DON'T YET EXIST, COULD BE DANGEROUS FOR EXISTING REPOSITORIES**

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

When you are done with the workshop, delete the repositories.
Know that this process creates an access token with delete permissions.

```bash
$ ./destroy-repos.sh credentials.json teams.txt
```

# Setup - For admins/TAs

When you clone the repository, please use the `git@github.com:...` address in order to insure the use of your `ssh-keys`. If you are an admin/TA, but not running the talk, you can initialize without creating repositories with

```bash
$ ./initialize-ssh.sh credentials.json teams.txt # make sure this is the same as lead speaker
```

If you have a singular master list of users, then you can break it up with

```bash
$ split -l 10 all_user_names.txt # should rename output files to team names
```

For each team, listed in `teams.txt` you should have a cooresponding `<team-name>.txt` that names the members assigned to that team.
To populate a team.

```bash
$ ./populate-team.sh credentials.json teams.txt
```

All your participants should now accept the invites. This is nessicary for issue assignment.

Once accepted, you can assign issues with

```bash
$ ./assign-issues.sh credentials.json teams.txt 3 # count of issues per person
```

To monitor progress of team `green`...

```bash
$ git fetch --all
Fetching origin
Fetching green

$ git diff master green/master
diff --git a/README.md b/README.md
index da5093e..36c3ee7 100644
--- a/README.md
+++ b/README.md
@@ -2,3 +2,6 @@

 An Apparition of her lover She recognizes with dismay;
 and later on she will discover that he himself had died today.
+
+The Yegg on rubber soles comes creeping Inside the house when it is late,
+And while the occupants are sleeping, Removes the heirlooms and the plate.
```
