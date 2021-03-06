#!/bin/echo usage: source
############################################################## {{{1 ##########
#   $Author$
#   $Revision$
#   $Date$
#   $HeadURL$
############################################################## }}}1 ##########

setopt No_XTrace

# Current status (26.07.2012): build with atlas
#
typeset  General_Variants="+universal"
typeset       Qt_Variants="+docs"

# Current status (04.12.2015) quartz compiles but crashes a lot
# and most GNOME tools still need X11.
#
#typeset   Gnome_Variants="+quartz+no_X11-x11"
typeset    Gnome_Variants="+x11"

if test -d "/Work/MacPorts/dports"; then
    typeset Base_Work_Dir="/Work/MacPorts/dports"
elif test -d "/Volumes/Shared/MacPorts/dports"; then
    typeset Base_Work_Dir="/Volumes/Shared/MacPorts/dports"
elif test -d "/Volumes/Shared-1/MacPorts/dports"; then
    typeset Base_Work_Dir="/Volumes/Shared-1/MacPorts/dports"
fi

path=/opt/local/bin
path+=/bin
path+=/sbin
path+=/usr/bin
path+=/usr/sbin
path+=/usr/local/bin
path+=/usr/X11/bin

typeset -x -g -U -T PKG_CONFIG_PATH pkg_config_path ':'

pkg_config_path+="/opt/local/share/pkgconfig"
pkg_config_path+="/opt/local/libexec/qt4-mac/lib/pkgconfig"
pkg_config_path+="/opt/local/lib/pkgconfig"

function Load ()
    {
    local in_PList="${1}"

    if test -e ${in_PList}; then
	launchctl load -w ${in_PList}
    fi

    return
    } # Load

function Load_System ()
    {
    echo "===> Load System"

    Load "/Library/LaunchDaemons/com.krischik.fetchmail.plist"
    Load "/Library/LaunchDaemons/org.freedesktop.dbus-system.plist"
    Load "/Library/LaunchDaemons/org.macports.dbus.plist"
    Load "/Library/LaunchDaemons/org.macports.dovecot.plist"
    Load "/Library/LaunchDaemons/org.macports.fetchnews.plist"
    Load "/Library/LaunchDaemons/org.macports.gdm.plist"
    Load "/Library/LaunchDaemons/org.macports.leafnode.plist"
    Load "/Library/LaunchDaemons/org.macports.mysql5.plist"
    Load "/Library/LaunchDaemons/org.macports.postfix.plist"
    Load "/Library/LaunchDaemons/org.macports.rsyncd.plist"
    Load "/Library/LaunchDaemons/org.macports.slapd.plist"
    Load "/Library/LaunchDaemons/org.macports.spamd.plist"
    Load "/Library/LaunchDaemons/org.macports.texpire.plist"

    return
    } # Load_System

function Load_User ()
    {
    echo "===> Load User"
    Load "/Library/LaunchAgents/org.freedesktop.dbus-session.plist"
    Load "${HOME}/Library/LaunchAgents/com.krischik.imapfilter.plist"

    if test -d /Applications/MacPorts/KDE4/kdeinit4.app; then
	open /Applications/MacPorts/KDE4/kdeinit4.app
    fi

    return
    } # Load_User

function Select_System ()
    {
    echo "===> Select System"

    port select --set "cython"	"cython27"
    port select --set "python"	"python35"
    port select --set "python3"	"python35"
    port select --set "ruby"	"ruby22"
    port select --set "gcc"	"mp-gcc5"
    port select --set "llvm"	"mp-llvm-3.7"
    port select --set "maven"	"maven3"
    port select --set "scala"	"scala2.11"

    return
    } # Select_System

function Deselect_System ()
    {
    echo "===> Select System"

    port select --set "cython"	"none"
    port select --set "python"	"none"
    port select --set "python3"	"none"
    port select --set "ruby"	"none"
    port select --set "gcc"	"none"
    port select --set "llvm"	"none"
    port select --set "maven"	"none"
    port select --set "scala"	"none"
    #port select --set "qt4"	"none"

    return
    } # Select_System

function Unload ()
    {
    local in_PList="${1}"

    if test -e ${in_PList}; then
	launchctl unload -w ${in_PList}
    fi

    return
    } # Unload

function Unload_System ()
    {
    echo "===> Un-Load System"

    Unload "/Library/LaunchDaemons/com.krischik.fetchmail.plist"
    Unload "/Library/LaunchDaemons/org.freedesktop.dbus-system.plist"
    Unload "/Library/LaunchDaemons/org.macports.dbus.plist"
    Unload "/Library/LaunchDaemons/org.macports.dovecot.plist"
    Unload "/Library/LaunchDaemons/org.macports.fetchnews.plist"
    Unload "/Library/LaunchDaemons/org.macports.gdm.plist"
    Unload "/Library/LaunchDaemons/org.macports.leafnode.plist"
    Unload "/Library/LaunchDaemons/org.macports.mysql5.plist"
    Unload "/Library/LaunchDaemons/org.macports.postfix.plist"
    Unload "/Library/LaunchDaemons/org.macports.rsyncd.plist"
    Unload "/Library/LaunchDaemons/org.macports.slapd.plist"
    Unload "/Library/LaunchDaemons/org.macports.spamd.plist"
    Unload "/Library/LaunchDaemons/org.macports.texpire.plist"
    Unload "/System/Library/LaunchDaemons/org.postfix.master.plist"

    return
    } # Unload_System

function Unload_User ()
    {
    echo "===> Un-Load User"

    Unload "/Library/LaunchAgents/org.freedesktop.dbus-session.plist"
    Unload "${HOME}/Library/LaunchAgents/com.krischik.imapfilter.plist"

    return
    } # Unload_User

function Install_Update ()
    {
    local in_Package="${1}"
    local in_Options="${2} ${3} ${4}"

    echo "===> Install  ${=in_Package} ${=in_Options}"

    if ! port -f install ${=in_Package} ${=in_Options}; then
	port upgrade --enforce-variants ${=in_Package} ${=in_Options}
    fi

    port activate ${=in_Package} ${=in_Options} || true
    return
    } # Install_Update

function Un_Install ()
    {
    local in_Package="${1}"

    echo "===> Un-Install  ${in_Package}"

    port uninstall --follow-dependents ${=I}

    return
    } # Un_Install

function Update_Tree ()
    {
    if test -d "${Base_Work_Dir}"; then
	pushd "${Base_Work_Dir}"
	    typeset Archive_Owner="$(gstat -c %U .)"
	    typeset Archive_Group="$(gstat -c %G .)"

	    echo "===> Subversion Cleanup"
	    svn cleanup
	    svn revert PortIndex*
	    echo "===> Subversion Update"
	    svn update
	    portindex
	    gchown --recursive ${Archive_Owner}:${Archive_Group} .
	popd
    fi

    echo "===> Self Update"
    port selfupdate
    echo "===> Sync"
    port sync

    return
    } # Update_Tree

function Update_Packages ()
    {
    echo "===> Upgrade Outdated"
    port -p upgrade --enforce-variants outdated ${General_Variants}

    return
    } # Update_Packages

function Clean ()
    {
    echo "===> Uninstall Inactive"
    port -p uninstall inactive
    echo "===> Uninstall Outdated"
    port -p uninstall outdated
    echo "===> Clean"
    port -f -q clean --all all >/dev/null

    return
    } # Clean

############################################################ {{{1 ###########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
