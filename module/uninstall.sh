# Don't modify anything after this
[[ -f "$INFO" ]] && {
  while read LINE; do
    if [[ "$(echo -n "$LINE" | tail -c 1)" == "~" ]]; then
      continue
    elif [[ -f "$LINE~" ]]; then
      mv -f "$LINE~" "$LINE"
    else
      rm -f "$LINE"
      while true; do
        LINE=$(dirname $LINE)
        [[ "$(ls -A $LINE 2>/dev/null)" ]] && break 1 || rm -rf "$LINE"
      done
    fi
  done < $INFO
  rm -f "$INFO"
}

# Delate files 
MODDIR=${0%/*}

function boot_wait() {
 while [[ -z $(getprop sys.boot_completed) ]]; do sleep 5; done
}
function system_table_unset() {
  settings delete system "$1"
}
boot_wait
system_table_unset activity_manager_constants

function hc_delete(){
    rm -rf $MODDIR/JossG/Zram > /dev/null &
    # Update
    rm -rf /data/adb/modules/XZ
}
hc_delete
