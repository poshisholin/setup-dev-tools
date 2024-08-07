#!/bin/bash

# Установите необходимые инструменты и библиотеки для разработки на C++.

# Функция для установки Homebrew
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

# Функция для установки Xcode Command Line Tools
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

# Функция для установки основных инструментов разработки
install_dev_tools() {
  echo "Updating Homebrew..."
  brew update

  echo "Upgrading Homebrew packages..."
  brew upgrade

  echo "Installing development tools..."
  brew install cmake        # Система сборки CMake
  brew install clang        # Компилятор Clang (входит в LLVM)
  brew install llvm         # Установка LLVM
  brew install gcc          # Компилятор GCC
  brew install make         # Утилита сборки Make
  brew install gdb          # Отладчик GDB
  brew install boost        # Библиотека Boost
  brew install fmt          # Библиотека fmt
  brew install libxml2      # Библиотека XML
  brew install openssl      # Библиотека OpenSSL
  brew install sqlite       # Библиотека SQLite
  brew install pkg-config   # Утилита pkg-config для обнаружения библиотек

  echo "Development tools have been successfully installed."
}

# Функция для проверки и установки дополнительных утилит
install_additional_utils() {
  echo "Installing additional utilities..."
  brew install git          # Система контроля версий Git
  brew install wget         # Утилита для загрузки файлов из интернета
  brew install curl         # Инструмент для работы с URL
  brew install ninja        # Система сборки Ninja
  brew install doxygen      # Инструмент для генерации документации

  echo "Additional utilities have been successfully installed."
}

# Установка всех зависимостей
install_homebrew
install_xcode_command_line_tools
install_dev_tools
install_additional_utils

echo "All C++ development tools and dependencies have been successfully installed!"