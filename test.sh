# curl 'https://music.youtube.com/youtubei/v1/search' \
#         -H 'Content-Type: application/json' \
#         --data-raw '{
#       "context": {
#         "client": {
#           "clientName": "WEB_REMIX",
#           "clientVersion": "1.20250910.03.00"
#         }
#       },
#       "query": "for a reason"
# }' | jq '.. | objects | select(.text? == "For A Reason")'
#
curl 'https://music.youtube.com/youtubei/v1/search' \
        -H 'Content-Type: application/json' \
        --data-raw '{
      "context": {
        "client": {
          "clientName": "WEB_REMIX",
          "clientVersion": "1.20250910.03.00"
        }
      },
      "query": "for a reason"
}' | jq '.. | ."text"? | select (. != null)'
