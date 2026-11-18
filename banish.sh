#!/bin/bash
# Banishing The Horror: A Eldrich Speed Typing Game
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/lib/ui.sh"
source "$DIR/lib/mechanics.sh"
source "$DIR/lib/save.sh"

draw_title
echo "The candles flicker. The air tastes like copper."
echo "Chant the true names before the seal shatters and the horror is released"
sleep 2

chants=(
    "PHSDAFJAS_MASHDFJK"
    "CTHULHU-RYLEH-WAGWE"
    "TUE-SEOJFADS-RED-LOE"
    "Loadlondnquiry-MarixSateSenorBehead"
    "ParsonMasterPesterFesterPlague"
)
time_lim=30
max_sanity=5
current_sanity=$max_sanity
sealed=0
total=${#chants[@]}

for chant in "${chants[@]}"; do
    sanity_bar=""
    sigil=$((100 + RANDOM % 899))
    incantation="${chant}-${sigil}"
    tput cup 6 0
    echo""
    tput el
    echo " [THE VEIL THINS] Whispers echo from the dark..."
    echo -e " [CHANT] \033[35m$incantation\033[0m"
    for(( i = 1; i <= max_sanity; i++)); do
        if [ $i -le $current_sanity ]; then
            sanity_bar+="█"
        else
            sanity_bar+="-"
        fi
    done
    echo -en " [SANITY] \033[32m"
    if [ $current_sanity -le 1 ]; then
        echo -en "\033[31m"
    elif [ $current_sanity -le $(( max_sanity / 2 )) ]; then
        echo -en "\033[33m"
    fi
    echo -e "[${sanity_bar}]\033[0m (${time_lim}s REMAIN)"
    tput el
    echo -ne "SPEAK INCANTATION > "

    spoken=""
    i=0
    while [ $i  -lt ${#incantation} ]; do
        read -t "$time_lim" -rs -n 1 char
        status=$?
        if [ $status -ne 0 ]; then
            break
        fi
        if [ -z "$char" ] || [[ "$char" == $'\r' || "$char" == $'\n' ]]; then
            break
        elif [[ "$char" == $'\x7f' || "$char" == $'\x08' ]]; then
            if [ $i -gt 0 ]; then
                ((i--))
                spoken="${spoken%?}"
                echo -ne "\b \b"
            fi
            continue
        fi
        spoken="${spoken}${char}"
        expected="${incantation:i:1}"
        if [ "$char" == "$expected" ]; then
            echo -ne "\033[32m$char\033[0m"
        else
            echo -ne "\033[31m$char\033[0m"
        fi
        ((i++))
done
    status=$?
    if [ $status -ne 0 ]; then
        echo ""
        tput el
        echo -e "\n\n [SANITY] Your sanity decreases."
        ((current_sanity--))
        sleep 1
    elif [ "$spoken" == "$incantation" ]; then
        echo ""
        tput el
        echo " [BOUND] The shadows recoil! Seal $((sealed + 1)) holds..."
        ((sealed++))
        ((time_lim--))
        [ $time_lim -lt 4 ] && time_lim=4
    else
        echo ""
        tput el
        echo -e " [CURSED] You mispronounced the syllable! Your mind fractures."
        ((current_sanity--))
        sleep 1
    fi
    if [ $current_sanity -le 0 ]; then
        echo ""
        echo -e "\n\n [MADNESS] Your tounge freezes. The entity steps through..."
        echo "Seals bound: $sealed / $total"
        sleep 5
        exit 1
    fi

    sleep 1
done
echo ""
echo " [BANISHED] The circle flares white and goes cold."
echo " [SURVIVED] Dawn comes. The horror has been sealed."
sleep 5
echo ""
