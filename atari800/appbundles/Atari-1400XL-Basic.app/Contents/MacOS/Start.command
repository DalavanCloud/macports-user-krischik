#!/bin/zsh
############################################################## {{{1 ##########
#   $Author$
#   $Revision$
#   $Date$
#   $HeadURL$
############################################################## }}}1 ##########

local User_Data="${HOME}/Library/Application Support/Atari800"
local System_Data="@PREFIX@/share/atari800";

${System_Data}/Setup.command

@PREFIX@/bin/atari800				\
    -1400					\
    -xep80					\
    -basic					\
    -pal					\
    -windowed					\
    -width 1280					\
    -height 960					\
    -bpp 16					\
    -xlxe_rom "${System_Data}/ATARIXL.ROM"	\
    -basic_rom "${System_Data}/ATARIBAS.ROM"	\
    ${User_Data}/MYDOS45D.ATR			;

############################################################ {{{1 ###########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
