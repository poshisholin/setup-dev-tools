#!/bin/bash

# Install necessary tools and libraries for C++ development.

# Function to install Homebrew
install_homebrew() {
  echo "Checking for Homebrew..."
  if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew has been successfully installed."
  else
    echo "Homebrew is already installed."
  fi
}

# Function to install Xcode Command Line Tools
install_xcode_command_line_tools() {
  echo "Checking for Xcode Command Line Tools..."
  if ! xcode-select --print-path &> /dev/null; then
    echo "Xcode Command Line Tools are not installed. Installing..."
    xcode-select --install
    echo "Xcode Command Line Tools installation initiated."
  else
    echo "Xcode Command Line Tools are already installed."
  fi
}

# Function to install core development tools
install_dev_tools() {
  echo "Updating Homebrew..."
  brew update

  echo "Upgrading Homebrew packages..."
  brew upgrade

  echo "Installing development tools..."
  brew install cmake
  brew install clang
  brew install llvm
  brew install gcc
  brew install make
  brew install gdb
  brew install boost
  brew install fmt
  brew install libxml2
  brew install openssl
  brew install sqlite
  brew install pkg-config

  echo "Development tools have been successfully installed."
}

# Function to install additional utilities
install_additional_utils() {
  echo "Installing additional utilities..."
  brew install git
  brew install wget
  brew install curl
  brew install ninja
  brew install doxygen

  echo "Additional utilities have been successfully installed."
}

# Install all dependencies
install_homebrew
install_xcode_command_line_tools
install_dev_tools
install_additional_utils

echo "All C++ development tools and dependencies have been successfully installed!"