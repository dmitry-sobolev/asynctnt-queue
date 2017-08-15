#!/usr/bin/env bash

if [[ "${BUILD}" != *tests* ]]; then
    echo "Skipping tests."
    exit 0
fi

if [ "${TRAVIS_OS_NAME}" == "osx" ]; then
    PYENV_ROOT="$HOME/.pyenv"
    PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

if [[ "${BUILD}" == *quicktests* ]]; then
    make && make quicktest || exit 1
else
    make && make test || exit 1
    make clean && make debug && make test || exit 1
fi

if [[ "${BUILD}" == *coverage* ]]; then
    make debug && coverage run --source=asynctnt_queue setup.py test
fi
