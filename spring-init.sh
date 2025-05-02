#!/bin/bash

echo "🔧 Spring Boot Project Initializer"

# Ask for user inputs
read -p "📁 Project Name: " project_name
read -p "📦 Group ID (e.g. com.example): " group_id
read -p "🎯 Artifact ID: " artifact_id

# Fetch dependencies data from Spring Initializr API
echo "🌍 Fetching dependencies from Spring Initializr..."
dependencies_json=$(curl -s https://start.spring.io/metadata/client)

# Prepare dependencies data with tree view
dependencies=$(echo "$dependencies_json" | jq -r '
  .dependencies.values[] as $category |
  ("▌ " + $category.name),
  ($category.values[] | 
    "  ├── " + .name + "\u001f" + .id + "\u001f" + .description + "\u001f" + $category.name
  )
')

# Display dependencies for selection
echo "🧩 Choose your dependencies (use TAB or arrows + ENTER to select multiple):"
selected=$(echo "$dependencies" | fzf --multi \
  --prompt="Search Dependencies: " \
  --layout=reverse \
  --preview '
    item={}
    if [[ "$item" == "▌ "* ]]; then
      echo ""
    elif [[ "$item" == *"├──"* ]]; then
      IFS=$'"'"'\u001f'"'"' read -r description <<< "${item#*├── }"
      echo -e "🧾 Description:\n$description\n\n"
    fi' \
  --preview-window=right:50%:wrap \
  --height=20 \
  --border \
  --ansi \
  --header="Categories (purple) are not selectable" \
  --color="header:bright-magenta" \
  --delimiter=$'\u001f' \
  --with-nth=1 \
  --bind 'tab:toggle+down,btab:toggle+up,shift-tab:toggle+up' \
  | grep "├──" | awk -F$'\u001f' '{print $2}' | paste -sd "," -)

# Join selected IDs
selected_dependencies=$(echo "$selected" | paste -sd "," -)

# Ask for additional project settings
read -p "⚙️ Build Tool (maven/gradle) [maven]: " build_tool
read -p "☕ Java Version (8/11/17/21) [17]: " java_version

# Set default values if user doesn't provide input
build_tool=${build_tool:-maven}
java_version=${java_version:-17}

echo ""
echo "🚀 Generating project with:"
echo " - Project Name:     $project_name"
echo " - Group ID:         $group_id"
echo " - Artifact ID:      $artifact_id"
echo " - Dependencies:     $selected_dependencies"
echo " - Build Tool:       $build_tool"
echo " - Java Version:     $java_version"
echo ""

# Run the Spring Initializr command to generate the project
spring init \
  --name="$project_name" \
  --groupId="$group_id" \
  --artifactId="$artifact_id" \
  --dependencies="$selected_dependencies" \
  --build="$build_tool" \
  --java-version="$java_version" \
  "$project_name"

echo "✅ Done! Project created in folder: $project_name"