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
    fg="colour160"
    repo_tp=$(get_target_product)
    if [ -n "$repo_tp" ]; then
        echo $repo_tp
    else
        echo "#[fg=${fg}]xxx"
    fi

    return 0
}
