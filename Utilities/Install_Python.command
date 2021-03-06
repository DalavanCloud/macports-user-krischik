#!/opt/local/bin/zsh
############################################################## {{{1 ##########
#   $Author$
#   $Revision$
#   $Date$
#   $HeadURL$
############################################################## }}}1 ##########

source ${0:h}/Setup.command

setopt No_XTrace
setopt No_Err_Exit

if test "${USER}" = "root"; then
    for I in		\
	"python27"	\
	"py27-crypto"	\
	"py27-tkinter"	\
	"python35"	
    do
	Install_Update ${I} "${=General_Variants}"
    done; unset I
   
    # the following pyton moduls can't be compiled with
    # universal as py27-numpy has no universal variant
    #
    for I in		\
	"py27-numpy"	\
	"py27-cairo"	\
	"py27-pygtk"
    do
	Install_Update ${I}
    done; unset I
else
    setopt Multi_OS
    sudo ${0:a} 1>&1 2>&2 &>~/Library/Logs/${0:r:t}.out
fi

############################################################ {{{1 ###########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
