# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: nimble.eclass
# @MAINTAINER:
# Anna Vyalkova <cyber+gentoo@sysrq.in>
# @AUTHOR:
# Anna Vyalkova <cyber+gentoo@sysrq.in>
# @SUPPORTED_EAPIS: 8
# @PROVIDES: nim-utils
# @BLURB: eclass to build Nim packages that use nimble as a build system
# @EXAMPLE:
# Typical ebuild for a Nim application:
#
# EAPI=8
#
# inherit nimble
#
# ...
#
# DEPEND="dev-nim/foo"
#
# src_compile() {
# 	nimble_src_compile
# 	nimble_build scss
# }
#
# ...
#
#
# Typical ebuild for a Nim library:
#
# EAPI=8
#
# inherit nimble
#
# ...
# SLOT=${PV}
#
# RDEPEND="
# 	dev-nim/bar
# 	dev-nim/baz
# "
#
# set_package_url "https://github.com/example/example"


case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

if [[ ! ${_NIMBLE_ECLASS} ]]; then

# @ECLASS_VARIABLE: BUILD_DIR
# @DEFAULT_UNSET
# @DESCRIPTION:
# Build directory, location where all generated files should be placed.
# If this isn't set, it defaults to ${WORKDIR}/${P}-build.

# @ECLASS_VARIABLE: NINJA
# @INTERNAL
# @DESCRIPTION:
# Force ninja because samu doesn't work correctly.
NINJA="ninja"

inherit nim-utils ninja-utils

BDEPEND="${NINJA_DEPEND}
	dev-lang/nim[experimental(-)]
	>=dev-nim/nimbus-1.0.0
"

# @FUNCTION: set_package_url
# @USAGE: <url>
# @DESCRIPTION:
# If this function is called, nimbus will generate and install a nimblemeta.json
# file.  Some packages specify their dependencies using URLs and nimbus is
# unable to find them unless a metadata file exists.
set_package_url() {
	debug-print-function ${FUNCNAME} "${@}"

	(( $# == 1 )) || \
		die "${FUNCNAME} takes exactly one argument"

	_PACKAGE_URL="${1}"
}

# @FUNCTION: get_package_url
# @USAGE:
# @INTERNAL
# @RETURN: package URL
get_package_url() {
	echo "${_PACKAGE_URL}"
}

# @FUNCTION: nimble_comment_requires
# @USAGE: <dep...>
# @DESCRIPTION:
# Comment out one or more 'requires' calls in the Nimble file.
nimble_comment_requires() {
	debug-print-function ${FUNCNAME} "${@}"

	local dep
	for dep in "${@}"; do
		dep=${dep//\//\\/}
		sed "/requires[[:space:]]*\"${dep}\>.*\"/ s/^/#/" -i *.nimble || die
	done
}

# @FUNCTION: nimble_src_configure
# @USAGE:
# @DESCRIPTION:
# Configure the package with nimbus.  This will start an out-of-source build.
# Passes arguments to Nim by reading from an optionally pre-defined local
# mynimargs bash array.
# @CODE
# src_configure() {
#       local mynimargs=(
#               --threads:on
#       )
#       nimble_src_configure
# }
# @CODE
nimble_src_configure() {
	debug-print-function ${FUNCNAME} "${@}"

	[[ -n "${NINJA_DEPEND}" ]] || \
		ewarn "Unknown value '${NINJA}' for \${NINJA}"

	BUILD_DIR="${BUILD_DIR:-${WORKDIR}/${P}-build}"

	[[ -z ${mynimargs} ]] && local -a mynimargs=()
	local mynimargstype=$(declare -p mynimargs 2>&-)
	if [[ "${mynimargstype}" != "declare -a mynimargs="* ]]; then
		die "mynimargs must be declared as array"
	fi

	nim_gen_config

	local nimbusargs=(
		--nimbleDir:"${EPREFIX}"/opt/nimble
		--binDir:"${EPREFIX}"/usr/bin
		--useDepfile
		"${mynimargs[@]}"
	)

	[[ -n "$(get_package_url)" ]] && \
		nimbusargs+=( --url:"$(get_package_url)" )

	set -- nimbus "${nimbusargs[@]}" "${S}" "${BUILD_DIR}"
	echo "${@}" >&2
	"${@}" || die "${*} failed"
}

# @FUNCTION: nimble_build
# @USAGE: [ninja args...]
# @DESCRIPTION:
# Function for building the package.  All arguments are passed to eninja.
nimble_build() {
	debug-print-function ${FUNCNAME} "${@}"

	eninja -C "${BUILD_DIR}" "${@}"
}

# @FUNCTION: nimble_src_compile
# @USAGE: [ninja args...]
# @DESCRIPTION:
# Build the package with Ninja.  All arguments are passed to nimble_build.
nimble_src_compile() {
	debug-print-function ${FUNCNAME} "${@}"

	nimble_build "${@}"
}

# @FUNCTION: nimble_src_test
# @USAGE: [ninja args...]
# @DESCRIPTION:
# Test the package.  All arguments are passed to nimble_build.
nimble_src_test() {
	debug-print-function ${FUNCNAME} "${@}"

	if nonfatal nimble_build test -n &> /dev/null; then
		nimble_build test "${@}"
	fi
}

# @FUNCTION: nimble_src_install
# @DESCRIPTION:
# Install the package with Ninja.  All arguments are passed to nimble_build.
nimble_src_install() {
	debug-print-function ${FUNCNAME} "${@}"

	DESTDIR="${D}" nimble_build install "${@}"
	einstalldocs
}

_NIMBLE_ECLASS=1
fi

EXPORT_FUNCTIONS src_configure src_compile src_test src_install
