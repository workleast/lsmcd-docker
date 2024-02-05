#!/bin/bash
set -e

sh /usr/local/lsmcd/bin/lsmcdctrl start
exec tail -f /dev/null
