#!/bin/sh
jekyll build
rsync --delete -raz _site/ tewha@tewha.net:tewha.net
