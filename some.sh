#!/bin/sh

# # Useful links
# http://sourabhbajaj.com/mac-setup/
# https://gist.github.com/zenorocha/7159780
# https://coderwall.com/p/yiot4q/setup-vim-powerline-and-iterm2-on-mac-os-x



catEnate() {

cat <<'EOT' >> ~/.zshrc
ZSH_THEME="agnoster"
plugins=(git colored-man colorize github jira vagrant virtualenv pip python brew osx zsh-syntax-highlighting)

# Add env
source ~/.env
EOT;

cat <<'EOT' >> ~/.env
#!/bin/zsh

# PATH
export PATH="/usr/local/share/python:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export EDITOR=vim

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

# mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

# Aliases
alias cppcompile='c++ -std=c++11 -stdlib=libc++'

# Use sublimetext for editing config files
# alias zshconfig="subl ~/.zshrc"
EOT

}


echo
echo "<================_BEGIN_================>"
echo


# ======================================= Homebrew
echo
echo
echo "*********Homebrew*********"
echo "Do you want to install Homebrew? (NOTE: ESSENTIAL FOR SUBSEQUENT INSTALLATIONS/OPERATIONS)"
read -p "(y/n)? " userInput

# Catch user errors
while [ "$userInput" != "y" ] && [ "$userInput" != "n" ] || [ -z $userInput ]; do
  echo "Please try again."
  read -p "(y/n)? " userInput
done
if [ "$userInput" = "y" ]; then
  echo "Installing Homebrew (Terminal command: 'brew')"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  brew install \
    wget \
    curl \
    git \
  echo "brew list"
  brew list
elif [ "$userInput" = "n" ]; then
  echo "WARNING! You're gonna need Homebrew to install some of the next ones!"
fi
echo "*********Homebrew*********"

# ======================================= Git and configurations
echo
echo
echo "*********Git*********"
echo "Do you want to install Git? (NOTE: A version control system. NEEDED FOR NEXT.)"
read -p "(y/n)? " userInput

# Catch user errors
while [ "$userInput" != "y" ] && [ "$userInput" != "n" ] || [ -z $userInput ]; do
  echo "Please try again."
  read -p "(y/n)? " userInput
done
if [ "$userInput" = "y" ]; then
  echo "Installing Git (Terminal command: 'git')"
  brew install git
  read -r -p "Enter your git user name and press [ENTER]: " credential
  git config --global user.name "$credential"
  read -r -p "Enter your git user email and press [ENTER]: " credential
  git config --global user.email "$credential"
  git config --global core.autocrlf input
  git config --global core.safecrlf true
elif [ "$userInput" = "n" ]; then
  echo "Git was not installed."
fi
echo "*********Git*********"

# ======================================= Zsh
echo
echo
echo "*********Zsh*********"
echo "Do you want to install Zsh? (NOTE: Important for terminal customizations)"
read -p "(y/n)? " userInput

while [ "$userInput" != "y" ] && [ "$userInput" != "n" ] || [ -z $userInput ]; do
  echo "Please try again."
  read -p "(y/n)? " userInput
done
if [ "$userInput" = "y" ]; then
  echo "Installing Zsh (Terminal command: 'zsh')"
  brew install zsh zsh-completions

elif [ "$userInput" = "n" ]; then
  echo "Zsh was not installed."
fi
echo "*********Zsh*********"

# ======================================= Oh My Zsh
echo
echo
echo "*********Oh-My-Zsh*********"
echo "Do you want to install Oh-My-Zsh? (NOTE: Usually installed after installing Zsh)"
read -p "(y/n)? " userInput

while [ "$userInput" != "y" ] && [ "$userInput" != "n" ] || [ -z $userInput ]; do
  echo "Please try again."
  read -p "(y/n)? " userInput
done
if [ "$userInput" = "y" ]; then
  echo "Installing Oh-My-Zsh (Terminal command: null  )"
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  chsh -s /usr/local/bin/zsh
  $catEnate

elif [ "$userInput" = "n" ]; then
  echo "Oh-my-zsh not installed and configured."
fi
echo "*********Oh-My-Zsh*********"


# ======================================= scm-breeze
echo
echo
echo "*********_scm-breeze_*********"
echo "Do you want to install scm-breeze? (NOTE: A plugin for Git)"
read -p "(y/n)? " userInput

while [ "$userInput" != "y" ] && [ "$userInput" != "n" ] || [ -z $userInput ]; do
  echo "Please try again."
  read -p "(y/n)? " userInput
done
if [ "$userInput" = "y" ]; then
  echo "Installing scm-breeze (Terminal command: null)"
  git clone git://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
  ~/.scm_breeze/install.sh
  source ~/.zshrc
elif [ "$userInput" = "n" ]; then
  echo "scm-breeze was not installed."
fi
echo "*********_scm-breeze_*********"


# ======================================= x-code
echo
echo
echo "*********_x-code_*********"
echo "Do you want to install x-code? (NOTE: An IDE for Apple devices)"
read -p "(y/n)? " userInput

