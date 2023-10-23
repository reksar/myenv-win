#!/bin/sh
# Prevents some paths manually set in `scripts/myenv.bat` from being committed.
sed -e "s/set \"MYENV_APPS=.*\"/set \"MYENV_APPS=\"/"
