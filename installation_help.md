Error installing json gem solved by installing libgmp-dev system dependency http://pastebin.com/EETFLSBp

    sudo apt-get install libgmp-dev

Need to install javascript runtime. Node.js should work. https://nodejs.org/en/download/package-manager/

    curl --silent --location https://deb.nodesource.com/setup_4.x | sudo bash -
    sudo apt-get install --yes nodejs
