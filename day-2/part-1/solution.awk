BEGIN {
    red_threshold=12
    green_threshold=13
    blue_threshold=14
    
    possible = 0
    possible_sum = 0
}
{
    safe = 1
    for (i = 1; i <= NF; i++) {
        if ($i ~ /red/ && ($(i-1) > red_threshold)) {
            safe = 0
            # print "Line " NR ": " $i " exceeds threshold with count " $(i-1);
        } else if ($i ~ /green/ && ($(i-1) > green_threshold)) {
            safe = 0
            # print "Line " NR ": " $i " exceeds thresdhold with count " $(i-1);
        } else if ($i ~ /blue/ && ($(i-1) > blue_threshold)) {
            safe = 0
            # print "Line " NR ": " $i " exceeds threshold with count " $(i-1);
        }
    }
    if (safe == 1) {
        possible_sum += $2
    }
    possible += safe
    
}
END {
    print possible " Games are possible, with a total of " possible_sum " points."
}