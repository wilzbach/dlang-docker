#!/bin/sh

if [ "$D_VERSION" = "gdc" ]; then
    pkg=$(apk --no-cache info gcc-gdc | grep 'description:$' | awk '{ print $1 };')
    pkg=${pkg%-*}
    echo ${pkg#*-}
else
    pkg=$(apk --no-cache info $D_VERSION | grep 'description:$' | awk '{ print $1 };')
    echo ${pkg%-*}
fi
