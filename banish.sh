#!/bin/bash
# Banishing The Horror: A Eldrich Speed Typing Game

clear
echo "================================================="
echo "        THE GREEN GRIMOIRE - BINDING RITE"
echo "================================================="
echo "The candles flicker. The air tastes like copper."
echo "Chant the true names before the seal shatters and the horror is released"
sleep 2
chants=(
    "PHSDAFJAS_MASHDFJK"
    "CTHULHU-RYLEH-WAGWE"
    "TUE-SEOJFADS-RED-LOE"

)
time_lim=30
sealed=0
total=${#chants[@]}
for chant in "${chants[@]}"; do
    sigil=$((100 + RANDOM % 899))
    incantation="${chant}-${sigil}"
    echo""
    echo " [THE VEIL THINS] Whispers echo from the dark..."
    echo " [CHANT] $incantation"
    echo " [SANITY] ${time_lim} SECONDS REMAIN"
    echo -n "SPEAK INCANTATION > "
    read -t "$time_lim" spoken
    status=$?
    if [ $status -ne 0 ]; then
        echo -e "\n\n[MADNESS] Your tounge freezes. The entity steps through..."
        echo "Seals bound: $sealed / $total"
        exit 1
    fi
    if [ "$spoken" == "$incantation" ]; then
        echo "[BOUND] The shadows recoil! Seal $((sealed + 1)) holds..."
        ((sealed++))
        ((time_lim--))
        [ $time_lim -lt 4 ] && time_lim=4
    else
        echo -e "\n[CURSED] You mispronounced the syllable! Your mind fractures."
        echo "Seals bound: $sealed / $total"
        sleep 5
        exit 1
    fi

    sleep 1
done

echo ""
echo " [BANISHED] The circle flares white and goes cold."
echo " [SURVIVED] Dawn comes. The horror has been sealed."
