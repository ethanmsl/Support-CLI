





# Support-CLI - Part_1: Titles are Hard
Assumption: you either: 
- (**a**) *have* to drop text in a terminal to do something 
*OR* 
- (**b**) *want* to learn command line tools.  

In either case what you'll see is something that approximates off-peak 70s tech.  
And, it's kinda painful.  

We're going to help, *some*.  

*One* reason 'the terminal' is *difficult* is also why it's *popular*:  (in spirit) ***it's all hotkeys, all the time***.  It trades the curated, slow drip of information a gui gives for access to nearly everything that can be done at once.  It trades familiarity and deciperhability for speed and freedom.  Whether that enhances or diminishes your sense of *flow* depends on your use case.

*Another* reason 'the terminal' is *difficult* is that the defaults that ship with computers are little changed from the 70s.  That we *can* help with.

- A sea of monospaced ascii characters is displayed in a single color.  The unparseable field an artist would cast to deflect a viewer's attention..
	- We'll Add color and simple icons.
- File navigation is tied to rote memorization that predates modern search norms.  
	- We'll add fuzzy-finders and quick-jump functionality.
- Many of the default commands are unecessarilly slow on modern architectures (e.g. for searching through files).
	- New analogues have been written that are many times faster and can use modern computer features.
- And the vintage shell language(s), while *now* valued only for terseness and efficiency, spring from a time when they had to balance other needs.  The synatx of more complex commands is often clunky and awkward.
	- New analogues with streamlined syntax exist.  Understanding that for *very* complicated actions a modern scripting language should be used instead of shell commands.

### Color:
- Starship comparison image
- exa comparison image
- man pages (bat) comparison image

### Navigation:
- standard (tab) behavior gif
- fzf behavior gif
- zoxide behavior gif

### Searching:
- matrix image of time for grep, find, sed vs rg, fd, sd 

### Syntax:
- matrix of comparison for syntax for grep, find, sed, awk, vs rg, fd, sd, choose

### Assitance:
- command coloring comparison image
- auto-completion comparison image
- man pages vs tldr
- navi vs ... google

(Note: this repo does *not* include the enahnced [tab completions](link) feature of ZSH.  The end effect is nice, but the implementation is especially arbitrary/opaque.  And adding them would essentially tack on maintenance cost to any user that wanted to change or enhance their set-up -- demanding that they add new tab completions along with any changes they make or accept inconsistent tab behavior.  That said, they are fully compatible with everything this repo adds.)



# Support-CLI - Part_2: What You Need

You don't need a lot.  But three *soft* needs are: 
1) have git and a github account (so you can clone this repo)
2) have a recent mac OS (intel processors should use the "`intel`" branch of this repo, otherwise use "`main`").  
3) know how to view "hidden" files on your computer.

There are workarounds for all of the above, but they won't be addressed here.

# Support-CLI - Part_3: Prepping for Install

