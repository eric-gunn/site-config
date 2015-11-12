#!/bin/bash
readonly RED="\033[0;31m"
readonly GREEN="\033[0;32m"
readonly BLUE="\033[38;5;27m"
readonly MAGENTA="\033[0;35m"
readonly CYAN="\033[0;36m"
readonly PURPLE="\033[38;5;63m"
readonly ORANGE="\033[38;5;208m"
readonly RED_BOLD="\033[1;31m"
readonly GREEN_BOLD="\033[1;32m"
readonly BLUE_BOLD="\033[1;38;5;27m"
readonly MAGENTA_BOLD="\033[1;35m"
readonly CYAN_BOLD="\033[1;36m"
readonly PURPLE_BOLD="\033[1;38;5;63m"
readonly ORANGE_BOLD="\033[1;38;5;208m"
readonly RED_UNDERLINE="\033[4;31m"
readonly GREEN_UNDERLINE="\033[4;32m"
readonly BLUE_UNDERLINE="\033[4;38;5;27m"
readonly MAGENTA_UNDERLINE="\033[4;35m"
readonly CYAN_UNDERLINE="\033[4;36m"
readonly PURPLE_UNDERLINE="\033[4;38;5;63m"
readonly ORANGE_UNDERLINE="\033[4;38;5;208m"
n=$RANDOM

