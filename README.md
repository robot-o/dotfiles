# robot-o's dotfiles

## DISCLAIMER

>As usual, these are *my* dotfiles. They work for me, they *might* work for you.
>However, they probably don't work for you without modification *unless* you're running **manjaro/arch linux** and KDE.
>Please **always** make sure to read through **everything** because you most likely want to customize and change how some of this works.

## Usage

These dotfiles are bootstrapped using the amazing, awesome, monumental, fantastic, unbelievable, bodacious tool [ansible](https://docs.ansible.com/), and an ansible playbook. Make sure you have it installed.

The [playbook](playbook.yml) comes equipped with a variety of [tags](https://docs.ansible.com/ansible/latest/user_guide/playbooks_tags.html) so you can do selectively execute certain tasks:

- `update` - runs a full system update including aur packages
- `install` -  installs all packages
  - `essentials` - installs only essential packages
  - `development` -  installs only devtools
  - `media` -  installs only media tools
  - `social` - installs only social/comms tools
- `link` - symlinks dotfiles and system config
  - `dotfiles` - symlinks only user dotfiles into homedir
  - `sysconfig` -  symlinks sys config files (only i3-plasma session atm)

1. To get started, get the git submodules to make sure you have the ansible modules needed.:

    ```bash
    git submodule update --init --recursive
    ```

2. Now you can just run the playbook:
    - do all the things! (this includes installation of my tools and creation of folders as well as setting up various systemd services.

       ```bash
       ansible-playbook playbook.yml
       ```

    - do everything except running the shell commands that install and boostrap my packages

      ```bash
      ansible-playbook playbook.yml --skip-tags install
      ```

    - only symlink the dotfiles

      ```bash
      ansible-playbook playbook.yml -t dotfiles
      ```

    - only update and install

      ```bash
      ansible-playbook playbook.yml -t update,install
      ```

Enjoy <3
