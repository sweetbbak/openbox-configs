#!/bin/bash

function ffmpegger  {
INPUT=$(gum filter --placeholder "Input file")
FRAMERATE=$(gum input --prompt "Frame rate: " --placeholder "Frame Rate" --prompt.foreground 240 --value "50")
WIDTH=$(gum input --prompt "Width: " --placeholder "Width" --prompt.foreground 240 --value "1200")
MAXCOLORS=$(gum input --prompt "Max Colors: " --placeholder "Max Colors" --prompt.foreground 240 --value "256")

BASENAME=$(basename "$INPUT")
BASENAME="${BASENAME%%.*}"

gum spin --title "Converting to GIF" -- ffmpeg -i "$INPUT" -vf "fps=$FRAMERATE,scale=$WIDTH:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=$MAXCOLORS[p];[s1][p]paletteuse" "$BASENAME.gif"
  
}

echo -n "enter a number: \n "
#read VAR
XYZ=$(gum choose 1 2 3 4 )

if [[ $XYZ = 1 ]]
then
  echo -n "var is 1."
  ffmpegger
elif [[ $XYZ = 2 ]]
then
  echo -n "var is 2"

elif [[ $XYZ = 3 ]]
then
  echo -n "var is 3"

elif [[ $XYZ = 4 ]]
then
  echo -n "var is 4" "$XYZ"
fi