#!/bin/sh
jekyll --no-server --no-auto
rsync -r _site/* tewha@tewha.net:tewha.net