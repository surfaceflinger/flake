set -euxo pipefail

# Confirm user input
confirm() {
  local prompt="$1"
  local answer
  read -rp "$prompt [y/n]: " answer
  [[ $answer == "y" ]]
}

# Add location
add_location() {
  local location="$1"
  local replace="${2:-false}"
  local schemas=("org/gnome/shell/weather" "org/gnome/Weather")
  for schema in "${schemas[@]}"; do
local locations
locations=$(dconf read "/$schema/locations")
if [[ $locations == "@av []" ]]; then
  dconf write "/$schema/locations" "[$location]"
elif $replace; then
  dconf write "/$schema/locations" "[$location]"
else
  dconf write "/$schema/locations" "${locations/%]/, $location]}"
fi
  done
}

# Degrees to radians (GNOME requires that lloooooooooool and imagine they convert it back later before querying weathjer api LOL
deg_to_rad() {
  local deg="$1"
  echo "$deg * 4 * a(1) / 180" | bc -l
}

query="$*"
if [[ -z $query ]]; then
  read -rp "Type the name of the location you want to add to GNOME Weather: " query
fi
query="${query// /+}"
request=$(curl "https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1" -s)

if [[ $request == "[]" ]]; then
  echo "No locations found, consider removing some search terms"
  exit 1
fi

display_name=$(echo "$request" | jq -r '.[0].display_name')
if ! confirm "If this is not the location you wanted, consider adding search terms. Are you sure you want to add $display_name?"; then
  echo "Not adding location"
  exit 1
else
  echo "Adding location"
fi

name=$(echo "$request" | jq -r '.[0].name')
lat=$(deg_to_rad "$(echo "$request" | jq -r '.[0].lat')")
lon=$(deg_to_rad "$(echo "$request" | jq -r '.[0].lon')")

location="<(uint32 2, <('$name', '', false, [($lat, $lon)], @a(dd) [])>)>"
replace=$(confirm "Would you like to replace existing locations? This will remove previous locations" && echo true || echo false)
add_location "$location" "$replace"
