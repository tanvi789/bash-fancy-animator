#!/bin/bash

# Define the colors of the rainbow
colors=(
  '\033[31m' # Red
  '\033[33m' # Yellow
  '\033[32m' # Green
  '\033[36m' # Cyan
  '\033[34m' # Blue
  '\033[35m' # Magenta
)

# Reset color
reset='\033[0m'

# Function to print text in rainbow colors with options
print_rainbow() {
  local text="$1"
  local length=${#text}
  local color_index=0
  local style="$2"
  local no_color="$3"

  for ((i = 0; i < length; i++)); do
    case "$style" in
    bold)
      if [ "$no_color" != "no_color" ]; then
        echo -ne "${colors[color_index]}\033[1m${text:i:1}\033[0m"
      else
        echo -ne "\033[1m${text:i:1}\033[0m"
      fi
      ;;
    flash)
      if [ "$no_color" != "no_color" ]; then
        echo -ne "${colors[color_index]}\033[5m${text:i:1}\033[0m"
      else
        echo -ne "\033[5m${text:i:1}\033[0m"
      fi
      ;;
    karaoke)
      if [ "$no_color" != "no_color" ]; then
        # Karaoke style printing each character in a new line with rainbow color
        for ((i = 0; i < length; i++)); do
          # Print the character with the current color, in a new line
          echo -e "${colors[color_index]}\033[1m${text:i:1}${reset}"
          color_index=$(((color_index + 1) % ${#colors[@]}))
          # Small delay for the karaoke effect
          sleep 0.1
        done
      else
        # Print without color, just the character itself in a new line
        for ((i = 0; i < length; i++)); do
          echo -e "${text:i:1}"
          sleep 0.1
        done
      fi
      ;;
    *)
      if [ "$no_color" != "no_color" ]; then
        echo -ne "${colors[color_index]}${text:i:1}"
      else
        echo -ne "${text:i:1}"
      fi
      ;;
    esac
    color_index=$(((color_index + 1) % ${#colors[@]}))
  done

  echo -ne "${reset}"
}

# Function to print Zoopla Logo
print_zoopla() {
  local zoopla=(
    ",/////////,  *////////,   ./////////,  ,//*//////. .//,      ////////*//."
    "      ,//* ,//,      /// .//.      //* ,//     .//..//,    .//,      ///."
    " .////,,   *//       ,// *//       ,// ,///    *// .//,    *//       .//."
    " //.        ///,   .*//.  ///,   .*//, ,// ,///*.  .//,     *//,   .*///."
    ",/////////,   ,*///**       .*///*,    ,//         .///////   ,*///*  // "
  )

  echo ""
  echo ""
  for ((i = 0; i < ${#zoopla[@]}; i++)); do
    echo -e "\033[35m${zoopla[i]}"
    sleep 0.1
  done
  echo -ne "${reset}"
}

function cleanup() {
  tput cnorm
}

# Main loop to animate the text
animate_text() {
  local text="$1"
  local style="$2"
  local no_color="$3"
  local rotations=0
  local length=${#text}

  tput civis # Hide cursor
  echo ""

  if [ "$style" == "karaoke" ]; then
    print_rainbow "$text" "karaoke" "$no_color"
  else
    while ((rotations <= 3 * length)); do
      print_rainbow "$text" "$style" "$no_color"
      echo -e "\033[1A"
      sleep 0.1
      text="${text:1}${text:0:1}" # Rotate text
      ((rotations++))
    done
  fi

  tput cnorm # Show cursor
}

# Check if text, style, and no_color are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <text> <style> [no_color]"
  echo "Styles: normal, bold, flash, karaoke"
  echo "Use 'no_color' as the third argument to disable colors"
  exit 1
fi

# Start animating the text
animate_text "$1" "$2" "$3"

# Print the selected animation at the end
print_zoopla
