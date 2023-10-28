#!/bin/sh
# Prevents some paths manually set in `scripts/pwe.bat` from being committed.
sed -e "s/set \"PWE_APPS=.*\"/set \"PWE_APPS=\"/"
