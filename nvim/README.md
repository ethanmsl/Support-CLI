# This version of NeoVim was created by Christian Chiarulli
(with one minor modification by me to workaround an issue with M1 macs and treesitter)

There are a few, *small*, things that need to be done to make it fully functional.
However, it's best that you take a look at the links below if you want to use it.  
[Eh, TLDR:  
1. go to plugins.lua and type `:w` to prompt plugin management
2. anywhere, type `:TSUpdate` to start loading TreeSitter parsers
3. LSPs (Language Servers): this is a slightly more involved issue. Python and JS are explained in the linked github (below), others needs to be manually added (but this is quite easy! :)  
and, uh... *tada!*-ish :)  
]


Take a look at the Repo's original README at it's GitHub repo:

## (github) NVim-Basic-IDE
https://github.com/LunarVim/nvim-basic-ide [^1]

[^1]: (note, in case you're familiar with the vim space: this is *NOT* related to "LunarVim"; this is a totally standard set-up that merely shares a creator)

If you're interested in understanding the repo better I also highly recommend their YouTube series, which walks through the creation of a very similar predecessor repo:

## (youtube) Neovim IDE from Scatch: 
https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ
