  #====================================

    THIS_MODE="DXINSTALL"
    THIS_HOME="$HOME${THIS_MODE}"
    MY="my_"
    THIS_DX="$THIS_HOME"
    THIS_LOCAL="$THIS_HOME/local"
    THIS_DEV="$THIS_HOME/dev"
    THIS_DATA="$THIS_HOME/data"

    THIS_BUILD_0=( "dx_local" "dx_dev" "dx_data"  "local_${MY}etc_env" "local_${MY}etc_fx"  "local_${MY}lib_fx"  "local_${MY}bin" "local_${MY}keys" "dev_wksp"  "dev_repos_locker"    "dev_repos_archive"  "dev_hub_books" "dev_hub_registry"  "dev_hub_dump"  "data_cache" "data_pool" "data_logs" "data_dump" 
    )

  #====================================

    idots="\xE2\x80\xA6"
    stdi(){ printf "${col_blue}${@}${col_x}\n" 1>&2; }
    stdw(){ printf "${col_orange}${@}${col_x}\n" 1>&2; }
    stdp(){ printf "${col_green}${@}${col_x}\n" 1>&2; }
    trace(){ printf "${col_grey}${idots}${@}${col_x}\n" 1>&2; }

    ltree(){
      ls -R ${1:-} | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/';
    }

    _part_press(){
      local ukey=$(echo $1 | tr 'a-z' 'A-Z')
      local base="THIS_$ukey"
      local _head=$(eval echo \$$base)
      echo $_head
    }

    part_press() {
        local slug=$1 p1 p2
        p1="${slug%%_*}" 
        p2="${slug#*_}" 
        out=$(_part_press $p1)
        if [[ "$p2" == *_* ]]; then
          next_out="${p2//_//}"
          echo "$out/$next_out"
        else
          echo "$out/$p2"
        fi      
        if [[ "$out" == *_* ]]; then
          echo ""
        fi
    }

    dev_up(){
      echo "${1//${THIS_MODE}//__${THIS_MODE}__}"
    }


    make_list(){
      for slug in "${[@]}"; do
        if [ -n "$slug" ]; then
          path=$(part_press $slug)
          #echo -e "$path"
          echo -e "${path//${THIS_MODE}//__${THIS_MODE}__}"
        fi
      done
    }

