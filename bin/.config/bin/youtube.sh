##!/usr/bin/env bash 
#selected=$(ytfzf -t --detach --thumbnail-quality=medium)
#if [[ -z $selected ]]; then
#    exit 0
#fi

#!/usr/bin/env bash
selected=$(echo $'songs\nyoutube\nanime\nmovies' |fzf --height=80% --layout=reverse  --border --margin=1 --padding=1)
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if [ "$selected" = "songs" ]; then
    tmux neww -n "Songs" zsh -c "ytfzf -t -m --detach --thumbnail-quality=medium $query "
elif [ "$selected" = "youtube" ]; then
    tmux neww -n "YouTube" zsh -c "ytfzf -t --detach --thumbnail-quality=medium $query"
elif [ "$selected" = "anime" ]; then
    tmux neww -n "Anime" zsh -c "ani-cli $query"
elif [ "$selected" = "movies" ]; then
    tmux neww -n "Movies" zsh -c "lobster -q 720 $query " 
fi


