# MyENV - Windows

My working environment for Windows:

* `git clone --recurse-submodules https://github.com/reksar/myenv-win.git`
* set `%MYENV_APPS%` in `scripts\myenv.bat`
* entry point is `myenv.lnk`
* use `myenv-test` cmd

## Install portable apps

Install specified `app` to `%MYENV_APPS%`:

```batch
myenv-install [app]
```

Available `app` values are set in `%APPS%` var in `scripts\myenv-install.bat`:

* `python`
* `pip`
* `vs` (MS Visual Studio)
