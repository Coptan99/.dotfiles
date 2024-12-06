# .dotfiles

> A backup for all the configs I use on my linux

## Setup

Use the `sysinit` script instead to install the packages and setup the dotfiles
for a fresh [Artix Linux](https://artixlinux.org/) install:
```sh
./sysinit
```

## Post Install

### pam_ssh

add the following to /etc/pam.d/login
```pamconf
...
-auth        optional    pam_ssh.so    try_first_pass
...
-session     optional    pam_ssh.so
```
[Homepage](https://pam-ssh.sourceforge.net/)
[ArchWiki](https://wiki.archlinux.org/title/SSH_keys#pam_ssh)
