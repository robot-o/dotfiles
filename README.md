# robot-o's dotfiles

## DISCLAIMER

As usual, these are *my* dotfiles. They work for me, they *might* work for you.

However, they probably don't work for you without modification *unless* you're running **manjaro/arch linux** and KDE.

Please **always** make sure to read through **everything** because you most likely want to customize and change how some of this works.

## Usage

These dotfiles are bootstrapped using the wonderful tool [dotbot](https://github.com/anishathalye/dotbot). Make sure you [check a look](https://youtu.be/JKgEsuEBhqI?t=164) before continuing further here: [github.com/anishathalye/dotbot](https://github.com/anishathalye/dotbot)

1. To get started, check out the dotbot submodule by running

    ```bash
    git submodule update --init --recursive
    ```

1. Now you can just use the dotbot install script as usual. (this is a short tl;dr but please make sure to check out how [dotbot](https://github.com/anishathalye/dotbot) actually works.)
    - do all the things! (this includes installation of my tools and creation of folders as well as setting up a systemd service [outlined in install.conf.yaml](install.conf.yaml))

       ```bash
       ./install
       ```

    - do everything except running the shell commands that install and boostrap my packages

      ```bash
      ./install --except shell
      ```

    - only symlink the dotfiles

      ```bash
      ./install --only link
      ```

Enjoy <3
