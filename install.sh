# Determine OS name
os=$(uname)

echo "========================================================================="
echo " If you are not using termux please install nodejs and clang by yourself "
echo "========================================================================="

# Install depedencies
if [ "$os" = "Linux" ]; then
  echo "This is a Linux Machine"
  if [[ -f /etc/redhat-release ]]; then
    pkg_manager=yum
  elif [[ -f /etc/debian_version ]]; then
    pkg_manager=apt
  elif [[ $TERMUX_VERSION ]]; then
    pkg_manager=pkg
  fi

  if [[ $pkg_manager = "yum" ]]; then
    echo "Installing depedencies"
    sudo yum install git ripgrep neovim -y
  elif [[ $pkg_manager = "apt" ]]; then
    echo "Installing depedencies"
    sudo apt install git ripgrep neovim -y
    echo "Please wait"
  elif [[ $pkg_manager = "pkg" ]]; then
    echo "Installing depedencies"
    pkg upgrade -y && pkg install git ripgrep neovim nodejs clang -y
    echo "Please wait"
  fi

elif [[ "$os" = "Darwin" ]]; then
  echo "This is an Apple Mac Machine"
  echo "Installing depedencies"
  brew install install git ripgrep neovim 
else
  echo "Unsupported OS"
  exit 1
fi

echo "Congratulations, depedencies has successfully installed!"

echo "Now, Cloning the repos"

git clone https://github.com/DinkyTrady/nvim --depth=1 $HOME/.config/nvim

echo "Successfully clone repo!"

echo "Start Neovim"

nvim
