#!/bin/bash
# Banishing The Horror: An Eldrich Speed Typing Game
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
errors=0
total_characters=0

for chant in "${chants[@]}"; do

    sigil=$((100 + RANDOM % 899))
    incantation="${chant}-${sigil}"

    draw_hud "$current_sanity" "$max_sanity" "$time_lim" "$incantation" "$total_characters" "$errors"

    run_round "$incantation" "$time_lim"

    if [[ $timed_out -eq 1 || $accuracy -le 30 ]]; then
        echo ""
        tput el
        echo -e "\n\n [SANITY] You stumbled over your words. Your sanity decreases."
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
save "$sealed" "$total"
sleep 10
echo ""
