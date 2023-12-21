BEGIN {
    RS = ",";
    for (i = 0; i < 256; i++) {
        ord[sprintf("%c", i)] = i;
        lensCount[i] = 0;
    }
}
{
    current = 0;
    label = "";
    for (j = 1; j <= length($0); j++) {
        char = substr($0, j, 1);
        if (char == "-" || char == "=") {
            box = current % 256;
            operation = char;
            focalLength = (char == "=") ? substr($0, j + 1) : 0;
            break;
        }
        label = label char;
        current = (current + ord[char]) * 17 % 256;
    }
    if (operation == "-") {
        for (i = 1; i <= lensCount[box]; i++) {
            lensKey = box "_" i;
            split(lenses[lensKey], parts, "|");
            if (parts[1] == label) {
                for (j = i; j < lensCount[box]; j++) {
                    lenses[box "_" j] = lenses[box "_" (j + 1)];
                }
                delete lenses[box "_" lensCount[box]];
                lensCount[box]--;
                break;
            }
        }
    } else {
        lensKey = box "_" (++lensCount[box]);
        lenses[lensKey] = label "|" focalLength;
        for (i = lensCount[box] - 1; i >= 1; i--) {
            split(lenses[box "_" i], parts, "|");
            if (label != parts[1]) {
                continue;
            }
            lenses[lensKey] = lenses[box "_" i];
            lenses[box "_" i] = label "|" focalLength;
            lensCount[box]--;
            break;
        }
    }
}
END {
    totalFocus = 0;
    for (box = 0; box < 256; box++) {
        for (i = 1; i <= lensCount[box]; i++) {
            lensKey = box "_" i;
            split(lenses[lensKey], parts, "|");
            totalFocus += (box + 1) * i * parts[2];
        }
    }
    print totalFocus;
}