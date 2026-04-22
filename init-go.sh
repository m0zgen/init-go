#!/bin/bash
# Author: Yevgeniy Goncharov aka xck, http://sys-adm.in
# Create empty Go project with `main.go` file.

# -------------------------------------------------------------------------------------------\

# Check if the project path is provided as an argument
if [ -z "$1" ]; then
    echo "Error: No project path provided."
    echo "Usage: $0 <project_path>"
    exit 1
fi

TARGET_DIR=$1
# Extract project name from the target directory path
PROJECT_NAME=$(basename "$TARGET_DIR")

mkdir -p "$TARGET_DIR"

# Change to the created directory
cd "$TARGET_DIR" || exit

# Init Go module
# If go.mod file already exists, skip
if [ ! -f "go.mod" ]; then
    go mod init "$PROJECT_NAME"
else
    echo "go.mod file already exists, skipping initialization."
fi

# Create main.go
if [ ! -f "main.go" ]; then
    cat <<EOF > main.go
package main

import "fmt"

func main() {
  fmt.Println("Hello, Go project '$PROJECT_NAME' is ready!")
}
EOF
    echo "main.go file successfully created."
else
    echo "main.go file already exists."
fi

# Final message
echo "-----------------------------------"
echo "Project is ready at: $TARGET_DIR"
echo "To run the project, execute:"
echo "  cd $TARGET_DIR"
echo "  go run main.go"