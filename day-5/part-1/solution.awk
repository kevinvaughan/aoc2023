{
    if (NR == 1) {
        delete source_numbers
        delete numbers
        for (i = 2; i <= NF; i++) {
            source_numbers[i - 2] = $i
            numbers[i - 2] = $i
        }
        next
    }

    if ($0 ~ /^\s*$/) {
        printf "Unmapped numbers: "; for (i in numbers) printf "[%s]%s ", i, numbers[i]; print ""
        printf "Mapped numbers: "; for (i in mapped_numbers) printf "[%s]%s ", i, mapped_numbers[i]; print
        for (i in mapped_numbers) numbers[i] = mapped_numbers[i]
        delete mapped_numbers
        printf "Numbers: "; for (i in numbers) printf "[%s]%s ", i, numbers[i]; print "\n"
        next
    }

    if (NF == 3 && $1 ~ /^[0-9]+$/ && $2 ~ /^[0-9]+$/ && $3 ~ /^[0-9]+$/) {
        for (i in numbers) {
            if (numbers[i] >= $2 && numbers[i] <= $2 + $3) {
                mapped_numbers[i] = $1 + (numbers[i] - $2)
                print numbers[i] " mapped to " mapped_numbers[i] " (Range found at line " NR ")"
                delete numbers[i]
            }
        }
    }
}
END {
    for (i in mapped_numbers) numbers[i] = mapped_numbers[i]
    print "Final Seeds:"
    for (i = 0; i < length(numbers); i++) print i ") " source_numbers[i] " -> " numbers[i]

    # find minimum value in numbers
    min = numbers[0]
    for (i = 1; i < length(numbers); i++) if (numbers[i] < min) min = numbers[i]
    print "Minimum value: " min

}