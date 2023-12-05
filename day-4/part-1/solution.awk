BEGIN {
    pile = 0
}
{
    card = $2
    numbers = ""
    for (i = 3; i <= NF; i++) {
        if ($i == "|") {
            split(numbers, win_tmp)
            numbers = ""
            break
        }
        numbers = numbers " " $i
    }
    delete winning_numbers
    for (j in win_tmp) winning_numbers[win_tmp[j]] = 1;

    m = 0
    for (; i <= NF; i++) {
        if ($i in winning_numbers) {
            m = (m == 0) ? 1 : m * 2
        }
    }
    pile += m
    
    print pile " " m " " $0
}
END {
    print pile
}