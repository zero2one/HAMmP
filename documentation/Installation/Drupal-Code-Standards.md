# Drupal code standards

The Drupal code standards can be installed globally trough composer. PHPStorm 
can be configured to auto inspect the project using these standards.

## Requirements

* [Composer](PHP-Composer.md)
  We are installing the tools through composer, make sure that Composer is 
  installed globally.
* [PHP Code Sniffer](./PHP-Code-Sniffers.md#PHP-Code-Sniffer)
  Drupal code standards are checked trough the PHP Code Sniffer tool.

## Installation

Install Coder trough Composer:

```bash
composer global require drupal/coder
phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer
```

Start using PHPCS, example:

```bash
phpcs --standard=Drupal /path/to/example.module
```
 
Running php the code sniffer command for Drupal requires a lot of options to be 
defined. To make it easier we define an alias.

_Multiline command, copy all at once:_

```bash
cat >> ~/.bash_profile <<EOF

# Drupal code standards ---------------------------------------------
alias phpcsd="phpcs --standard=Drupal -p --colors --ignore=*.features.*,*.field_group.inc,*.strongarm.inc,*.ds.inc,*.context.inc,*.views_default.inc,*.file_default_displays.inc,*.facetapi_defaults.inc,dist,node_modules,bower_components --extensions=php,module,inc,install,test,profile,theme,js,css,info,txt"

EOF
```

Reload the bash_profile settings:

```bash
source ~/.bash_profile
```

From now on you can inspect Drupal code with the phpcsd command:

```bash
phpcsd /path/to/folder/or/file/to/inspect
```

## PHP Code Beautifier and Fixer

PHPCS comes with a second utility: The Code Beautifier and Fixer (PHPCBF).
This tool will try to automatically fix common issues in your code.

Examples are:

* Missing spaces between operators/parameters/...
* Capitals to start a comment and full stops to end them.
* Empty lines between return statements.
* And many many more...

Just like PHPCS, we can also make PHPCBF aware of the drupal defaults. Add an 
alias to use this tool with the Drupal standards:

```bash
cat >> ~/.bash_profile <<EOF

# Drupal code Beautifier and Fixer ----------------------------------
alias phpcsd="phpcs --standard=Drupal -p --colors --ignore=*.features.*,*.field_group.inc,*.strongarm.inc,*.ds.inc,*.context.inc,*.views_default.inc,*.file_default_displays.inc,*.facetapi_defaults.inc,dist,node_modules,bower_components --extensions=php,module,inc,install,test,profile,theme,js,css,info,txt"

EOF
```
Reload the bash_profile settings:

```bash
source ~/.bash_profile
```

From now on you can inspect Drupal code with the phpcsd command:

```bash
phpcbfd /path/to/folder/or/file/to/inspect
```

## PhpStorm

### Drupal Code Standards

To use Drupal coding standards in PhpStorm, go to 
Preferences -> Editor -> Inspections 

* Under PHP check PHP Code Sniffer validation. 
* Refresh the list of coding standards and select Drupal. 
* It's recommended to check "Show warnings as: " and select "Weak warning".

### PHP Code Beautifier and Fixer  & PHPStorm

phpcbf can be configured to run as an external tool in PHPStorm available on 
contextual links and when doing a commit.

Go to Settings -> Tools -> External Tools.

* Adjust program path. Parameters field contains everything in the phpcbfd 
  alias definition from above and "  $FileDir$" at the end (w/o quotes).

Reference: https://thiagoponte.wordpress.com/2015/08/03/run-php-codesniffer-code-beautifier-and-fixer-from-phpstorm/

### References

* See PHP Code quality documentation from PhpStorm
* See Drupal Code Sniffer documentation

---
* [Next : Mailhog](./Mailhog.md)
* [Overview](../README.md)
