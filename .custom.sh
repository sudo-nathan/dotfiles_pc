# Custom Commands
alias bashedit='nano ~/.bashrc'
alias VC='cd; cd Documents/VC'
alias custom='figlet Custom | lolcat; cat ~/Github/dotfiles_pc/.commands | lolcat'
alias custedit='nano ~/Github/dotfiles_pc/.commands'
alias comedit='nano ~/Github/dotfiles_pc/.custom.sh'
alias i3edit='nano ~/.config/i3/config file'
alias dotfiles='cd ~/Github/dotfiles_pc'
alias resolution='arandr'
alias hack='feh --bg-scale ~/Github/dotfiles_pc/hack.jpg'
alias now='timedatectl | lolcat'
alias pissh='ssh pi@192.168.8.148'
alias pisftp='sftp pi@192.168.8.148'
alias sleep='systemctl suspend'
alias wakfu='cd;cd Games;./wakfuLauncher.AppImage'
# Cpu Commands
alias speed='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq'
# Resolution Commands
alias resgame='xrandr --output LVDS-1 --mode 960x540'
alias ressupergame='xrandr --output LVDS-1 --mode 640x360'
alias resnormal='xrandr --output LVDS-1 --mode 1366x768'
# API Commands
alias weather='ruby ~/Github/dotfiles_pc/weather_api.rb | lolcat'
