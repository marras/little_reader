#!/bin/bash

export ITERATION=1

function process {
  echo "Iteration #$ITERATION"
  ./scripts/process_missing.rb $1
  echo "Please check if all images are ok. Remove bad images from tmp/new_images."
  echo "Press ENTER when finished."
  read

  ./scripts/move_images.sh
  ./scripts/reconcile_mapping.rb

  ITERATION=$(($ITERATION + 1))
}

process
process rysunek
process zdjęcie
