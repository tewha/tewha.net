#!/bin/sh
jekyll --no-server --no-auto
rsync -raz _site/ tewha@tewha.net:tewha.net