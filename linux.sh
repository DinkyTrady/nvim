# Determine OS name
os=$(uname)

# Install depedencies
if [ "$os" = "Linux" ]; then
echo "This is a Linux Machine"
  if [[ -f /etc/redhat-release ]]; then
    pkg_manager=yum
  elif [[ -f /etc/debian_version ]]; then
    pkg_manager=apt
  fi

  if [[ $pkg_manager = "yum" ]]; then
    sudo yum install git ripgrep neovim nodejs clang -y
  elif [[ $pkg_manager = "apt" ]]; then
    apt install git ripgrep neovim nodejs clang -y
  fi

elif [[ "$os" = "Darwin" ]]; then
  brew install install git ripgrep neovim nodejs clang 
echo "This is an Apple Mac Machine"
else
  echo "Unsupported OS"
  exit 1

fi

echo "Congratulations, depedencies has successfully installed!"

echo "Now, Clone repos"

git clone https://github.com/DinkyTrady --depth=1 $HOME/.config/nvim

nvim
