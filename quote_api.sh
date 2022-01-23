#!/bin/bash
curl -s https://zenquotes.io/api/random | jq -C '.[] | .q +" ~ "+.a' | lolcat

