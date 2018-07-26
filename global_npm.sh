#!/bin/sh

# https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md

# 1. Create a directory for globally packages
mkdir "${HOME}/.npm-packages"

# 2. Indicate to npm where to store globally installed packages. In your ~/.npmrc file add:
cat <<'EOT' >> ~/.npmrc
prefix=${HOME}/.npm-packages

EOT

# 3. Ensure npm will find installed binaries and man pages. Add the following to your .bashrc/.zshrc:
cat <<'EOT' >> ~/.zshrc
NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

EOT

source ~/.zshrc