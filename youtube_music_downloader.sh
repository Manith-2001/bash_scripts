#!/usr/bin/env bash
query=$(printf '' | fzf --print-query | head -n1)

source .venv/bin/activate.fish

chosen=$(curl -s 'https://music.youtube.com/youtubei/v1/search' \
  -H 'Content-Type: application/json' \
  --data-raw "{
    \"context\": {
      \"client\": {
        \"clientName\": \"WEB_REMIX\",
        \"clientVersion\": \"1.20250910.03.00\"
      }
    },
    \"query\": \"$query\"
  }" | jq -r '
    [ .. | objects
      | select(.navigationEndpoint.watchEndpoint.videoId?)
      | select(.text | type == "string" and (. != "Start radio" and . != "Shuffle play"))
      | {title: .text, id: .navigationEndpoint.watchEndpoint.videoId}
    ] | .[]
    | "\(.title) ::: \(.id)"
  ' | fzf)

title=$(cut -d " " -f1 <<< "$chosen")
id=$(sed 's/.*::: //' <<< "$chosen")

yt-dlp "https://music.youtube.com/watch?v=$id"

