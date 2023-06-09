set -o errexit

M8_SCRIPT_DIR=$(readlink -f $(dirname $BASH_SOURCE))

# Note: all pins reference the BCM number of the pin,
# _not_ their GPIO label.
M8_GPIO_LEFT=16
M8_GPIO_UP=20
M8_GPIO_RIGHT=12
M8_GPIO_DOWN=21

M8_GPIO_SELECT=5
M8_GPIO_START=6
M8_GPIO_OPTION=13
M8_GPIO_EDIT=19

M8_GPIO_PINS=(
    M8_GPIO_LEFT
    M8_GPIO_UP
    M8_GPIO_RIGHT
    M8_GPIO_DOWN

    M8_GPIO_SELECT
    M8_GPIO_START
    M8_GPIO_OPTION
    M8_GPIO_EDIT
)
