# Support-CLI-Starter
## NOTE: This is still in beta.  This README most particularly.
______________________________________________


# Main Steps:

## (1) Install Brew (macOS package manager)
Go here: https://brew.sh/
they'll probably tell you to do this:  
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`  
, but you should go there and see what they say.


## (2a) Install Terminal Emulator
1. `brew tap wez/wezterm`  
2. `brew install --cask wez/wezterm/wezterm` 

## (2b) Install ZSH Enhancements. 
`starship zsh-autosuggestions zsh-syntax-highlighting`

## (2c) Install Better Terminal Commands (basic set)  
1. `brew install bat git-delta exa fd fzf ripgrep tealdeer zoxide eth-p/software/bat-extras-batman`   
2. `$(brew --prefix)/opt/fzf/install` |> you will be prompted to make some choices: respond '**y**' to all. :)  
<img width="658" alt="fzf options install" src="https://user-images.githubusercontent.com/33399972/189989221-5aecdf06-7f74-44ff-ac6d-bfeed57ad4d5.png">



NOTE: there are some follow-up instructions in many of those, I *think* we have you set, but some testing is due.  As is a quick *healthcheck* script to make sure things are in smooth.

## (2d) Install fonts
1. `brew tap homebrew/cask-fonts`
2. `brew install --cask font-iosevka font-iosevka-slab font-syne-mono font-victor-mono font-major-mono-display font-anonymous-pro`

## (3) Set-Up DotFiles
1. Clone repo into specific folder: `git clone git@github.com:ethanmsl/CLI-Starter.git ~/.config`
2. Remove any `.zsh*` files from your `~` directory.  Check there are none: `ls ~/.zsh*`
3. Symlink the zsh file that will say to look in that folder: `ln -s ~/.config/zsh/.zshenv ~/.zshenv`

___________________________

# Optional: 
## Install Neovim (there's a basic IDE-ready set-up almost ready to go if you want)
`brew install neovim`

## Install Node
`brew install node`

## Install Rust 
Go here for install instructions: https://www.rust-lang.org/tools/Install  
They will probably be this: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

________________________________

- Brief Overview
	- Colors
	- Speed
	- File finding
	- Instruction finding
	- Optional Extensibility
- How-To Add:
	- Cloning Repo
		- git clone ...
		- symlinking
	- Brew Installs
		- wezterm
		- starship
		- fonts
		- improved commands
- How-To Use:
	- Commands
		- ls <-> exa
			- ls
			- ll
			- lt
		- cd <~> c
		- cat <-> bat
			- batman
			- XXX --help | bat
		- grep <~x~> rg
		- fzf <~> !!!
		- HELP
			- man
				- man xxx-yyy
			- tldr XXX
				- tldr xxx yyy
			- XXX --help
	- Wezterm
		- fonts
		- themes
		- transparency / background
		- tabs
	- Starship (Command-Line)
		- basic functionality
		- customizing
	- ZSH
		- aliases! (.zshRC)
		- paths! (.zshENV)
		- slightly more complicated stuff! (somewhere!)
		- I love emacs / don't like your crazy vi mode
	- Brew
		- brew info
		- brew update
		- brew upgrade
		- brew uninstall
- Character-Building:
	- vi option in terminal
	- Global Git Config & Delta
- Request for documented extension:
	- "WTG: What the Git?!" or "Git for Singles"
	- "In-CLI Editing" or " Picking up Neo Hobbies"
		- neovim-basic-ide
		- chris@machine tutorial
		- vim in a month
		- Alt: helix
	- Commands further out there!
		- grex
		- bottom
		- sd
		- ripsecrets
_________________________



## .config-dotfiles
(.)dotfiles - localized to .config - requires symlinking .zshenv in order to add paths to some files in it

Will expand this later, but for now it is notable that this localization of (.)dotfiles depends on two things.
1) exporting paths from `.zshenv` to point to many of the files that would otherwise be elsewhere (likely right in $HOME)
2) symlinking `.zshenv` itself into $HOME so that it can both be found and git versioned.  
  The command for that is: `ln -s ~/.config/zsh/.zshenv ~/.zshenv`
