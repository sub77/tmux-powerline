# Indicator of pressing TMUX prefix, copy and insert modes.

# Source lib to get the function get_tmux_pwd
#source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"
source "${TMUX_POWERLINE_DIR_LIB}/repo_adapter.sh"

TMUX_POWERLINE_SEG_PWD_MAX_LEN_DEFAULT="40"

generate_segmentrc() {
    read -d '' rccontents  << EORC
# Maximum length of output.
export TMUX_POWERLINE_SEG_PWD_MAX_LEN="${TMUX_POWERLINE_SEG_PWD_MAX_LEN_DEFAULT}"
EORC
    echo "$rccontents"
}

__process_settings() {
    if [ -z "$TMUX_POWERLINE_SEG_PWD_MAX_LEN" ]; then
        export TMUX_POWERLINE_SEG_PWD_MAX_LEN="${TMUX_POWERLINE_SEG_PWD_MAX_LEN_DEFAULT}"
    fi
}

run_segment() {
    __process_settings
    # Truncate from the left.
    rcwd2=$(get_repo_cwd2)
    rcwd=$(get_repo_cwd)
    trunc_symbol="···"
    dir=${rcwd##*/}
    local max_len="$TMUX_POWERLINE_SEG_PWD_MAX_LEN"
    max_len=$(( ( max_len < ${#dir} ) ? ${#dir} : max_len ))
    trcwd=${rcwd/#$HOME/\~}
    pwdoffset=$(( ${#trcwd} - max_len ))
    if [ ${pwdoffset} -gt "0" ]; then
        trcwd=${ttcwd:$pwdoffset:$max_len}
        trcwd=${trunc_symbol}/${trcwd#*/}
    fi
    romcwd=$(get_rom_cwd)
    if [ ! "$romcwd" == $trcwd ]; then
        fg="colour160"
        echo $trcwd
    else
        echo $rcwd2
    fi

    return 0
}
