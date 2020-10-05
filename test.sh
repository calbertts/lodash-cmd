rm _
qjsc -o _ index.js
#qjsc -fno-map -fno-typedarray -fno-string-normalize -fno-proxy -fno-promise -fno-bigint -o _ index.js; strip _

PATH=$PATH:$PWD

echo "Array Methods"

echo -e "\nchunk:"
echo '["a", "b", "c", "d"]' | \
  _ chunk "2"

echo -e "\ncompact:"
echo '[0, 1, false, 2, "", 3]' | \
  _ compact

echo -e "\nconcat:"
echo '["a", ["b"], [["c"]]]' | \
  _ concat "1" "[8,9]"

echo -e "\ndifference:"
echo '[2, 1]' | \
  _ difference "[2, 3]"

echo -e "\ndifferenceBy:"
echo '[2.1, 1.2]' | \
  _ differenceBy "[2.3, 3.4]" "Math.floor"

echo '[{ "x": 2 }, { "x": 1 }]' | \
  _ differenceBy "[{ 'x': 1 }]" "'x'"

echo -e "\ndifferenceWith:"
_ differenceWith \
  "[{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]" \
  "[{ 'x': 1, 'y': 2 }]" \
  "_.isEqual"

echo -e "\ndrop:"
_ drop "[1, 2, 3]"
_ drop "[1, 2, 3]" "2"
_ drop "[1, 2, 3]" "5"
_ drop "[1, 2, 3]" "0"

echo -e "\ndropRight:"
_ dropRight "[1, 2, 3]"
_ dropRight "[1, 2, 3]" "2"
_ dropRight "[1, 2, 3]" "5"
_ dropRight "[1, 2, 3]" "0"

echo -e "\ndropRightWhile:"
_ dropRightWhile \
  "[ { 'user': 'barney', 'active': true }, { 'user': 'fred', 'active': false }, { 'user': 'pebbles', 'active': false } ]" \
  "(o) => !o.active"

_ dropRightWhile \
  "[ { 'user': 'barney', 'active': true }, { 'user': 'fred', 'active': false }, { 'user': 'pebbles', 'active': false } ]" \
  "({ user: 'pebbles', active: false })"

_ dropRightWhile \
  "[ { 'user': 'barney', 'active': true }, { 'user': 'fred', 'active': false }, { 'user': 'pebbles', 'active': false } ]" \
  "['active', false]"

_ dropRightWhile \
  "[ { 'user': 'barney', 'active': true }, { 'user': 'fred', 'active': false }, { 'user': 'pebbles', 'active': false } ]" \
  "'active'"

echo -e "\ndropRightWhile:"
_ dropWhile \
  "[ { 'user': 'barney', 'active': false }, { 'user': 'fred', 'active': false }, { 'user': 'pebbles', 'active': true } ]" \
  "(o) => !o.active"

_ dropWhile \
  "[ { 'user': 'barney', 'active': false }, { 'user': 'fred', 'active': false }, { 'user': 'pebbles', 'active': true } ]" \
  "({ 'user': 'barney', 'active': false })"

_ dropWhile \
  "[ { 'user': 'barney', 'active': false }, { 'user': 'fred', 'active': false }, { 'user': 'pebbles', 'active': true } ]" \
  "['active', false]"

_ dropWhile \
  "[ { 'user': 'barney', 'active': false }, { 'user': 'fred', 'active': false }, { 'user': 'pebbles', 'active': true } ]" \
  "'active'"

echo -e "\nfill:"
_ fill "[1, 2, 3]" "'a'"
_ fill "Array(3)" "2"
_ fill "[4, 6, 8, 10]" "'*'" "1" "3"

echo -e "\nfindIndex:"
_ findIndex \
  "[ { 'user': 'barney', 'active': false }, { 'user': 'fred', 'active': false }, { 'user': 'pebbles', 'active': true } ]" \
  "(o) => o.user == 'barney'"

_ findIndex \
  "[ { 'user': 'barney', 'active': false }, { 'user': 'fred', 'active': false }, { 'user': 'pebbles', 'active': true } ]" \
  "({ 'user': 'fred', 'active': false })"

_ findIndex \
  "[ { 'user': 'barney', 'active': false }, { 'user': 'fred', 'active': false }, { 'user': 'pebbles', 'active': true } ]" \
  "['active', false]"

_ findIndex \
  "[ { 'user': 'barney', 'active': false }, { 'user': 'fred', 'active': false }, { 'user': 'pebbles', 'active': true } ]" \
  "'active'"
