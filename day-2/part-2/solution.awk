BEGIN {
}
{
    red_max = green_max = blue_max = 0
    for (i = 1; i <= NF; i++) {
        if ($i ~ /red/ && ($(i-1) > red_max)) {
            red_max = $(i-1)
        } else if ($i ~ /green/ && ($(i-1) > green_max)) {
            green_max = $(i-1)
        } else if ($i ~ /blue/ && ($(i-1) > blue_max)) {
            blue_max = $(i-1)
        }
    }
    # print red_max, green_max, blue_max, red_max * green_max * blue_max
    power_sum += red_max * green_max * blue_max
}
END {
    print power_sum
}