We already mentioned that you need a github account, but in case you skipped down here: [get a github account](https://docs.github.com/en/get-started/signing-up-for-github/signing-up-for-a-new-github-account).
Next, we're going to use the unofficial package manager for Mac: [Brew](https://brew.sh/).
If you don't already have it installed, just follow the instructions at that link.  (They should involve entering a single command, which will download and install Brew. )

Now before going further, check:
1) That git is installed:
```zsh
git --version
```
2) That brew is installed:
```zsh
brew --version
```  
3) That you have a github account and are set-up to use it:
```zsh
cd ~/Desktop
git clone git@github.com:ethanmsl/CloneMeToCheckThatYouCan.git
```
(That last check will do a test clone to an itty-bitty repo -- if it succeeded there should be a folder called `CloneMeToCheckThatYouCan` on your desktop now, with a single text file congratulating you.  You can just delete that folder after.  \[All the git machinery associatted with it lives hidden in the folder you cloned, so there's nothing else to clean up.\])

If any of those checks gave you guff then something isn't set-up.  
Check with a friend, coworker, or the interwebs.  
Once you're good on all three of the above you can productively proceed!  

# Support-CLI - Part_4: Downloads!

We're going to download everything *except* this repo.  (Just get it all ready.)
To do that we're just going to give brew a long list of the names of what we want.  Brew will download them and download anything each one of them needs.  
Easy peasy.

### Install our new Terminal (Emulator).
(They're called "emulators" because actual "terminals" refer to the physical objects people used a half century ago.)  

We're going to install a terminal called "[Wezterm](https://wezfurlong.org/wezterm/)".  It's fast, configurable, and has great support for many things (font icon extensions, font ligatures, using mac option key effectively, image protocols, large color range ... post-70's stuff). [And other stuff we won't discuss here](https://wezfurlong.org/wezterm/features.html).

```zsh
brew tap wez/wezterm
brew install --cask wez/wezterm/wezterm
```

### Install Terminal and Shell Enhancements.

Bunch of stuff.  Easy-peasy.  Might take a second to download it all.  Be prepared for lots of scrolling text.  (Don't worry about it, but you can always uninstall and reinstall if you ever want to watch closely.)
``` zsh
brew install starship zsh-autosuggestions zsh-syntax-highlighting bat choose-rust git-delta exa fd fzf navi ripgrep sd tealdeer zoxide eth-p/software/bat-extras-batman
```

## Optional: Install Fonts

Terminals are all text almost all the time.  Having some choice in fonts is nice.  We're going to download some here so their there if you want later.  You can skip this step and everything else will work fine.
NOTE: if we were using almost any terminal except Wezterm we would have to download special patched fonts with icons in them.  Wezterm provides those.  If you switch terminal emulators sometime just know that you might need special fonts.

```zsh
brew tap homebrew/cask-fonts
brew install --cask font-anonymous-pro font-hack font-iosevka font-iosevka-slab font-major-mono-display font-syne-mono font-victor-mono
```

You can also add [other fonts of your choice later](https://www.programmingfonts.org/).  Just note that almost all terminals assume fixed width fonts.  So make sure the font you're using is compatible with a terminal.  (Generall anything labelled a "programming", "terminal", or "monospace" font will work. :)

# Support-CLI - Part_5: Cloning & Symlinking

Okay, here's the skinny.  A lot of your configuration files are just strewn about the place by default.  Frankly, it's annoying.  And makes keeping track of (and version controlling) them hard.  What we're going to do is put all the config files we care about in a folder called `.config` and then tell the computer where we put them so everyone's happy.

There's three steps.

**Step 1**: freeze any files that would compete with us and put them neatly in a folder as backups.
(should you desire to revert the actions done today!)
```zsh
cd ~
mkdir z-backup-and-froze
mv .zshrc zbackup/
mv .zshenv zbackup/
mv .zprofile zbackup/
mv .zlogin zbackup/
mv .zlogout zbackup/
```
(NOTE: you'll likely get multiple `No such file or directory` responses.  That's fine, it's unlikely you'd have all of those files.  As long you issued the above commands in your home directory `cd ~` you're all set.)

**Step 2:** check if you have a .config file already for some reason and whether any folders with the same name as ours exist.
```zsh
cd ~
ls -a .config
```

Ideally, you'll get `ls: .config: No such file or directory` as a response.  Alternatively, you'll get a list of contents of some pre-existing folder.  As long as none of those names match the names of what's in our folder `.gitignore .git wezterm starship zsh README.md` then you'll be fine.  Otherwise, talk to a friend before proceeding.

**Step 3:** clone our repo into your home folder
```zsh
cd ~
git clone -b main git@github.com:ethanmsl/Support-CLI.git
```
(NOTE: that's the command for downloading the `main` branch of this repo.  If you want something else, e.g. the `intel` branch, but for some reason are reading the instructions to the main branch, you'll want to switch out the  "main" for "\<someothername\>".)

**Step 4**: tell the computer where everything is
```zsh
ln -s ~/.config/zsh/.zshenv ~/.zshenv
```
So in the files you downloaded is a file that will tell the shell (the program the terminal runs) where everything is (in the .config folder, and elsewhere).  Of course, the computer can't know that without reading the file.  Catch-22.  So we're creating a "symlink" that makes that file accessible from it's classic location.  So the computer will find it, then read it, then find all the rest of our stuff. :)




# Support-CLI - Part_6: Touch Ups
Way to go!
That was pretty much everything.  
Two small commands and you can play away.

1) `tldr` is an awesome way to get a quick reminder of commands, but it needs to download it's files from the internet, so just run:
```zsh
tldr --update
```

2) `fzf` is a really useful tool with some complicated shell integration options.  Now that all our files are in place we're going to leverage them.  Run the following command and say `Y` when it asks you if you want the three picture doptions:
```zsh
$(brew --prefix)/opt/fzf/install
```
<img width="658" alt="fzf options install" src="https://user-images.githubusercontent.com/33399972/189989221-5aecdf06-7f74-44ff-ac6d-bfeed57ad4d5.png">


--------------------------
___________________________

# Primary CLI Learning Reference:
- [Software Carpentry: The Unix Shell](https://swcarpentry.github.io/shell-novice/)
(covers BASH, but applies to ZSH)

## Helpful Resources:
- [ExplainShell](https://explainshell.com/): feed it a command and get it broken down! Useful for basic command arguments and context.  (won't parse more involved syntax of arguments to things like `sed`)
- [TLDR Pages](https://tldr.ostera.io/) - we install (below) a CLI tool to do this (e.g. type `tldr mkdir`), but if you don't have that these pages are great!
- [SC: Unix Summary](https://swcarpentry.github.io/shell-novice/reference): just a overview of the Software Carpentry lessons above.  Good for a quick reminder peak.
______________________________________________

