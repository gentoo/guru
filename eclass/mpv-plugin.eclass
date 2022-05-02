# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: mpv-plugin.eclass
# @MAINTAINER:
# Nicola Smaniotto <smaniotto.nicola@gmail.com>
# @AUTHOR:
# Nicola Smaniotto <smaniotto.nicola@gmail.com>
# @SUPPORTED_EAPIS: 8
# @BLURB: install mpv plugins
# @DESCRIPTION:
# This eclass simplifies the installation of mpv plugins into system-wide
# directories.  Also handles the mpv dependency and provides an USE flag
# for automatic loading of the plugin.

case ${EAPI:-0} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} unsupported."
esac

EXPORT_FUNCTIONS src_install pkg_postinst

# @ECLASS_VARIABLE: USE_MPV
# @DEFAULT_UNSET
# @PRE_INHERIT
# @DESCRIPTION:
# Controls adding media-video/mpv dependency.  The allowed values are:
#
# - rdepend -- add it to RDEPEND
#
# - depend -- add it to DEPEND+RDEPEND with the binding slot operator (the
# default)

# @ECLASS_VARIABLE: MPV_REQ_USE
# @DEFAULT_UNSET
# @PRE_INHERIT
# @DESCRIPTION:
# The list of USE flags required to be enabled on mpv, formed as a
# USE-dependency string.
#
# Example:
# @CODE@
# MPV_REQ_USE="lua"
# @CODE@

if [[ ! ${_MPV_PLUGIN_ECLASS} ]]; then

# @FUNCTION: _mpv-plugin_set_globals
# @INTERNAL
# @USAGE:
# @DESCRIPTION:
# Sets all the global output variables provided by this eclass.
# This function must be called once, in global scope.
_mpv-plugin_set_globals() {
	local MPV_PKG_DEP

	SLOT="0"
	IUSE="+autoload"

	MPV_PKG_DEP="media-video/mpv"
	case ${USE_MPV:-depend} in
		rdepend)
			;;
		depend)
			MPV_PKG_DEP+=":="
			;;
		*)
			die "Invalid USE_MPV=${USE_MPV}"
			;;
	esac
	if [ ${MPV_REQ_USE} ]; then
		MPV_PKG_DEP+="[${MPV_REQ_USE}]"
	fi

	RDEPEND="${MPV_PKG_DEP}"
	if [[ ${USE_MPV} == depend ]]; then
		DEPEND="${MPV_PKG_DEP}"
	fi
}
_mpv-plugin_set_globals

# @ECLASS_VARIABLE: MPV_PLUGIN_FILES
# @DEFAULT_UNSET
# @REQUIRED
# @DESCRIPTION:
# Array containing the list of files to be installed.

# @FUNCTION: _mpv-plugin_has_main
# @INTERNAL
# @USAGE:
# @DESCRIPTION:
# Checks for the existance of a file named main. This means the plugin needs
# all files to be installed together, and mpv will only run the one called main.
_mpv-plugin_has_main() {
	[[ " ${MPV_PLUGIN_FILES[*]} " =~ " main."[[:alnum:]]+" " ]]
}

# @FUNCTION: mpv-plugin_src_install
# @USAGE:
# @DESCRIPTION:
# Install the specified files in ${D} and symlink them if the autoload flag is
# set.
# The ebuild must specify the file list in the MPV_PLUGIN_FILES array.
mpv-plugin_src_install() {
	if [[ ! ${MPV_PLUGIN_FILES} ]]; then
		die "${ECLASS}: no files specified in MPV_PLUGIN_FILES, cannot install"
	fi

	local MPV_INSTALL_DIR="/usr/$(get_libdir)/mpv"
	if _mpv-plugin_has_main; then
		MPV_INSTALL_DIR+="/${PN}"
	fi
	insinto "${MPV_INSTALL_DIR}"

	for f in "${MPV_PLUGIN_FILES[@]}"; do
		doins "${f}"
	done

	use autoload && if _mpv-plugin_has_main; then
		dosym -r "${MPV_INSTALL_DIR}" "/etc/mpv/scripts/${PN}"
	else
		for f in "${MPV_PLUGIN_FILES[@]}"; do
			dosym -r "${MPV_INSTALL_DIR}/${f}" "/etc/mpv/scripts/${f}"
		done
	fi

	einstalldocs
}

# @FUNCTION: mpv-plugin_pkg_postinst
# @USAGE:
# @DESCRIPTION:
# Warns the user of the existence of the autoload use flag.
mpv-plugin_pkg_postinst() {
	if ! use autoload; then
		elog
		elog "The plugin has not been installed to /etc/mpv/scripts for autoloading."
		elog "You have to activate it manually by passing"
		if _mpv-plugin_has_main; then
			elog "  \"${EPREFIX}/usr/$(get_libdir)/mpv/${PN}\""
		else
			for f in "${MPV_PLUGIN_FILES[@]}"; do
				elog "  \"${EPREFIX}/usr/$(get_libdir)/mpv/${f}\""
			done
		fi
		elog "as script option to mpv or symlinking the library to \"scripts/\" in your mpv"
		elog "config directory."
		elog "Alternatively, activate the autoload use flag."
		elog
	fi
}

_MPV_PLUGIN_ECLASS=1
fi
