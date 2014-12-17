# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{bash_prompt,aliases,functions}; do
	[ -r "$file" ] && source "$file"
done
unset file


# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

export RBENV_ROOT=/usr/local/var/rbenv

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Android SDK PATH
export PATH=$PATH:~/Development/adt-bundle-mac-x86_64-20140702/sdk/platform-tools
export PATH=$PATH:~/Development/adt-bundle-mac-x86_64-20140702/sdk/tools
