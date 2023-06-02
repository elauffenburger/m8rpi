set -o errexit -o pipefail

. ./vars.sh

# If true, we'll skip installing system deps.
NO_INSTALL_DEPS=0

# Set up our M8 Client GPIO config.
M8_GPIO_CFG="poll_rate_ms=75;left=$M8_GPIO_LEFT;up=$M8_GPIO_UP;right=$M8_GPIO_RIGHT;down=$M8_GPIO_DOWN;select=$M8_GPIO_SELECT;start=$M8_GPIO_START;option=$M8_GPIO_OPTION;edit=$M8_GPIO_EDIT"

while [[ $# -gt 0 ]]; do
    case $1 in
        --no-install-deps)
            NO_INSTALL_DEPS=1
            shift
            ;;
        *)
            echo "unknown argument $1"
            exit 1
            ;;
    esac
done

ORIGINAL_DIR=$(pwd)
onerr() {
    cd $ORIGINAL_DIR
}

# Call error handler on any errors.
trap onerr ERR

# Check if we need to install deps.
if [[ $NO_INSTALL_DEPS -ne 1  ]]; then
    . ./install-deps.sh
fi

# Move to m8client dir.
pushd $M8_SCRIPT_DIR/../m8client

# Run m8client with config.
M8_DEV=/dev/ttyACM0 M8_USE_GPIO=$M8_GPIO_CFG ./bin/run.sh

# Go back to original dir.
popd
