save(){
    local sealed=$1
    local total=$2
    echo "Sealed: $sealed/$total on $(date +"%T %Y-%m-%d")" >> "$DIR/data/highscores.txt"
}
