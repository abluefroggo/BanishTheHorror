draw_title(){
    clear
    echo -e "\033[32m================================================="
    echo -e "        THE GREEN GRIMOIRE - BINDING RITE"
    echo -e "=================================================\033[0m"

}
draw_hud(){
    local current_sanity=$1
    local max_sanity=$2
    local time_lim=$3
    local incantation=$4
    local total_chars=$5
    local errs=$6

    local sanity_bar=""

    tput cup 5 0

    echo " [THE VEIL THINS] Whispers echo from the dark..."
    echo -e " [CHANT] \033[35m$incantation\033[0m"
    for(( i = 1; i <= max_sanity; i++)); do
        if [ $i -le $current_sanity ]; then
            sanity_bar+="█"
        else
            sanity_bar+="-"
        fi
    done

    echo""
    tput el
    echo -en " [SANITY] \033[32m"
    if [ $current_sanity -le 1 ]; then
        echo -en "\033[31m"
    elif [ $current_sanity -le $(( max_sanity / 2 )) ]; then
        echo -en "\033[33m"
    fi
    echo -e "[${sanity_bar}]\033[0m (${time_lim}s REMAIN)"

    accuracy=100
    if [ $total_chars -gt 0 ]; then
        accuracy=$(( 100 - (errs * 100 / total_chars) ))
    fi

    echo -e "Accuracy: ${accuracy}% "
    tput el
    echo -ne "SPEAK INCANTATION > "
}
