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

echo "$accents" | wofi -S dmenu | awk -F '- ' '{print $2}' | tr -d '\n' | wl-copy
