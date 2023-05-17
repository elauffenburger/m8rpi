set -o errexit

. ./vars.sh

ORIGINAL_DIR=pwd
onerr() {
    cd $ORIGINAL_DIR
}

# Handle any errors.
trap onerr ERR

# Move to fbcp-ili9341 dir.
pushd $M8_SCRIPT_DIR/../fbcp-ili9341

# Build and run bcp-ili9341.
. $M8_SCRIPT_DIR/build-and-run-fbcp.sh

# Go back to original dir.
popd

