# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: shards.eclass
# @MAINTAINER:
# Anna <cyber+gentoo@sysrq.in>
# @AUTHOR:
# Anna <cyber+gentoo@sysrq.in>
# @SUPPORTED_EAPIS: 8
# @PROVIDES: crystal-utils
# @BLURB: eclass to build Crystal packages using Shards
# @DESCRIPTION:
# This eclass contains the default phase function for packages which use Crystal
# Shards as a build system.
#
# If the package has no shard.yml(5) file, use crystal-utils.eclass(5) instead.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

if [[ ! ${_SHARDS_ECLASS} ]]; then
_SHARDS_ECLASS=1

inherit crystal-utils multiprocessing toolchain-funcs

BDEPEND="
	${CRYSTAL_DEPS}
	${SHARDS_DEPS}
	>=dev-util/gshards-0.2
"
IUSE="debug doc"

# Crystal packages do not use CFLAGS
QA_FLAGS_IGNORED='.*'

# @FUNCTION: shards_get_libdir
# @RETURN: the library path for Crystal packages
shards_get_libdir() {
	echo /usr/lib/shards
}

# @FUNCTION: shards_get_pkgname
# @RETURN: the package name as specified in shard.yml
shards_get_pkgname() {
	debug-print-function ${FUNCNAME} "${@}"

	gshards-get-pkgname || die "Parsing package name failed"
}

# @FUNCTION: shards_src_configure
# @DESCRIPTION:
# Function for configuring Crystal to match user settings.
shards_src_configure() {
	debug-print-function ${FUNCNAME} "${@}"

	crystal_configure
	debug-print "CRYSTAL_OPTS='${CRYSTAL_OPTS}'"

	export SHARDS_INSTALL_PATH="${BROOT}$(shards_get_libdir)"
	export CRYSTAL_PATH="${SHARDS_INSTALL_PATH}:$(crystal env CRYSTAL_PATH || die "'crystal env' failed")"
	debug-print "CRYSTAL_PATH='${CRYSTAL_PATH}'"

	tc-export CC
}

# @FUNCTION: shards_src_compile
# @DESCRIPTION:
# Function for building the package's executables and documentation.
shards_src_compile() {
	debug-print-function ${FUNCNAME} "${@}"

	local args
	gshards-print-targets | while read -r args; do
		crystal_build "${@}" ${args}
	done

	if use doc; then
		ecrystal docs
		HTML_DOCS=( docs/. )
	fi

	return 0
}

# @FUNCTION: shards_src_test
# @USAGE: [<args>...]
# @DESCRIPTION:
# Function for testing the package.
shards_src_test() {
	debug-print-function ${FUNCNAME} "${@}"

	if [[ -d "spec" ]]; then
		crystal_spec "${@}"
	fi

	return 0
}

# @FUNCTION: shards_src_install
# @DESCRIPTION:
# Function for installing the package's source.
shards_src_install() {
	debug-print-function ${FUNCNAME} "${@}"

	if [[ -d "src" ]]; then
		insinto $(shards_get_libdir)/$(shards_get_pkgname)
		doins -r src
		doins shard.yml
	fi

	einstalldocs
}

fi

EXPORT_FUNCTIONS src_configure src_compile src_test src_install
