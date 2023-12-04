{
    gsub(/[^0-9]/, ""); 
    num = substr($0, 1, 1) substr($0, length($0), 1); 
    sum += num 
    # print $0 " " num " " sum
} 
END { 
    print sum 
}