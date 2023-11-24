ask=`zenity --info --text='' --title='' --icon='system-shutdown' \
--ok-label='〇' --extra-button='LC' --extra-button='LG' \
--extra-button='PW' --extra-button='RB' --extra-button='SP'`

case $ask in
  'LC') {
    if [[ $DESKTOP_SESSION == "gnome" ]]; then
      xdg-screensaver lock
    else
      swaylock
    fi
  };;
  'LG') loginctl kill-user user;;
  'PW') systemctl poweroff;;
  'RB') systemctl reboot;;
  'SP') systemctl suspend;;
esac
