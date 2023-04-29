
function dl_model {
  if [ ! -f "$1" -o ! -s "$1" ]; then
    wget -O "$1" "$2"

###
### If you don't have wget, curl is another option
###
#    curl "$2" >"$1"
#
  fi
}

dl_model 54-00167.step             https://tensility.com/3dmodels/54-00167.STEP
dl_model PQ2617BHA.stp             https://www.bourns.com/engineering/PQ2617/PQ2617BHA.stp
dl_model WE-PD_1260_STP_rev1.stp   https://www.we-online.de/katalog/download/784771010_Download_STP_WE-PDA-1260_rev1.stp