while [ "$userInput" != "y" ] && [ "$userInput" != "n" ] || [ -z $userInput ]; do
  echo "Please try again."
  read -p "(y/n)? " userInput
done
if [ "$userInput" = "y" ]; then
  echo "Installing x-code (Terminal command: null)"
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    head -n 1 | awk -F"*" '{print $2}' |
    sed -e 's/^ *//' |
    tr -d '\n')
  softwareupdate -i "$PROD" -v;
elif [ "$userInput" = "n" ]; then
  echo "x-code was not installed."
fi
echo "*********_x-code_*********"


# ======================================= Chruby && ruby-install
echo
echo
echo "*********_Chruby/Ruby_*********"
echo "Do you want to install Chruby/Ruby? (NOTE: Package installer)"
read -p "(y/n)? " userInput     
while [ "$userInput" != "y" ] && [ "$userInput" != "n" ] || [ -z $userInput ]; do
  echo "Please try again."
  read -p "(y/n)? " userInput
done
if [ "$userInput" = "y" ]; then
  echo "Installing Chruby and Ruby (Terminal command: gem)"
  if ! [ -x "$(command -v chruby)" ]; then
    brew install chruby ruby-install
    ruby-install --latest ruby
    source /usr/local/opt/chruby/share/chruby/auto.sh
    source ~/.zshrc
  fi
  echo "gem: --no-ri --no-rdoc" > ~/.gemrc
  echo "Installing Bundler"
  gem install bundler
elif [ "$userInput" = "n" ]; then
  echo "Chruby/Ruby was not installed."
fi
echo "*********_Chruby/Ruby_*********"


# ======================================= MongoDB
echo
echo
echo "*********_MongoDB_*********"
echo "Do you want to install MongoDB? (NOTE: Package installer)"
read -p "(y/n)? " userInput     
while [ "$userInput" != "y" ] && [ "$userInput" != "n" ] || [ -z $userInput ]; do
  echo "Please try again."
  read -p "(y/n)? " userInput
done
if [ "$userInput" = "y" ]; then
  echo "Installing MongoDB (Terminal command: mongo)"
  brew install mongodb --with-openssl

  sudo mkdir -p /data/db
  sudo chown -R $USER /data/db
cat <<'EOT' >> ~/.zshrc

# mongodb setup
export MONGO_PATH=/usr/local/mongodb
export PATH=$PATH:$MONGO_PATH/bin
EOT
elif [ "$userInput" = "n" ]; then
  echo "MongoDB was not installed."
fi
echo "*********_MongoDB_*********"


# ======================================= NVM/Node
echo
echo
echo "*********_NVM_*********"
echo "Do you want to install NVM? (NOTE: Package installer)"
read -p "(y/n)? " userInput     
while [ "$userInput" != "y" ] && [ "$userInput" != "n" ] || [ -z $userInput ]; do
  echo "Please try again."
  read -p "(y/n)? " userInput
done
if [ "$userInput" = "y" ]; then
  echo "Installing NVM, Node (Terminal command: nvm, node)"
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash
  source ~/.zshrc
  nvm install node
  nvm use node
  sh ./global_npm.sh
elif [ "$userInput" = "n" ]; then
  echo "NVM was not installed."
fi
echo "*********_NVM_*********"


# ======================================= Brew Stuff
echo
echo
echo "*********_Brew Packages_*********"
echo "Do you want to install Brew Packages? (NOTE: Package installer)"
read -p "(y/n)? " userInput     
while [ "$userInput" != "y" ] && [ "$userInput" != "n" ] || [ -z $userInput ]; do
  echo "Please try again."
  read -p "(y/n)? " userInput
done
if [ "$userInput" = "y" ]; then
  echo "checking Brewfile"
  brew bundle check
  echo "Install missing brew bundle"
  brew bundle
elif [ "$userInput" = "n" ]; then
  echo "Brew Packages was not installed."
fi
echo "*********_Brew Packages_*********"


# ======================================= Sublime Text 3
echo
echo
echo "*********_SublimeText3_*********"
echo "Do you want to install SublimeText3? (NOTE: Package installer)"
read -p "(y/n)? " userInput     
while [ "$userInput" != "y" ] && [ "$userInput" != "n" ] || [ -z $userInput ]; do
  echo "Please try again."
  read -p "(y/n)? " userInput
done
if [ "$userInput" = "y" ]; then
  ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

  wget https://packagecontrol.io//Package%20Control.sublime-package --directory-prefix ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages

  cp ./sublime_settings/Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings
  cp ./sublime_settings/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
  echo "Sublime Text 3 successfully installed.
  echo"
elif [ "$userInput" = "n" ]; then
  echo "SublimeText3 was not installed."
fi
echo "*********_SublimeText3_*********"



echo
echo
echo "<================_END_================>"
echo "ENJOY YOUR NOW-WORKABLE COMPUTER!"