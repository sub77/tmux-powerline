# CURRENT DIR
get_tmux_cwd() {
    local env_name=$(tmux display -p "TMUXPWD_#D" | tr -d %)
    local env_val=$(tmux show-environment | grep --color=never "$env_name")

    if [[ ! $env_val =~ "unknown variable" ]]; then
        local tmux_pwd=$(echo "$env_val" | sed 's/^.*=//')
        echo "$tmux_pwd"
    fi
}
# WORKING DIR WITH ROM TOP LENGHT
get_repo_cwd() {
    local env_repo_name=$(/usr/bin/tmux display -p "TMUXPWD_#D" | tr -d %)
    local env_repo_val=$(/usr/bin/tmux show-environment | grep --color=never "$env_repo_name" )
    local env_repo_len=$(/usr/bin/tmux show-environment | grep -w --color=never "rom_dir_len" | sed 's/^.*=//' )

    if [[ ! $env_repo_val =~ "unknown variable" ]]; then
        local repo_pwd=$(echo "$env_repo_val" | sed 's/^.*=//' | cut -b 1-"$env_repo_len" )
        echo "$repo_pwd"
    fi
}

# WORKING DIR WITHOUT ROM TOP
get_repo_cwd2() {
    local env_name=$(/usr/bin/tmux display -p "TMUXPWD_#D" | tr -d %)
    local env_val=$(/usr/bin/tmux show-environment | grep --color=never "$env_name" )
    local env_repo_len=$(/usr/bin/tmux show-environment | grep -w --color=never "rom_dir_len" | sed 's/^.*=//' )
    env_repo_num=$((env_repo_len + 2))
    if [[ ! $env_val =~ "unknown variable" ]]; then
        local repo_pwd2=$(echo "$env_val" | sed 's/^.*=//' | cut -b "$env_repo_num"-99 )
        echo "$repo_pwd2"
    fi
}

# ROM TOP DIR
get_rom_cwd() {
    local env_rom_val=$(/usr/bin/tmux show-environment | grep -w --color=never "rom_dir_full")

    if [[ ! $env_rom_val =~ "unknown variable" ]]; then
        local rom_pwd=$(echo "$env_rom_val" | sed 's/^.*=//' )
        echo "$rom_pwd"
    fi
}

# ROM NAME
get_rom_name() {
    local env_romname_val=$(/usr/bin/tmux show-environment | grep -w --color=never "rom_dir" )

    if [[ ! $env_romname_val =~ "unknown variable" ]]; then
        local rom_name=$(echo "$env_romname_val" | sed 's/^.*=//' )
        echo "$rom_name"
    fi
}

# GET TARGET IF LUNCHED
get_target_product() {
    local env_tp_val=$(/usr/bin/tmux show-environment | grep -w --color=never "TARGET_PRODUCT" )

    if [[ ! $env_tp_val =~ "unknown variable" ]]; then
        local repo_tp=$(echo "$env_tp_val" | sed 's/^.*=//' | cut -d '_' -f 2 )
        echo "$repo_tp"
    fi
}
