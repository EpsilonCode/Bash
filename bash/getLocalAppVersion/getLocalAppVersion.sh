function check_app_version() {
  if [ -z "$1" ]; then
    read -p "Please enter an application name: " APP_NAME
  else
    APP_NAME="$1"
  fi

  APP_PATH="/Applications/$APP_NAME.app"

  if [ -d "$APP_PATH" ]; then
    echo "$APP_NAME is installed."
    version=$(mdls -name kMDItemVersion "$APP_PATH" | sed 's/kMDItemVersion = "//;s/"$//')
    echo "$APP_NAME version: $version"
  else
    echo "$APP_NAME is not installed."
  fi
}
check_app_version