# Portable Windows Environment (PWE)

* `git clone --recurse-submodules https://github.com/reksar/pwe.git`
* set `%PWE_APPS%` in `scripts\pwe.bat`
* entry point is `pwe.lnk`
* use `pwe-test` cmd

## Install portable apps

Run `pwe-install` without args to list available apps.

Install the specified `app` to `%PWE_APPS%`: `pwe-install [app] {options}`.

The `options` depends on `scripts\pwe-install\<app>.bat` installer and can be:

* `-force` to delete existing app dir before install
* `-version <value>`
