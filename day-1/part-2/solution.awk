BEGIN {
    map["one"] = 1; map["two"] = 2; map["three"] = 3; map["four"] = 4; map["five"] = 5; map["six"] = 6; map["seven"] = 7; map["eight"] = 8; map["nine"] = 9
    sum = 0
}
{
    orig = $0
    first = ""
    last = ""
    while (match($0, /([1-9])|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)/)) {
        if (!first) {
            first = substr($0, RSTART, RLENGTH)
        }
        last = substr($0, RSTART, RLENGTH)
        # The main trick, which is that "twone" is 21, not 22 or 11
        $0 = substr($0, RSTART + 1)
    }
    if (first in map) {
        first = map[first]
    }
    if (last in map) {
        last = map[last]
    }
    num = first last
    sum = sum + num
    # print orig " " first " " last " " num " " sum
}
END { 
    print sum 
}
