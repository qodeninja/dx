#!/usr/bin/env bash
#===============================================================================
##   __
##  /\ \
##  \_\ \     __   __  __   __  _
##  /'_` \  /'__`\/\ \/\ \ /\ \/'\
## /\ \L\ \/\  __/\ \ \_/ |\/>  </
## \ \___,_\ \____\\ \___/  /\_/\_\
##  \/__,_ /\/____/ \/__/   \//\/_/
##------------------------------------------------------------------------------
#!/usr/bin/env bash
#-----------------------------><-----------------------------#
# author: qodeninja
# date: 11/05
# id: build-dx_sh
# autobuild: a46283
# desc: naive build of fx folder structure
#-----------------------------><-----------------------------#

  THIS_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" || exit; pwd -P)"

  if [[ $@ =~ "--test" ]]; then

    #echo "$THIS_DIR"

    source ../../inc/config.sh


    for slug in "${THIS_BUILD_0[@]}"; do
      if [ -n "$slug" ]; then
        this_path=$(part_press $slug)
        #echo -e "$path"
        this_path="${this_path//${THIS_MODE}//__${THIS_MODE}__}"
        if [[ $@ =~ "--mk" ]]; then
          mkdir -p "$this_path" ; 
        else
          stdi "Added path ${this_path}"
        fi
      fi
    done

    if [[ $@ =~ "--mk" ]]; then
      this_path=$(dev_up "$THIS_HOME")
      ltree $this_path
    fi


  fi
