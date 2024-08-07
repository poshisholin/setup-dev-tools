#!/bin/bash

# Function to check and install CocoaPods if needed
install_pods_if_needed() {
  echo -n "Checking CocoaPods: "
  if ! command -v pod &> /dev/null; then
    echo -e "\033[31mNot Installed\033[0m"
    echo "Installing CocoaPods..."
    sudo gem install cocoapods
    echo -e "\033[32mCocoaPods has been successfully installed.\033[0m"
  else
    echo -e "\033[32mAlready Installed\033[0m"
  fi
}

# Function to check for Xcode Command Line Tools
check_xcode_command_line_tools() {
  echo -n "Checking Xcode Command Line Tools: "
  if ! xcode-select --print-path &> /dev/null; then
    echo -e "\033[31mNot Installed\033[0m"
    echo "Installing Xcode Command Line Tools..."
    sudo xcode-select --install
    echo "Xcode Command Line Tools installation initiated."
  else
    echo -e "\033[32mAlready Installed\033[0m"
  fi

  # Ensure the correct path is set for Xcode Command Line Tools
  XCODE_PATH=$(find /Applications -maxdepth 1 -type d -name "Xcode*.app" | head -n 1)

  if [ -n "$XCODE_PATH" ]; then
    echo "Setting Xcode Command Line Tools path to $XCODE_PATH/Contents/Developer..."
    sudo xcode-select --switch "$XCODE_PATH/Contents/Developer"
    echo -e "\033[32mXcode Command Line Tools path has been set correctly.\033[0m"
  else
    echo -e "\033[31mXcode not found. Please ensure Xcode is installed.\033[0m"
  fi
}

# Function to find and check for Xcode installation
check_xcode() {
  echo -n "Checking Xcode Installation: "
  # Find Xcode in /Applications
  XCODE_PATH=$(find /Applications -maxdepth 1 -type d -name "Xcode*.app" | head -n 1)

  if [ -n "$XCODE_PATH" ]; then
    echo -e "\033[32mInstalled at $XCODE_PATH\033[0m"
    
    # Check Xcode version
    echo -n "Xcode Version: "
    "$XCODE_PATH/Contents/Developer/usr/bin/xcodebuild" -version | head -n 1

    # Verify if Xcode accepts the license agreement
    echo "Checking Xcode license..."
    sudo "$XCODE_PATH/Contents/Developer/usr/bin/xcodebuild" -license accept
    echo -e "\033[32mXcode license agreement accepted.\033[0m"

    # Check if Xcode Command Line Tools are properly set up
    if [ "$(xcode-select --print-path)" == "$XCODE_PATH/Contents/Developer" ]; then
      echo -e "\033[32mXcode Command Line Tools are correctly configured.\033[0m"
    else
      echo -e "\033[31mXcode Command Line Tools are not correctly configured. Please configure manually.\033[0m"
    fi
  else
    echo -e "\033[31mNot Installed\033[0m"
    echo "Please install Xcode from the App Store or download from the Apple Developer website."
  fi
}

# Function to check for SwiftLint
check_swiftlint() {
  echo -n "Checking SwiftLint: "
  if ! command -v swiftlint &> /dev/null; then
    echo -e "\033[31mNot Installed\033[0m"
    echo "Installing SwiftLint..."
    brew install swiftlint
    echo -e "\033[32mSwiftLint has been successfully installed.\033[0m"
  else
    echo -e "\033[32mAlready Installed\033[0m"
  fi
}

# Update Homebrew and installed packages
echo "Updating Homebrew..."
brew update
brew upgrade
brew cleanup
echo -e "\033[32mHomebrew is up to date.\033[0m"

# Check and install CocoaPods if not present
install_pods_if_needed

# Check Xcode Command Line Tools
check_xcode_command_line_tools

# Check for Xcode installation
check_xcode

# Check and install SwiftLint if not present
check_swiftlint

# Update CocoaPods dependencies if Podfile is present
echo -n "Checking for Podfile: "
if [ -f "Podfile" ]; then
  echo -e "\033[32mFound\033[0m"
  echo "Updating CocoaPods..."
  pod repo update
  pod update
  echo -e "\033[32mCocoaPods dependencies have been updated.\033[0m"
else
  echo -e "\033[31mNot Found\033[0m"
  echo "Podfile not found. CocoaPods dependencies update is not required."
fi

echo -e "\033[32mAll tasks have been completed successfully!\033[0m"