#!/bin/bash
if [[ $1 =~ ^[[:digit:]]+$  ]]; then
    MAX_TITLE_WIDTH=$1
  else
    MAX_TITLE_WIDTH=$(($(tmux display -p '#{window_width}' 2> /dev/null || echo 120) - 90))
fi
if cmus-remote -Q > /dev/null 2> /dev/null; then
  CMUS_STATUS=$(cmus-remote -Q)
  STATUS=$(echo "$CMUS_STATUS" | grep status | head -n 1 | cut -d' ' -f2-)
  ARTIST=$(echo "$CMUS_STATUS" | grep 'tag artist' | head -n 1 | cut -d' ' -f3-)
  TITLE=$(echo "$CMUS_STATUS" | grep 'tag title' | cut -d' ' -f3-)
  DURATION=$(echo "$CMUS_STATUS" | grep 'duration' | cut -d' ' -f2-)
  POSITION=$(echo "$CMUS_STATUS" | grep 'position' | cut -d' ' -f2-)
  P_MIN=`printf '%02d' $(($POSITION / 60))`
  P_SEC=`printf '%02d' $(($POSITION % 60))`
  D_MIN=`printf '%02d' $(($DURATION / 60))`
  D_SEC=`printf '%02d' $(($DURATION % 60))`
  TIME="[$P_MIN:$P_SEC / $D_MIN:$D_SEC]"
  if [ "$D_SEC" = "-1" ]; then
    TIME="[ $P_MIN:$P_SEC]"
  fi
  if [ -n "$TITLE"  ]; then
    if [ "$STATUS" = "playing"  ]; then
      PLAY_STATE="$OUTPUT"
    else
      PLAY_STATE="$OUTPUT"
    fi
    OUTPUT="$PLAY_STATE $TITLE $TIME"
    if [ "${#OUTPUT}" -ge $MAX_TITLE_WIDTH  ]; then
      OUTPUT="$PLAY_STATE ${TITLE:0:$MAX_TITLE_WIDTH-1}… $TIME"
    fi
  else
    OUTPUT=''
  fi
fi
if [ -z "$OUTPUT" ]
then
  echo "$OUTPUT #[fg=#FFFFFF,bg=#000000]"
else
  echo "#[fg=#000000,nobold]#[fg=brightwhite,bg=#000000]  $OUTPUT #[fg=#FFFFFF,bg=#000000] "
fi
