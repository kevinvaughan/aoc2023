BEGIN {
    cards_played = 0
}
{
    card = 0 + substr($2, 1, length($2) - 1)
    
    pile[card] = multiples = pile[card] ? pile[card] : 1
    
    print card " " multiples
    cards_played += multiples

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
            bonus_card = 0 + card + ++m
            pile[bonus_card] = (pile[bonus_card] ? pile[bonus_card] : 1) + multiples
            # print card " wins " bonus_card ", now with " pile[bonus_card] " copies"
        }
    }
}
END {
    print "Total cards played: " cards_played
}
