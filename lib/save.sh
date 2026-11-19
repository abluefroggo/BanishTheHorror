save(){
    local sealed=$1
    local total=$2
    echo "Name: $name Sealed: $sealed/$total on $(date +"%T %Y-%m-%d") Difficulty: $difficulty" >> "$DIR/data/highscores.txt"
}
