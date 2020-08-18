# Homebrew

## Homebrew documentation

The Homebrew documentation can be found at:
https://github.com/Homebrew/homebrew/tree/master/share/doc/homebrew#readme

## Uninstall Homebrew

In case brew update gives you a lot of issues. Uninstall Homebrew to reinstall.

> Be aware that you'll need to reinstall anything installed with Homebrew
> previously (such as f.i. /Solr)

```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
```

## Check Homebrew

You can check Homebrew status by running the doctor command:

```bash
brew doctor
```

It will list problems and suggest the proper solution for them.

## Update Homebrew

Update Homebrew and its installed packages:

```bash
$ brew upgrade
$ brew update
```
