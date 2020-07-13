#!/bin/sh

_build/default/bin/example "$@" || echo "run error code: $?"
