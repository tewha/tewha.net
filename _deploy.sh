#!/bin/sh
jekyll --no-server --no-auto
rsync --delete -raz _site/ tewha@tewha.net:tewha.net