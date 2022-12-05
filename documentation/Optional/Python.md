# Python

MacOS has, since v12.6 Monterey, by default Python 3 installed. This can give
problems with node-sass that still requires Python 2.

The solution is to install multiple Python versions.

## Installation

Install [pyenv] so we can install and switch between versions.

```shell
brew install pyenv
```

Install the version(s) you need.

```shell
pyenv install 2.7.18
pyenv install 3.11.0
```

Add pyenv to your PATH so that you can reference python (not python3):

```shell
echo "export PATH=\"\${HOME}/.pyenv/shims:\${PATH}\"" >> ~/.zshrc
```

Both versions should now be available:

Set the Python versions you want to use globally:

```shell
pyenv global 3.7.0 2.7.15
```

Open a new terminal window and confirm your pyenv version is mapped to python

```shell
which python
python --version
python3 --version
python2 --version
```

[pyenv]: https://github.com/pyenv/pyenv
