#!/bin/bash

compgen -c | sort -u | jq -R -s -c 'split("\n")[:-1]'