readonly RANDOM_COLOR="\033[38;5;$((n%210+4))m"
readonly RANDOM_COLOR_BOLD="\033[1;38;5;$((n%210+4))m"
readonly RANDOM_COLOR_UNDERLINE="\033[4;38;5;$((n %= 200))m"
readonly DEFAULT="\033[m"
#usage
function usage () {
	echo -e "$N"
	echo -e "Welcome to $CYAN""Site Configurator ©2015 Eric Gunn""$DEFAULT"
	echo ""
	echo -e "usage:	site [""$CYAN""-f""$DEFAULT"" | ""$CYAN""-ft""$DEFAULT"" | ""$PURPLE""-b""$DEFAULT"" | ""$PURPLE""-bt""$DEFAULT"" | ""$BLUE""-p""$DEFAULT"" | ""$BLUE""-pt""$DEFAULT""] [""$GREEN""-a""$DEFAULT"" | ""$ORANGE""-d""$DEFAULT"" | ""$RANDOM_COLOR""-r""$DEFAULT""]"
	echo ""
	echo -e "Frameworks | Frameworks + Templates:"
	echo -e "	[""$CYAN""-f ""$DEFAULT"" | ""$CYAN""--foundation""$DEFAULT"" | ""$CYAN""foundation""$DEFAULT""]"
	echo -e "	[""$PURPLE""-b ""$DEFAULT"" | ""$PURPLE""--bootstrap""$DEFAULT""  | ""$PURPLE""bootstrap""$DEFAULT"" ]"
	echo -e "	[""$BLUE""-p ""$DEFAULT"" | ""$BLUE""--pure-css""$DEFAULT""   | ""$BLUE""pure-css""$DEFAULT""  ]"
	echo -e "	[""$CYAN""-ft""$DEFAULT"" | ""$CYAN""--foundation-templates""$DEFAULT"" | ""$CYAN""foundation-templates""$DEFAULT""]"
	echo -e "	[""$PURPLE""-bt""$DEFAULT"" | ""$PURPLE""--bootstrap-templates""$DEFAULT""  | ""$PURPLE""bootstrap-templates""$DEFAULT"" ]"
	echo -e "	[""$BLUE""-pt""$DEFAULT"" | ""$BLUE""--pure-css-templates""$DEFAULT""   | ""$BLUE""pure-css-templates""$DEFAULT""  ]"
	echo ""
	echo -e "Packages:"
	echo -e "	[""$GREEN""-a ""$DEFAULT"" | ""$GREEN""--animate""$DEFAULT"" | ""$GREEN""animate""$DEFAULT""]"
	echo -e "	[""$ORANGE""-d ""$DEFAULT"" | ""$ORANGE""--d3""$DEFAULT""      | ""$ORANGE""d3""$DEFAULT""     ]"
	echo -e "	[""$RANDOM_COLOR""-r ""$DEFAULT"" | ""$RANDOM_COLOR""--rainbow""$DEFAULT"" | ""$RANDOM_COLOR""rainbow""$DEFAULT""]"
}
#uninstaller
function remove () {
	while [[ true ]]; do
		#statements
		echo -en "$RED""WARNING: This will remove the entire site. Continue? [y/N]: ""$DEFAULT"
		read yn
		case $yn in
			[Yy]*)
				directory=${PWD##*/}
				cd ..
				#echo -e "$directory"
				rm -rf $directory
				exit
			;;
			*)
				break
			;;
		esac
	done
	

}
#framework installers
function install_foundation () {
	echo -e "$CYAN""Foundation"
	wget http://foundation.zurb.com/cdn/releases/foundation-5.5.2.zip
	wget http://zurb.com/playground/uploads/upload/upload/288/foundation-icons.zip
	unzip foundation-5.5.2.zip
	unzip foundation-icons.zip
	mv foundation-icons css
	rm -rf foundation-5.5.2.zip foundation-icons.zip __MACOSX
	echo -e "$GREEN""Successfully installed Foundation""$DEFAULT"
}
function install_bootstrap () {
	echo -e "$PURPLE""Bootstrap"
	wget https://github.com/twbs/bootstrap/releases/download/v3.3.4/bootstrap-3.3.4-dist.zip
	unzip bootstrap-3.3.4-dist.zip
	mv -v bootstrap-3.3.4-dist/* .
	mkdir img
	rm -rf bootstrap-3.3.4-dist.zip bootstrap-3.3.4-dist
	echo -e "$GREEN""Successfully installed Bootstrap""$DEFAULT"
}
function install_pure () {
	echo -e "$BLUE""Pure CSS"
	wget https://github.com/yahoo/pure-release/archive/v0.6.0.zip
	unzip v0.6.0.zip
	mkdir css img js
	mv -v pure-release-0.6.0/* css
	rm -rf v0.6.0.zip pure-release-0.6.0
	echo -e "$GREEN""Successfully installed Pure CSS""$DEFAULT"
}
#template installers
function foundation_template (){
	echo -e "$CYAN""Installing Foundation Templates"
	mkdir templates
	cd templates
	#wget http://foundation.zurb.com/templates/banded.html
	#wget http://foundation.zurb.com/templates/blog.html
	templates=( banded blog feed grid orbit banner sidebar contact marketing realty boxy store workspace marketing-2 product portfolio)
	for i in "${templates[@]}"
	do
		:
		wget http://foundation.zurb.com/templates/$i.html;
	done
	#mv banded.html templates
	cd ..
	echo -e "$GREEN""Successfully installed Foundation Templates""$DEFAULT"
}
function bootstrap_template (){
	echo -e "$PURPLE""Installing Bootstrap Templates"
	mkdir templates
	cd templates
	templates=( starter-template theme grid jumbotron jumbotron-narrow navbar navbar-static-top navbar-fixed-top cover carousel blog dashboard signin justified-nav sticky-footer sticky-footer-navbar non-responsive offcanvas )
	for i in "${templates[@]}"
	do
		:
		wget http://getbootstrap.com/examples/$i/index.html;
		mv index.html $i.html
	done
	cd ..
	echo -e "$GREEN""Successfully installed Bootstrap Templates""$DEFAULT"
}
function pure_template (){
	echo -e "$BLUE""Installing Pure Templates"
	mkdir templates
	cd templates
	templates=( blog email gallery marketing pricing side-menu tucked-menu-vertical tucked-menu )
	for i in "${templates[@]}"
	do
		:
		wget http://cdn.gunntechnologies.com/pure-css/pure-layout-$i.zip;
		unzip pure-layout-$i.zip
		mv -v css/layouts/* ../css
		mv -v img/common/* ../img
		mv -v js/* ../js
		mv index.html pure-layout-$i.html
		rm -rf LICENSE.md README.md pure-layout-$i.zip css img js
	done
	cd ..
	echo -e "$GREEN""Successfully installed Pure Templates""$DEFAULT"
}
#package installers
function install_animate () {
	echo -e "$GREEN""Installing Animate CSS"
	wget https://raw.github.com/daneden/animate.css/master/animate.css
	mv animate.css css
	echo -e "Successfully installed Animate CSS""$DEFAULT"
}
function install_d3 () {
	echo -e "$ORANGE""Installing D3 JS"
	cd js
	wget https://github.com/mbostock/d3/releases/download/v3.5.5/d3.zip
	unzip d3.zip
	rm -rf d3.zip LICENSE
	cd ..
	echo -e "$GREEN""Successfully installed D3 JS""$DEFAULT"
}
function install_rainbow () {
	echo -e "$RANDOM_COLOR""Installing Rainbow JS"
	wget https://github.com/ccampbell/rainbow/archive/master.zip
	unzip master.zip
	mkdir css/rainbow-themes
	mv rainbow-master/package.json js
	mv -v rainbow-master/js/* js
	mv -v rainbow-master/themes/* css/rainbow-themes
	rm -rf master.zip rainbow-master
	echo -e "$GREEN""Successfully installed Rainbow JS""$DEFAULT"
}
#main program
if [[ "$1" == "" ]]; then
	usage;
	exit
fi
while [[ "$1" != "" ]]; do
	case $1 in
		-h|--help|help)
			usage;
			exit
		;;
		remove)
			remove;
			break
		;;
		-f|--foundation|foundation)
			#echo -e "$CYAN_BOLD""Install Foundation""$DEFAULT"
			install_foundation;
			break
		;;
		-ft|--foundation-templates|foundation-templates)
			install_foundation;
			foundation_template;
			break
		;;
		-b|--bootstrap|bootstrap)
			#echo -e "$MAGENTA_BOLD""Install Bootstrap""$DEFAULT"
			install_bootstrap;
			break
		;;
		-bt|--bootstrap-templates|bootstrap-templates)
			install_bootstrap;
			bootstrap_template;
			break
		;;
		-p|--pure|pure)
			#echo -e "$BLUE_BOLD""Install Pure""$DEFAULT"
			install_pure;
			break
		;;
		-pt|--pure-templates|pure-templates)
			#echo -e "$BLUE_BOLD""Install Pure""$DEFAULT"
			install_pure;
			pure_template;
			break
		;;
		*)
			usage;
			#echo -e "$GREEN_BOLD""Framework Help""$DEFAULT"
			exit
		;;
	esac
	shift
done
while [[ "$1" != "" ]]; do
	#statements
	case $1 in
		-a|--animate|animate)
			#echo -e "$GREEN_BOLD""Install Animate"
			install_animate;
		;;
		-d|--d3|d3)
			install_d3;
		;;
		-r|--rainbow|rainbow)
			#echo -e "$GREEN_BOLD""Install Rainbow""$DEFAULT"
			install_rainbow;
		;;
		"")
			exit
		;;
	esac
	shift
done