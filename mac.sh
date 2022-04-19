#!/bin/bash
echo "Initiating MacOS 64x setup..."
sleep 3
echo "Creating a temp directory..."
sudo mkdir /tmp/osu-dev-setup
cd /tmp/osu-dev-setup
echo "Downloading DotNet SDK..."
sudo wget https://download.visualstudio.microsoft.com/download/pr/4332c16b-5a65-4adf-b25d-f6a46ef2b335/1a1edc2dab547161e2448390c3d4f56d/dotnet-sdk-6.0.202-osx-x64.pkg
echo "Installing DotNet SDK..."
sudo installer -pkg ./dotnet-sdk-6.0.202-osx-x64.pkg -target /
echo "Downloading Visual Studio for Mac..."
sudo wget https://download.visualstudio.microsoft.com/download/pr/c7bf1a23-aad1-4d64-b23e-57f799ac7c91/e8dcf73b854730a3dfb2d848bccc8f2b/visualstudioformacinstaller-8.10.15.1.dmg
echo "Mounting Visual Studio for Mac..."
sudo hdiutil mount ./visualstudioformacinstaller-8.10.15.1.dmg
echo "Installing Visual Studio for Mac Part 1..."
sudo cp -R "/Volumes/Visual Studio for Mac Installer/Install Visual Studio for Mac.app" /tmp/osu-dev-setup/VSInstaller.app
echo "Unmounting Visual Studio for Mac..."
sudo hdiutil unmount "/Volumes/Visual Studio for Mac Installer"
echo "Starting Visual Studio for Mac Installer..."
sudo open /tmp/osu-dev-setup/VSInstaller.app
echo "Please follow the instructions in the app."
echo "MAKE SURE TO ADD XAMRIN IN THE INSTALLER"
echo "When you have finished installing, press any key to continue..."
read -p "Press any key to continue... " -n1 -s
echo "That was easy, wasn't it?"
echo "Now that we've installed Visual Studio for Mac, we need to get an IDE..."
echo "What IDE do you prefer: Visual Studio: VS, JetBrains Rider: RD, VSCode: VSC, or None: N (I already have an IDE)?"
read -r -p "Please type your preferred IDE below (VS, RD, VSC, N): " response
if [ $response == "VS" ] then 
    echo "Since we already installed Visual Studio, we can continue to the next step..."
    continue_ok()
elif [ $response == "RD" ] then
    echo "Alright, let's install Rider..."
    echo "Downloading Rider..."
    sudo wget https://download.jetbrains.com/rider/JetBrains.Rider-2021.3.4.dmg
    echo "Mounting Rider..."
    sudo hdiutil mount ./JetBrains.Rider-2021.3.4.dmg
    echo "Installing Rider..."
    sudo cp -R "/Volumes/Rider/Rider.app" /Applications
    echo "Unmounting Rider..."
    sudo hdiutil unmount "/Volumes/Rider"
    echo "Alright, let's continue to the next step..."
    continue_ok()
elif [ $response == "VSC" ] then
    echo "Alright, let's install VSCode..."
    echo "Downloading VSCode..."
    sudo wget https://az764295.vo.msecnd.net/stable/dfd34e8260c270da74b5c2d86d61aee4b6d56977/VSCode-darwin-universal.zip
    echo "Installing VSCode..."
    sudo unzip VSCode-darwin-universal.zip -d /Applications
    echo "Alright, let's continue to the next step..."
    continue_ok()
else
    echo "Alright, let's continue to the next step..."
    continue_ok()
fi

continue_ok() {
    read -r -p "Where do you want to put the osu! source code? (path): " response
    echo "Cloning git repository..."
    path = "$response/osu"
    git clone https://github.com/ppy/osu "$path"
    echo "Entering the osu! source code directory..."
    cd "$path/osu"
    echo "Congratulations! You sucessfully setup an osu! development environment!"
    echo "You can open the project $path/osu in your favorite IDE (in your Applications folder)."
    echo "If you want to open the project in VS Code, you can do so by typing 'code $path/osu' in your terminal."
    echo "If you want to build the project right away, you can run dotnet run --project osu.<platform> (platform being the platform you want to build)"
    exit 0
}


