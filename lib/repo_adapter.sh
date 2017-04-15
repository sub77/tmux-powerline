# Get the current path in the segment.
get_repo_cwd() {
    local env_name=$(/usr/bin/tmux display -p "TMUXPWD_#D" | tr -d %)
    local env_val=$(/usr/bin/tmux show-environment | grep --color=never "$env_name" )
    local env_repo_len=$(/usr/bin/tmux show-environment | grep -w --color=never "rom_dir_len" | sed 's/^.*=//' )

    if [[ ! $env_val =~ "unknown variable" ]]; then
        local repo_pwd=$(echo "$env_val" | sed 's/^.*=//' | cut -b 1-"$env_repo_len" )
        echo "$repo_pwd"
    fi
}

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

get_rom_cwd() {
    local env_rom_val=$(/usr/bin/tmux show-environment | grep -w --color=never "rom_dir_full")

    if [[ ! $env_rom_val =~ "unknown variable" ]]; then
        local rom_pwd=$(echo "$env_rom_val" | sed 's/^.*=//' )
        echo "$rom_pwd"
    fi
}

get_rom_name() {
    local env_romname_val=$(/usr/bin/tmux show-environment | grep -w --color=never "rom_dir" )

    if [[ ! $env_romname_val =~ "unknown variable" ]]; then
        local rom_name=$(echo "$env_romname_val" | sed 's/^.*=//' )
        echo "$rom_name"
    fi
}

get_target_product() {
    local env_tp_val=$(/usr/bin/tmux show-environment | grep -w --color=never "TARGET_PRODUCT" )

    if [[ ! $env_tp_val =~ "unknown variable" ]]; then
        local repo_tp=$(echo "$env_tp_val" | sed 's/^.*=//' | cut -d '_' -f 2 )
        echo "$repo_tp"
    fi
}
