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

# Function to print text in rainbow colors
print_rainbow() {
  local text="$1"
  local length=${#text}
  local color_index=0

  for (( i=0; i<length; i++ )); do
    echo -ne "${colors[color_index]}${text:i:1}"
    color_index=$(( (color_index + 1) % ${#colors[@]} ))
  done

  echo -ne "${reset}"
}

# Function to print a fancy heart
print_heart() {
  local heart=(
    "      *****       *****      "
    "   **********   **********   "
    " ************* ************* "
    "*****************************"
    " *************************** "
    "   ***********************   "
    "     *******************     "
    "       ***************       "
    "         ***********         "
    "           *******           "
    "             ***             "
    "              *              "
  )

  echo ""
  for (( i=0; i<${#heart[@]}; i++ )); do
    echo -e "${colors[i % ${#colors[@]}]}${heart[i]}"
    sleep 0.1
  done
  echo -ne "${reset}"
}

# Main loop to animate the text
animate_text() {
  local text="$1"
  local rotations=0
  local length=${#text}

  while (( rotations <= 3*length )); do
    print_rainbow "$text"
    if (( rotations < 3*length )); then
      echo -e "\033[1A" # Move cursor up
    fi
    sleep 0.1
    text="${text:1}${text:0:1}" # Rotate text
    (( rotations++ ))
  done

  # Print the heart at the end
  print_heart
}

# Check if text is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <text>"
  exit 1
fi

# Start animating the text
animate_text "$1"
