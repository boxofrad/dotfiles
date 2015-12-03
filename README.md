# Dotfiles

These are my dotfiles. There are many like them, but these ones are mine.

## New Computer Checklist (OSX Edition)

1. Download Xcode from the Mac App Store.
2. Sob gently into a pillow, and restart the stuck Xcode installation.
3. Accept the Xcode licence: `sudo xcodebuild -license`
4. Clone down this repo: `git clone git@github.com:boxofrad/dotfiles ~/.dotfiles`
5. Install [Homebrew](http://brew.sh) and [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle).
6. Install stuff from the Brewfile: `brew bundle`
7. Run `brew linkapps` to symlink MacVim into the `/Applications` directory.
8. Time to make an SSH key: `ssh-keygen -t rsa -b 4096 -C "daniel+<machine-name>@floppy.co"`
9. Copy it to your clipboard: `pbcopy < ~/.ssh/id_rsa.pub`
10. Add it [to GitHub](https://github.com/settings/ssh).
11. Run the install script: `script/install`
12. Log into the Heroku Toolbelt: `heroku login`
13. Remap caps lock to control (System Preferences → Keyboard → Modifier Keys).
14. Beat yourself up for not making this an Ansible playbook.
