#!/bin/bash

echo '
  [
    "pub_key:ID",
    "last_update:int",
    "alias",
    "addresses:string[]",
    "color",
    ":LABEL"
  ]
' | jq -r '@csv'

cat | jq -r '
  .nodes
  | map([
      .pub_key,
      .last_update,
      .alias,
      (.addresses | map(.addr) | join(";")),
      .color,
      "Node"
    ])
  | .[]
  | @csv
'
