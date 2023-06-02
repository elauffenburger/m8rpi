set -o errexit

. ./vars.sh

# Pull pins down to start.
for pin in "${M8_GPIO_PINS[@]}"; do
    echo "setting pin $pin (${!pin})"
    gpio -g mode $pin down
done

