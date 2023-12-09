{
    delete counts
    split($1, cards, "")
    sortorder=""
    j_count = 0
    for (i = 1; i <= length($1); i++) {
        card = cards[i]
        if (card == "J") {
            j_count++
        } else {
            counts[card]++
        }
        gsub(/[0-9]/, "0&", card); gsub(/A/, "14", card); gsub(/K/, "13", card); gsub(/Q/, "12", card); gsub(/J/, "01", card); gsub(/T/, "10", card)
        sortorder = sortorder card
    }
    if (j_count == 5) {
        j_count = 0
        counts["J"] = 5
    }

    # sort the values of counts and output them
    PROCINFO["sorted_in"] = "@val_num_desc"
    asort(counts)
    c = 0; for (i in counts) { c++; printf counts[i] + j_count; j_count = 0; }
    while (c < 5) { c++; printf "0" }
    print sortorder " " $0 
}