#!/usr/bin/env bash
#=============================================================================#
# do all the make at once
#=============================================================================#
make clean
make html
bash fix_name.sh
# rsync -r build/html/ bs4doc/