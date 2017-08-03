#!/bin/bash
set -eux

NAME=pandoc-watch-build

docker run \
    --name $NAME \
    --interactive \
    --tty \
    --volume "$PWD:/pandoc" \
    --rm \
    --entrypoint stack \
    andreasjansson/engrafo-pandoc \
    install --file-watch --flag pandoc:embed_data_files
