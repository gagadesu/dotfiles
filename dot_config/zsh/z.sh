# If ZSH is not defined, use the current script's directory.
# [[ -z "$ZSH" ]] && export ZSH="${${(%):-%x}:a:h}"

# Set ZSH_CACHE_DIR to the path where cache files should be created
# or else we will use the default cache/
# if [[ -z "$ZSH_CACHE_DIR" ]]; then
#   ZSH_CACHE_DIR="$HOME/.zsh/cache"
# fi

# Make sure $ZSH_CACHE_DIR is writable, otherwise use a directory in $HOME
# if [[ ! -w "$ZSH_CACHE_DIR" ]]; then
#   ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
# fi

# Create cache and completions dir and add to $fpath
# mkdir -p "$ZSH_CACHE_DIR/completions"
# (( ${fpath[(Ie)"$ZSH_CACHE_DIR/completions"]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)

# add a function path
# fpath=("$ZSH/functions" "$ZSH/completions" $fpath)

# Load all stock functions (from $fpath files) called below.
# autoload -U compaudit compinit zrecompile
# Load all of the config files in ~/oh-my-zsh that end in .zsh
for config_file ("$ZSH"/lib/*.zsh); do
  # custom_config_file="$ZSH_CUSTOM/lib/${config_file:t}"
  # [[ -f "$custom_config_file" ]] && config_file="$custom_config_file"
  source "$config_file"
done
# unset custom_config_file

