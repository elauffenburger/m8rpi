set -o errexit

BUILD_AND_RUN_FBCP_ARGS=()

while [[ $# -gt 0 ]]; do
    case $1 in
        --no-build)
            BUILD_AND_RUN_FBCP_ARGS+='--no-build'
            shift
            ;;
        *)
            echo "unknown argument $1"
            exit 1
            ;;
    esac
done

. ./vars.sh
. ./init-gpio.sh

ORIGINAL_DIR=$(pwd)
onerr() {
    cd $ORIGINAL_DIR
}

# Handle any errors.
trap onerr ERR

# Move to fbcp-ili9341 dir.
pushd $M8_SCRIPT_DIR/../fbcp-ili9341

# Build and run bcp-ili9341.
. $M8_SCRIPT_DIR/build-and-run-fbcp.sh "${BUILD_AND_RUN_FBCP_ARGS[@]}"

# Go back to original dir.
popd

