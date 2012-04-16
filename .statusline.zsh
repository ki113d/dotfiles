#! /usr/local/bin/zsh

FONT='-artwiz-cure-medium-r-normal--11-110-75-75-p-90-iso8859-1'

getDate() {
    d=$(date +"%a")    
    dom=$(date +"%e")
    m=$(date +"%b")
    y=$(date +"%Y")
    t=$(date +"%l:%M")
    s=$(date +"%p")
    case $dom in
        1[1-3]) dom+="th";;
        *1)     dom+="st";;
        *2)     dom+="nd";;
        *3)     dom+="rd";;
        *)      dom+="th";;
    esac
    echo -ne "\x02$d \x01the \x02$dom \x01of \x02$m $y \x01at \x02$t $s"
}

getMpd() {
    if [ $(mpc | grep playing | awk '{ print $2 }' | wc -l) != 1 ]; then
        echo -ne "\x05 \x02Music Paused\x05"
    else
        if [ $(mpc | grep playing | awk '{ print $2 }' | sed 's/.\(.*\)/\1/' | sed 's/\(.*\)../\1/') = 100 ]; then
            title=$(mpc | head -n 1)
            echo -ne "\x05 \x02$(echo $title | cut -c 1-60)"
            if [ ${#title} -gt 60 ]; then echo -ne "\x05..."; fi
            echo -ne "\x07 [\x05$(mpc | grep playing | awk '{ print $3 }')\x07]\x05"
        else
            title=$(mpc | head -n 1)
            echo -ne "\x05 \x02$(echo $title | cut -c 1-60)"
            if [ ${#title} -gt 60 ]; then echo -ne "\x07..."; fi
            echo -ne "\x07 [\x05$(mpc | grep playing | awk '{ print $3 }')\x07]\x05"
        fi
    fi
}

getTemp() {
    temp=$(curl -s "http://www.google.com/ig/api?weather=Giessen" | sed 's|.*<temp_c data="\([^"]*\)"/>.*|\1|')
    if [ ${#temp} -gt 3 ]; then
        temp="N/A"
    elif [ ${#temp} -lt 1 ]; then
        temp="N/A"
    else
        temp=$temp"\x01 C"
    fi
    echo -ne " \x02$temp\x05"
}


if [ $# -eq 0 ]; then
    echo "$(getMpd)   $(getTemp)   $(getDate)"
elif [ $1 = "killWeechat" ]; then
    tmux kill-session -t Weechat &> /dev/null
    echo "$(getMpd)   $(getTemp)   $(getDate)"
else
    play -v 3 .sounds/buzz.wav &> /dev/null &
    echo $1
fi

