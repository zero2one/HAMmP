# Node.JS

## NVM

If you are working on multiple projects, multiple versions of node-js can be
required. We use the Node Version Manager to overcome this problem.

Install using brew:

```bash
brew install nvm
```

Close the terminal window and open a new one. This will make the nvm command
available.

Create the home directory:

```bash
mkdir ~/.nvm
```

Add the following to ~/.bash_profile or your desired shell:

```bash
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
```

## Install Node

Install node using nvm:

```bash
nvm install node --lts
```

## Grunt

Install the Grunt-CLI through NPM like so:

```bash
npm install -g grunt grunt-cli
```

### Bower

Install the Bower Package Manager through NPM like so:

```bash
npm install -g bower
```
