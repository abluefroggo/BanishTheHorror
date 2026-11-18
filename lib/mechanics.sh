# lib/mechanics.sh
run_round(){
    local incantation=$1
    local time_lim=$2
    timed_out=0
    spoken=""
    i=0
    while [ $i  -lt ${#incantation} ]; do
        read -t "$time_lim" -rs -n 1 char
        status=$?
        if [ $status -ne 0 ]; then
            timed_out=1
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

    read -t 1 -n 1000 -rs 2>/dev/null || true

}
