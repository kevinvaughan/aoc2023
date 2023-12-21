BEGIN {
    RS = ","
    for(i = 0; i < 256; i++) {
        ord[sprintf("%c", i)] = i
    }
}
{
    current_value = 0;
    for (j = 1; j <= length($0); j++) {
        current_value = (current_value + ord[substr($0, j, 1)]) * 17 % 256;
    }
    sum += current_value;
}
END {
    print sum
}