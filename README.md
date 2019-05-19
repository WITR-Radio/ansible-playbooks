# Ansible Playbooks

This repository contains WITR’s Ansible playbooks, which we use for managing the
configurations of all of our machines.  I know it’s impossible to avoid, but
please try not to make *ad hoc* configuration changes.

## What’s In Here?

### Roles

* `base`: Install common packages and set up default config files, login
banners, etc.
* `auth`: Set up our SSH keys and authentication against RIT’s LDAP servers
* `new-old-website-web`: Our old website design, running on new infrastructure
(the nginx part)
* `new-old-website-db`: Our old website design, running on new infrastructure
(the database part)
* `new-new-website-web`: Our new website design (the nginx part)
* `new-new-website-db`: A symlink to `new-old-website-db`
* `streaming`: Icecast and Darkice setup
* `monitoring`: Zabbix setup
* `backup-server`: Bacula server (storage daemon, controller) configuration
* `backup-client`: Bacula client (file daemon) configuration
* `rivendell-db`: The database for Rivendell.  It gets it’s own, so it can go
abuse tables off in it’s own corner, rather than in the way of the website.
* `rivendell-music`: NFS share for our music
* `production-share`: CIFS share for Studio C production data
* `wiki`: Our internal wiki

## How Do I Use These?

1. Log in to `witr-shepherd.rit.edu`
1. `cd /etc/ansible`
1. `git checkout master`
1. `git pull`
1. `ansible-playbook playbooks/$PLAYBOOK.yml`

## No, Like, How Do I Configure A New Host?

1. Create the `_ansible` group
1. Create the `_ansible` user (login class should be `daemon`, home directory in
`/usr/local/ansible`)
1. Add our Ansible SSH key to the `authorized_keys` file in `_ansible`’s home
folder
    ```
    (ssh public key here)
    ```
1. Add `_ansible` to `wheel` so that it can `sudo(1)` (or `doas(1)`)
1. Ensure that the `sudo(1)` (or `doas(1)`) configuration permits `wheel` to act
as root
