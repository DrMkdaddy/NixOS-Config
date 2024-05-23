#!/bin/sh
$EDITOR $(rg ''$1 | cut -f1 -d ":" | tofi)
