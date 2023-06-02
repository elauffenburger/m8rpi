set -o errexit

FRAMERATE=90
USE_DMA=ON
CLOCK_DIVISOR=24
STATS_LEVEL=0
NO_BUILD=0

while [[ $# -gt 0 ]]; do
    case $1 in
        --no-build)
            NO_BUILD=1
            shift
            ;;
        *)
            echo "unknown arg $1"
            exit 1
            ;;
    esac
done


if [[ $NO_BUILD -ne 1 ]]; then
# Use the correct framerate.
    sed <ili9341.h "s/\(#define ILI9341_UPDATE_FRAMERATE\) \(.*\)\$/\1 ILI9341_FRAMERATE_${FRAMERATE}_HZ/" > ili9341.h.tmp
    sudo mv ili9341.h.tmp ili9341.h

    cmake \
        -DILI9341=ON \
        -DILI9340=OFF \
        -DADAFRUIT_ILI9341_PITFT=OFF \
        -DGPIO_TFT_DATA_CONTROL=24 \
        -DGPIO_TFT_RESET_PIN=25 \
        -DDISPLAY_CROPPED_INSTEAD_OF_SCALING=ON \
        -DSPI_BUS_CLOCK_DIVISOR=$CLOCK_DIVISOR \
        -DSTATISTICS=$STATS_LEVEL \
        -DUSE_DMA_TRANSFERS=$USE_DMA \
        -DDISPLAY_ROTATE_180_DEGREES=ON

    make -j
fi

sudo ./fbcp-ili9341
