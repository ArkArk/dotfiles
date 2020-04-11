#!/usr/bin/env fish

if test -d $HOME/bin
    set -x PATH $HOME/bin $PATH
end

if test -d $HOME/.local/bin
    set -x PATH $HOME/.local/bin $PATH
end

# pyenv
if test -d $HOME/.pyenv
    set -x PYENV_ROOT $HOME/.pyenv
    set -x PATH $PYENV_ROOT/bin $PATH
    pyenv init - | source
end

# rbenv
if test -d $HOME/.rbenv
    set -x PATH $HOME/.rbenv/bin $PATH
    rbenv init - | source
end

# Rust (Cargo)
if test -d $HOME/.cargo/bin
    set -x PATH $HOME/.cargo/bin $PATH
end

# D
if test -d $HOME/dlang/dmd-2.089.0/linux/bin64
    set -x PATH $HOME/dlang/dmd-2.089.0/linux/bin64 $PATH
end

# Go
if test -d /usr/local/go/bin
    set -x PATH /usr/local/go/bin $PATH
    set -x GOPATH $HOME/.go
    set -x PATH $GOPATH/bin $PATH
end

# npm
if test -d $HOME/.npm-global/bin
    set -x PATH $HOME/.npm-global/bin $PATH
end

# n
#   https://github.com/tj/n
if type n >/dev/null 2>&1
    set -x N_PREFIX $HOME/.n-prefix
    set -x PATH $N_PREFIX/bin $PATH
end

if test -d $HOME/app
    # selenium
    if test -d $HOME/app/selenium
        set -x PATH $HOME/app/selenium $PATH
    end
    # pkcrack
    if test -d $HOME/app/pkcrack-1.2.2/bin
        set -x PATH $HOME/app/pkcrack-1.2.2/bin $PATH
    end
    # pdfpc
    if test -d $HOME/app/pdfpc-4.3.2/build/bin
        set -x PATH $HOME/app/pdfpc-4.3.2/build/bin $PATH
    end
    # flutter
    if test -d $HOME/app/flutter/bin
        set -x PATH $HOME/app/flutter/bin $PATH
    end
    # pdfpc
    #   https://github.com/pdfpc/pdfpc
    if test -d $HOME/app/pdfpc-4.3.2/build/bin
        set -x PATH $HOME/app/pdfpc-4.3.2/build/bin $PATH
        alias pdfpc="pdfpc --disable-auto-grouping" # Disable auto detection of overlays
    end
end

# starship
#   https://github.com/starship/starship
if type starship >/dev/null 2>&1
    starship init fish | source
end

# enhancd
#   https://github.com/b4b4r07/enhancd
if type enhancd >/dev/null 2>&1
    set -x ENHANCD_DISABLE_DOT 1
    set -x ENHANCD_DISABLE_HOME 1
end

# exa
#   https://github.com/ogham/exa
if type exa >/dev/null 2>&1
    alias ls="exa"
    alias ll="exa --long --header --git"
    alias la="exa --long --header --git -a"
    alias l="exa"
    alias lt="exa --tree"
    alias llt="exa --long --header --git --tree"
    alias lat="exa --long --header --git -a --tree"
end

# bat
#   https://github.com/sharkdp/bat
if type bat >/dev/null 2>&1
    alias cat="bat -pp"
end

# mkdir + cd
function mkcd --description "mkdir + cd"
    mkdir $argv && cd $argv[-1]
end

# cd in a git repository
function gcd --description "cd in a git repository"
    if git rev-parse --show-toplevel >/dev/null
        if test (count $argv) -le 1
            cd (git rev-parse --show-toplevel)"/$argv"
        else
            set_color red
            echo "Too many arguments"
            set_color normal
        end
    end
end

# pbcopy/pbpaste
if type xsel >/dev/null 2>&1
    alias pbcopy="xsel --clipboard --input"
    alias pbpaste="xsel --clipboard --output"
end

# Convert mp4 to gif with gifski
#   https://github.com/ImageOptim/gifski
function mp42gif --description "Convert mp4 to gif with gifski"
    if test (count $argv) -ne 2
        then
        echo "Usage: "
        echo "    mp42gif <INPUT_FILE> <OUTPUT_FILE>"
        return 1
    end
    set --local tmpdir (mktemp -d --tmpdir mp42gif.XXXXXXXXXX) && \
        ffmpeg -i $argv[1] -an -r 30 $tmpdir/%04d.png && \
        gifski -o $tmpdir/tmp.gif --fps 30 $tmpdir/*.png && \
        gifsicle -i $tmpdir/tmp.gif -O3 --colors 256 -o $argv[2] && \
        rm -r $tmpdir
end

# shortcut commands
alias e="exit"
alias g="git"

# typo
alias gits="git s"
alias giit="git"
alias giiit="git"
alias code.="code ."
alias ks="ls"

# fish settings
function fish_greeting
    if type toilet >/dev/null 2>&1
        echo
        toilet -f pagga -F border -F gay "Hello, fish! "
    end
end