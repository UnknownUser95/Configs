# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# enable Oh-My-Zsh
source $HOME/.oh-my-zshrc

# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# change ENV vars

export LS_COLORS='rs=0:fi=38;5;2:di=01;34:ln=01;38;2;255;255;0:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32;48;2;128;52;190:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.swp=00;90:*.tmp=00;90:*.dpkg-dist=00;90:*.dpkg-old=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:';

export PATH="/home/luca_s/custom_commands:/home/luca_s/.cargo/bin:${PATH}"

export LATITUDE_MAC="78:2b:cb:cf:dd:4e"
export LATITUDE_IP="192.168.5.199"
export LATITUDE_USER="ls"
export DEBUG=""

# aliases
alias cls='clear'

# git
get_branch() {
	branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
	if [[ $? -eq 0 ]]; then
		echo $branch
	else
		echo "not a git repo"
		return 1
	fi
}
gcm() { git commit -m "$*" }
gacm() {
	if [[ $# == 0 ]]; then
		git commit --amend -m "$(git log --format=%B -n 1 HEAD)"
	else
		git commit --amend -m "$*"
	fi
}
ga() {
	if [[ $# == 0 ]]; then
		git add .
		return 0
	fi

	for file in $*; do
		if [[ -f "$file" || -d "$file" || "$file" =~ ".*[*]{1}.*" ]]; then
			# alt: "$file" == *\**
			git add "$file"
		else
			echo "'$file' is not a file"
		fi
	done
}
grst() {
	if [[ $# -eq 0 ]]; then
		git reset --staged .
		return 0
	fi

	for file in $*; do
		if [[ -f $file ]]; then
			git restore --staged $file
		else
			echo "'$file' is not a file"
		fi
	done
}
gpu() {
	if [[ $1 != "" ]]; then
		git push origin $1
	else
		git push origin $(get_branch)
	fi
}
gpl() {
	if [[ $1 != "" ]]; then
		git pull origin $1
	else
		git pull origin $(get_branch)
	fi
}
alias sc="clear && git status"
alias s="git status"
alias gf="git fetch origin"
alias gdf="git diff"
alias gbr="git checkout -b"
alias gr="git reset"
alias gck="git checkout"
alias glog='git log --graph'

# python
alias act="source ./venv/bin/activate"
