#!/bin/bash
shopt -s expand_aliases
source ~/Github/dotfiles_pc/.custom.sh
clear
# subshell system
# ( #apphere# >/dev/null 2>&1 &)
# Variables
black=$(tput setaf 0)
red=$(tput setaf 1) # Errors
green=$(tput setaf 2) 
yellow=$(tput setaf 3)
blue=$(tput setaf 4) 
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
reset=$(tput sgr0) # Resets color to default

echo -n "${red}"
figlet "EOA"
echo -n "${reset}"

mainmenu () {
echo -n "${red}"
figlet "EOA"
echo -n "${reset}" 
case $compact in
   2) echo "Quote of the day" | lolcat; 
      curl -s https://zenquotes.io/api/today | jq -C '.[] | .q +" ~ "+.a' | lolcat || echo "${red}Error getting quote ~ System${reset}"
      echo -n "Date:"; date +%d/%m/%Y | lolcat
      echo "";;
esac
  echo "1. ${green}Weather${reset}"
  echo "2. ${cyan}Pi${reset}"
  echo "3. ${magenta}Dotfiles${reset}"
  echo "4. ${blue}Resolution${reset}"
  echo "5. ${yellow}Games${reset}"
  echo "6. ${green}Internet${reset}" 
  echo "7. ${cyan}Varsity${reset}"
  echo "8. ${magenta}Utilities${reset}"
  echo "0. ${red}Exit${reset}"
  echo ""
  read -n 1 -p "Input Selection:" mainmenuinput
  clear
  case $mainmenuinput in
    1) weather ;;
    2) pi ;;
    3) github ;;
    4) resolution ;;
    5) games ;;
    6) internet ;;
    7) varsity ;;
    8) utils ;;
    0|q|Q) echo "${magenta}Bye bye${reset}${red} <3${reset}" ;;
    *) echo "${red}I didnt quite get that?${reset}"
    mainmenu
    esac
}
weather () {
echo "${green}"
figlet "WR"
echo "${reset}"
    echo "1. Port Elizabeth" 
    echo "2. Oudtshoorn"
    echo "3. Somerset East"
    echo "4. Nylstroom"
    echo "0. Previous Menu" | lolcat
    echo ""
    read -n 1 -p "Input Selection:" weatherinput
    clear
        case $weatherinput in
        1) wpe && read -n 1 -p "Press any button to clear" && clear; weather;;
        2) woh && read -n 1 -p "Press any button to clear" && clear; weather;;
        3) wse && read -n 1 -p "Press any button to clear" && clear; weather;;
        4) nyl && read -n 1 -p "Press any button to clear" && clear; weather;;
        0|q|Q) mainmenu ;;
        *) echo "${red}I didnt quite get that?${reset}"
        weather
        esac
}
pi () {
echo "${cyan}"
figlet "PI"
echo "${reset}"
    echo "1. SSH" 
    echo "2. SFTP"
    echo "0. Previous Menu" | lolcat
    echo ""
    read -n 1 -p "Input Selection:" piinput
    clear
        case $piinput in
        1) pissh || echo "${red}Couldn't connect to pi${reset}"; pi;;
        2) pisftp || echo "${red}Couldn't connect to pi${reset}"; pi;;
        0|q|Q) mainmenu ;;
        *) echo "${red}I didnt quite get that?${reset}"
        pi
        esac
}
github() {
echo "${magenta}"
figlet "DF"
echo "${reset}"
    echo "1. Bashrc" 
    echo "2. Zshrc"
    echo "3. Commands.sh"
    echo "4. Custom.txt"
    echo "5. Dotfiles (thunar)"
    echo "0. Previous Menu" | lolcat
    echo ""
    read -n 1 -p "Input Selection:" dfinput
    clear
        case $dfinput in
        1) bashedit && github;;
        2) zshrcedit && github;;
        3) comedit && github;;
        4) custedit && github;;
        5) (thunar  ~/Github/dotfiles_pc/ >/dev/null 2>&1 &) && github;;
        0|q|Q) mainmenu ;;
        *) echo "${red}I didnt quite get that?${reset}"
        github
        esac
}
resolution () {
echo "${blue}"
figlet "RES"
echo "${reset}"
    echo "1. 1366x768" 
    echo "2. 960x540"
    echo "3. 640x360"
    echo "0. Previous Menu" | lolcat
    echo ""
    read -n 1 -p "Input Selection:" resinput
    clear
        case $resinput in
        1) resnormal && resolution;;
        2) resgame && resolution;;
        3) ressupergame && resolution;;
        0|q|Q) mainmenu ;;
        *) echo "${red}I didnt quite get that?${reset}"
        resolution
        esac
}
games () {
echo "${yellow}"
figlet "GAMES"
echo "${reset}"
    echo "1. Minecraft" 
    echo "2. Wakfu"
    echo "0. Previous Menu" | lolcat
    echo ""
    read -n 1 -p "Input Selection:" gameinput
    clear
        case $gameinput in
        1) minecraft-launcher ;;
        2) wakfu;;
        0|q|Q) mainmenu ;;
        *) echo "${red}I didnt quite get that?${reset}"
        games
        esac
}
internet () {
   echo "${green}"
   figlet "INTERNET"
   echo "${reset}"
   echo "1. Youtube"
   echo "2. Netflix"
   echo "3. Showmax"
   echo "4. Nyaa.si"
   echo "5. Yts.mx"
   echo "6. Torrent-Client"
   echo "0. Previous Menu" | lolcat
   echo ""
   read -n 1 -p "Input Selection:" internetinput
   clear
   case $internetinput in
   1) (brave https://www.youtube.com/ >/dev/null 2>&1 &) ; clear; echo "${green} Successfully Opened!${reset}" && internet ;;
   2) (brave https://www.netflix.com/browse >/dev/null 2>&1 &); clear; echo "${green} Successfully Opened!${reset}" && internet ;;
   3) echo "${red}WIP${reset}" && internet;;
   4) (brave https://www.nyaa.si >/dev/null 2>&1 &); clear; echo "${green} Successfully Opened!${reset}" && internet;;
   5) (brave https://www.yts.mx >/dev/null 2>&1 &); echo "${green} Successfully Opened!${reset}" && internet;;
   6) (qbittorrent >/dev/null 2>&1 &) && internet;;
   0|q|Q) mainmenu ;;
   *) echo "${red}I didnt quite get that?${reset}"
   internet
   esac
}
varsity () {
   echo "${cyan}"
   figlet "VARSITY"
   echo "${reset}"
   echo "1. VC Learn"
   echo "2. VC Portal"
   echo "3. VSC"
   echo "0. Previous Menu" | lolcat
   echo ""
   read -n 1 -p "Input Selection:" vcinput
   clear
   case $vcinput in
   1) (brave https://myvc.iielearn.ac.za/ >/dev/null 2>&1 &); clear; echo "${green} Successfully Opened!${reset}" && varsity;;
   2) (brave https://portal.iie.ac.za/ADV_Student/Login.asp >/dev/null 2>&1 &); clear; echo "${green} Successfully Opened!${reset}" && varsity;;
   3) (code >/dev/null 2>&1 &); clear; echo "${green} Successfully Opened!${reset}" && varsity; ;;
   0|q|Q) mainmenu ;;
   *) echo "${red}I didnt quite get that?${reset}"
   varsity
   esac
}
utils () {
   echo "${magenta}"
   figlet "UTILS"
   echo "${reset}"
   echo "1. Whatsapp"
   echo "2. Server scan(non-dev)${blue} by stiaaan${reset}"
   echo "3. Server scan(dev)${blue} by stiaaan${reset}"
   echo "0. Previous Menu" | lolcat
   echo ""
   read -n 1 -p "Input Selection:" utilinput
   clear
   case $utilinput in
   1) (brave https://web.whatsapp.com/ >/dev/null 2>&1 &); clear; echo "${green} Successfully Opened!${reset}" && utils;;
   2) ruby ~/Github/dotfiles_pc/otherStatus.rb; read -n 1 -p "Press any button to clear" && clear; utils;;
   3) ruby ~/Github/dotfiles_pc/devStatus.rb; read -n 1 -p "Press any button to clear" && clear; utils;;
   0|q|Q) mainmenu ;;
   *) echo "${red}I didnt quite get that?${reset}"
   utils
   esac
}
echo "Compact Start?"
echo "1. Yes"
echo "2. No"
echo "0. Exit" | lolcat
echo ""
read -n 1 -p "Input Selection:" Cmode
case $Cmode in 
   1) clear
      compact=1
      mainmenu;;
      
   2) clear; 
      compact=2
      mainmenu;;
   0|Q|q) clear; echo "${magenta}Bye bye${reset}${red} <3${reset}";;
   *) clear; echo "${magenta}Bye bye${reset}${red} <3${reset}";;
esac
