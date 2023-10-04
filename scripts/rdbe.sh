#!/bin/bash
# https://unix.stackexchange.com/questions/517773/delete-files-same-name-but-different-file-extension/517776
# TODO: make generic
find . -type f -name '*.js' -exec sh -c '      
    for pathname do
        [ -f "${pathname%.js}.ts" ] && rm "$pathname"
    done' sh {} +
