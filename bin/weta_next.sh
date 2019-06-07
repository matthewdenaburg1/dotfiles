#!/usr/bin/env bash

# global variables {{{1
PROGRAM_NAME="$(basename $0)"

URL1='https://weta.org/fm/'
URL2='https://weta.org/fm/playlists'
#}}}

# BEGIN functions {{{1
# bold() {{{2
bold() {
    # prints the 1st argument in bold
    printf '[1m%s[0m' "${1}"
    return 0
} #}}}

# usage() {{{2
usage() {
    local h="$(bold -h)"
    local a="$(bold -a)"
    local p="$(bold -p)"
    local n="$(bold -n)"

    # cat <<EOF {{{
    cat <<EOF
Usage:
    $ ${PROGRAM_NAME} [$h] [$a] [$p NUM] [$n NUM]

Options:
    $h		print help
    $a		display all songs for the day
    $p NUM	display the previous NUM songs.
    $n NUM	display the next NUM songs.
EOF
    #}}}
} #}}}

# getCurrentSong() {{{2
getCurrentSong() {
    echo -n
} #}}}
#}}}

previous=1
next=3

while getopts ':hp:n:' opt ; do
    case ${opt} in
	p)  # previous NUM songs
	    previous="$(echo ${OPTARG} | tr --complement --delete '[0-9]')"
	    if test -z "${previous}" ; then
		echo "Invalid argument provided to -${OPTARG}." >&2
		usage && exit 1
	    fi
	    ;;
	n)  # next NUM songs
	    next="$(echo ${OPTARG} | tr --complement --delete '[0-9]')"
	    if test -z "${next}" ; then
		echo "Invalid argument provided to -${OPTARG}." >&2
		usage && exit 1
	    fi
	    ;;
	a)
	    echo "-${OPTARG} not implemented yet." >&2
	    exit 2
	    ;;
	h)
	    usage && exit 0
	    ;;
	\?)
	    echo "Invalid option: -${OPTARG} is not valid." >&2
	    usage && exit 1
	    ;;
	:)
	    echo "Invalid option: -${OPTARG} requires an argument" >&2
	    usage && exit 1
	    ;;
    esac
done

# (songs previous the current one) + (current song) + (songs next the current one)
number=$((previous + 1 + next))


# download the page
current_id="$(curl --no-keepalive --no-sessionid --silent "${URL1}" | \
    sed -n -E -e 's/<div class="np_links">.*<a href="\/fm\/playlists#([0-9]{6})".*/\1/p')"

id_save="$(jot -s '|' ${number} $((current_id - previous)))"

# download the page
curl --no-keepalive --no-sessionid --silent "${URL2}" | \
    # convert entities
    /usr/local/bin/hxunent | \
    # remove leading spaces
    sed -E 's/^[[:space:]]*//' | \
    # keep only songs
    sed -n -E '/^<div *id="('"${id_save}"')"/,/<div class="field-playlist-linktext">/p' | \
    # keep the id for the current song so we can mark that it's currently playing
    sed -E 's/^<div *id="('"${current_id}"')".*$/\1/' | \
    # remove the rest of the html tags
    sed -E 's/<[^>]*>//g' | \
    tr -d "\r" | \
    # remove blank lines
    sed -E '/^$/d' | \
    # mark the current song with a '*' character
    sed -E "/${current_id}/ { s/${current_id}/*/; N; s/\n// }" | \
    # start at current song, and print
    sed -n -E '/(1[012]|[1-9]):([0-5][0-9]) [ap]m/,+2p' |\
    # join into 3 columns
    paste -d "\t" - - - | \
    column -t -s $'\t'

