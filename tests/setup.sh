tests:clone shdoc .

assert() {
    tests:ensure ./shdoc < input
    tests:assert-no-diff expected stdout
}
