# emacs-profiles

[![Marmalade](https://img.shields.io/badge/marmalade-available-8A2A8B.svg)](https://marmalade-repo.org/packages/emacs-profiles)  
[![License](https://img.shields.io/badge/LICENSE-GPL%20v3.0-blue.svg)](https://www.gnu.org/licenses/gpl.html)
[![Gratipay](http://img.shields.io/gratipay/myTerminal.svg)](https://gratipay.com/myTerminal)

Configuration profiles for Emacs.

You can use emacs-profiles to switch between multiple sets of configuration at a couple of key-presses.

## Installation

### Manual

Save the file *emacs-profiles.el* to disk and add the directory containing it to `load-path` using a command in your *.emacs* file like:

    (add-to-list 'load-path "~/.emacs.d/")

The above line assumes that you've placed the file into the Emacs directory '.emacs.d'.

Start the package with:

    (require 'emacs-profiles)

### Marmalade

If you have Marmalade added as a repository to your Emacs, you can just install *emacs-profiles* with

    M-x package-install emacs-profiles RET

## Usage

Set a key-binding to open the configuration menu that displays all configured configurations.

    (global-set-key (kbd "C-M-`") 'emacs-profiles-show-menu)

You can also define your configuration as

    (emacs-profiles-set-profiles-data
        (list '("1" 
                "Office" 
                (lambda ()
                    (invert-face 'default)))
              '("2" 
                "Home" 
                (lambda ()
                    (menu-bar-mode -1)
                    (tool-bar-mode -1)
                    (scroll-bar-mode -1)))))

Each item in the list should contain three elements:

* Key to be pressed to load the profile
* Name of the profile
* A function to be executed against the key, the function that contains all scripts to be executed to apply that particular configuration.

Lastly, you can also call `emacs-profiles-show-menu` at startup so that you can choose which profile to start Emacs in when you start it.

## Let me know

Let me know your suggestions on improving *emacs-profiles* at ismail@teamfluxion.com

Thank you!
