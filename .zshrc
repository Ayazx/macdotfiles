export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin:$PATH"
export CC=clang
export CXX=clang++
export CXXFLAGS="-stdlib=libc++"
export LDFLAGS="-L/Library/Developer/CommandLineTools/usr/lib -lc++"
export CPPFLAGS="-I/Library/Developer/CommandLineTools/usr/include"

# Set the Dir where zinit is stored
 ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

 #Downlaod zinit if its not already there
 if [ ! -d "$ZINIT_HOME" ]; then
     mkdir -p "$(dirname $ZINIT_HOME)"
     git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
 fi

 #source zinit
 source "${ZINIT_HOME}/zinit.zsh"

 #Add in zsh plugins
 if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
 eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
 fi

 zinit light zsh-users/zsh-syntax-highlighting
 zinit light zsh-users/zsh-completions
 eval "$(fzf --zsh)"
 eval "$(zoxide init --cmd cd zsh)"
 eval "$(/usr/local/bin/brew shellenv)"
 zinit light Aloxaf/fzf-tab
 zinit snippet OMZP::git
 zinit snippet OMZP::sudo
 zinit snippet OMZP::archlinux
 zinit snippet OMZP::aws
 zinit snippet OMZP::kubectl
 zinit snippet OMZP::kubectx
 zinit snippet OMZP::command-not-found
 # zinit snippet OMZP::
 #keybinds & config for autocomp
 bindkey -e
 bindkey '^p' history-search-backward
 bindkey '^n' history-search-forward

 HISTSIZE=5000
 HISTFILE=~/.zsh_history
 SAVEHIST=$HISTSIZE
 HISTDUP=erase
 setopt appendhistory
 setopt sharehistory
 setopt hist_ignore_space
 setopt hist_ignore_all_dups
 setopt hist_save_no_dups
 setopt hist_ignore_dups
 setopt hist_find_no_dups
 zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
 zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
 zstyle ':completion:*' menu no
 zstyle ':fzf-tab:complete:cd*' fzf-preview 'ls --color $realpath'
   
 alias ls='ls --color'
 alias nvim='nvim'
 alias c='clear'
 alias e='exit'
 alias pip='pip3'

 zinit light zsh-users/zsh-autosuggestions

# auto load completions
autoload -U compinit && compinit

zinit cdreplay -q
export PATH="$HOME/.local/bin:$PATH"


