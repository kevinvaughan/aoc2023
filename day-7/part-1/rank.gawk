{
    delete counts
    split($1, cards, "")
    sortorder=""
    for (i = 1; i <= length($1); i++) {
        card = cards[i]
        counts[card]++
        gsub(/[0-9]/, "0&", card); gsub(/A/, "14", card); gsub(/K/, "13", card); gsub(/Q/, "12", card); gsub(/J/, "11", card); gsub(/T/, "10", card)
        sortorder = sortorder card
    }

    # sort the values of counts and output them
    PROCINFO["sorted_in"] = "@val_num_desc"
    asort(counts)
    c = 0; for (i in counts) { c++; printf counts[i] }
    while (c < 5) { c++; printf "0" }
    print sortorder " " $0 
}