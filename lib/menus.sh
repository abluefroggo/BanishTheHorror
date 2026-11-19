draw_menu(){
    read -rp "Enter your name > " name
    echo -e "Choose a difficulty: "
    echo -e "[1] \033[32mApprentice\033[0m: 7 sanity, 45s time"
    echo -e "[2] \033[33mCultist\033[0m: 5 sanity, 30s time"
    echo -e "[3] \033[31mMadman\033[0m: 3 sanity, 15s time"
    read -rp "> " choice
    if [ $choice -eq 1 ]; then
        time_lim=45
        max_sanity=7
        difficulty="Apprentice"
    elif [ $choice -eq 2 ]; then
        time_lim=30
        max_sanity=5
        difficulty="Cultist"
    elif [ $choice -eq 3 ]; then
        time_lim=15
        max_sanity=3
        difficult="Madman"
    else
        echo "Invalid choice. Defaulting to Cultist."
        time_lim=45
        max_sanity=7
        difficult="Cultist"
    fi
}
