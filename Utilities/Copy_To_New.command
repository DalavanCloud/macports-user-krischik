#!/opt/local/bin/zsh
############################################################## {{{1 ##########
#   $Author$
#   $Revision$
#   $Date$
#   $HeadURL$
############################################################## }}}1 ##########

setopt X_Trace

if test "${USER}" = "root"; then
    pushd "/opt/local.old"
	for I in					    \
	    **/CVS(/)					    \
	    bin/startkde				    \
	    etc/LaunchDaemons/org.macports.fetchmail.plist  \
	    etc/dbus-1/system.d/avahi-dbus.conf		    \
	    etc/dovecot/dovecot.conf			    \
	    etc/dovecot/mkcert.zsh			    \
	    etc/dovecot/passwd.dovecot			    \
	    etc/dovecot/renewcert.zsh			    \
	    etc/dovecot/userdb.dovecot			    \
	    etc/fetchmailrc				    \
	    etc/leafnode/config				    \
	    etc/rsyncd.conf				    \
	    etc/ssl					    \
	    share/purple				    \
	    var/log					    \
	    var/run/dovecot				    \
	    var/run/fetchmail				    \
	    var/spool/news
	do
	    gcp --archive --verbose "${I}" "/opt/local/${I}"
	done; unset I
    popd

    pushd "/opt/local"
	/bin/chmod +a "martin allow write"	    \
	    .					    \
	    /opt/local/etc/macports		    \
	    /opt/local/etc/macports/sources.conf    \
	    bin					    \
	    etc					    \
	    etc/LaunchDaemons			    \
	    etc/dovecot				    \
	    etc/macports
    popd
else
    setopt Multi_OS
    sudo ${0} 1>&1 2>&2 &>~/Library/Logs/${0:r:t}.out
fi

############################################################ {{{1 ###########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
