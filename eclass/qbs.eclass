# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qbs.eclass
# @AUTHOR:
# Anna Vyalkova <cyber+gentoo@sysrq.in>
# @MAINTAINER:
# Anna Vyalkova <cyber+gentoo@sysrq.in>
# @SUPPORTED_EAPIS: 8
# @PROVIDES: qmake-utils
# @BLURB: eclass to build qbs-based packages
# @DESCRIPTION:
# Utility eclass providing wrapper functions for Qbs build system.

case ${EAPI:-0} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} unsupported."
esac

if [[ ! ${_QBS_ECLASS} ]]; then

inherit flag-o-matic multiprocessing toolchain-funcs qmake-utils

# @ECLASS_VARIABLE: QBS_COMMAND_ECHO_MODE
# @USER_VARIABLE
# @DESCRIPTION:
# Determines what kind of output to show when executing commands.  Possible
# values are:
#
# - silent
#
# - summary
#
# - command-line (the default)
#
# - command-line-with-environment
: ${QBS_COMMAND_ECHO_MODE:=command-line}

BDEPEND="
	dev-build/meson-format-array
	dev-util/qbs
"

# @FUNCTION: eqbs
# @USAGE: [<qbs args>...]
# @DESCRIPTION:
# Run Qbs. This command dies on failure.
eqbs() {
	debug-print-function ${FUNCNAME} "${@}"

	set -- qbs "${@}"
	einfo "${@}"
	"${@}" || die -n

	local ret=${?}
	return ${ret}
}

# @FUNCTION: _flags_to_js_array
# @INTERNAL
# @USAGE: [<flags>...]
# @RETURN: arguments quoted and separated by comma
_flags_to_js_array() {
	meson-format-array "${@}" || die
}

# @FUNCTION: qbs_src_configure
# @DESCRIPTION:
# Setup toolchain and Qt for the "gentoo" profile.
# Set Qbs preferences to match user settings. Configure build flags and
# installation prefix.
qbs_src_configure() {
	debug-print-function ${FUNCNAME} "${@}"

	eqbs setup-toolchains "$(tc-getCC)" gentooToolchain
	eqbs config profiles.gentooToolchain.archiverPath "$(tc-getAR)"
	eqbs config profiles.gentooToolchain.assemblerPath "$(tc-getAS)"
	eqbs config profiles.gentooToolchain.nmPath "$(tc-getNM)"
	eqbs config profiles.gentooToolchain.objcopyPath "$(tc-getOBJCOPY)"
	eqbs config profiles.gentooToolchain.stripPath "$(tc-getSTRIP)"

	eqbs setup-qt "$(qt5_get_bindir)/qmake" gentoo
	qbs_config baseProfile gentooToolchain

	qbs_config preferences.jobs "$(makeopts_jobs)"
	if [[ "${NOCOLOR}" == true || "${NOCOLOR}" == yes ]]; then
		qbs_config preferences.useColoredOutput false
	fi

	qbs_config qbs.installPrefix "${EPREFIX}/usr"
	qbs_config qbs.sysroot "${ESYSROOT}"
	qbs_config qbs.optimization ""  # don't add unwanted flags

	qbs_config cpp.cFlags "$(_flags_to_js_array ${CFLAGS})"
	qbs_config cpp.cppFlags "$(_flags_to_js_array ${CPPFLAGS})"
	qbs_config cpp.cxxFlags "$(_flags_to_js_array ${CXXFLAGS})"
	qbs_config cpp.linkerFlags "$(_flags_to_js_array $(raw-ldflags))"
}

# @FUNCTION: qbs_config
# @USAGE: <key> <value>
# @DESCRIPTION:
# Set a preference for the "gentoo" profile.
qbs_config() {
	debug-print-function ${FUNCNAME} "${@}"

	(( $# == 2 )) || \
		die "${FUNCNAME} takes exactly two arguments"

	local key=${1}
	local value=${2}

	eqbs config "profiles.gentoo.${key}" "${value}"
}

# @FUNCTION: qbs_src_compile
# @USAGE: [<qbs args>...]
# @DESCRIPTION:
# General function for compiling with qbs. All arguments are passed
# to qbs_build.
qbs_src_compile() {
	debug-print-function ${FUNCNAME} "${@}"

	qbs_build "${@}"
}

# @FUNCTION: qbs_build
# @USAGE: [<qbs args>...]
# @DESCRIPTION:
# Build the package using qbs build.
qbs_build() {
	debug-print-function ${FUNCNAME} "${@}"

	local qbsargs=(
		--no-install
		--command-echo-mode "${QBS_COMMAND_ECHO_MODE}"
		profile:gentoo
		config:release
	)

	eqbs build "${@}" "${qbsargs[@]}"
}

# @FUNCTION: qbs_src_install
# @USAGE: [<qbs args>...]
# @DESCRIPTION:
# Install the package using qbs install.
qbs_src_install() {
	debug-print-function ${FUNCNAME} "${@}"

	local qbsargs=(
		--no-build
		--install-root "${D}"
		--command-echo-mode "${QBS_COMMAND_ECHO_MODE}"
		profile:gentoo
		config:release
	)

	eqbs install "${@}" "${qbsargs[@]}"
}

_QBS_ECLASS=1
fi

EXPORT_FUNCTIONS src_configure src_compile src_install
