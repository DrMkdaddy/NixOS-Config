#!/bin/env bash
$EDITOR $(rg ''$1 | cut -f1 -d ":" | tofi)
