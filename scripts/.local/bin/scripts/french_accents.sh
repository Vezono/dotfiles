#!/bin/sh

accents=$(cat <<EOF
    l, Polish L - ł

    ss, Estze - ß

    A, Grave - À
    A, Circumflex - Â
    A, Diaeresis - Ä

    C, Cedilla - Ç

    E, Acute - É
    E, Grave - È
    E, Circumflex - Ê
    E, Diaeresis - Ë

    I, Circumflex - Î
    I, Diaeresis - Ï

    O, Circumflex - Ô
    O, Diaeresis - Ö

    U, Grave - Ù
    U, Circumflex - Û
    U, Diaeresis - Ü

    Y, Diaeresis - Ÿ

    a, Grave - à
    a, Circumflex - â
    a, Diaeresis - ä

    c, Cedilla - ç

    oe, - œ

    e, Acute - é
    e, Grave - è
    e, Circumflex - ê
    e, Diaeresis - ë

    i, Circumflex - î
    i, Diaeresis - ï

    o, Circumflex - ô
    o, Diaeresis - ö

    u, Grave - ù
    u, Circumflex - û
    u, Diaeresis - ü

    y, Diaeresis - ÿ
EOF
)


FREQ_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/accent-freq.tsv"
touch "$FREQ_FILE"

sorted=$(echo "$accents" | grep -v '^\s*$' | awk -v freqfile="$FREQ_FILE" '
    BEGIN {
        while ((getline line < freqfile) > 0) {
            split(line, f, "\t")
            counts[f[2]] = f[1]
        }
    }
    {
        key = $NF
        printf "%05d\t%s\n", (key in counts ? counts[key] : 0), $0
    }
' | sort -srn | cut -f2-)

result=$(echo "$sorted" | fuzzel --no-sort -d --config=/home/vezono/.config/mango/fuzzel/fuzzel.ini  | awk '{print $NF}' | tr -d '\n')

[ -z "$result" ] && exit 0

if grep -qF "$result" "$FREQ_FILE"; then
    tmp=$(mktemp)
    awk -v key="$result" 'index($0, key) { print $1+1 "\t" key; next } { print }' "$FREQ_FILE" > "$tmp"
    mv "$tmp" "$FREQ_FILE"
else
    printf '1\t%s\n' "$result" >> "$FREQ_FILE"
fi

wl-copy "$result"
