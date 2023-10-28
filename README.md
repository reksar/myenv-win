# Portable Windows Environment

* `git clone --recurse-submodules https://github.com/reksar/pwe.git`
* set `%PWE_APPS%` in `scripts\pwe.bat`
* entry point is `pwe.lnk`
* use `pwe-test` cmd

## Install portable apps

Install specified `app` to `%PWE_APPS%`:

```batch
pwe-install [app] {version}
```

Available `app` values are set in `%APPS%` var in `scripts\pwe-install.bat`:

* `python`
* `pip`
* `vs` (MS Visual Studio)

The optional `version` is partially supported.
