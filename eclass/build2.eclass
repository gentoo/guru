# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: build2.eclass
# @MAINTAINER:
# Anna Vyalkova <cyber+gentoo@sysrq.in>
# @AUTHOR:
# Anna Vyalkova <cyber+gentoo@sysrq.in>
# @SUPPORTED_EAPIS: 8
# @BLURB: eclass for packages using build2
# @DESCRIPTION:
# Utility eclass providing wrapper functions for the build2 build system along
# with default phase functions.

case ${EAPI:-0} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} unsupported."
esac

if [[ ! ${_BUILD2_ECLASS} ]]; then

inherit edo multiprocessing toolchain-funcs

fi

EXPORT_FUNCTIONS src_configure src_compile src_test src_install

if [[ ! ${_BUILD2_ECLASS} ]]; then

# @ECLASS_VARIABLE: BUILD2_VERBOSITY
# @USER_VARIABLE
# @DESCRIPTION:
# Determines what kind of output to show when executing commands.  All possible
# options are listed in b(1).
: ${BUILD2_VERBOSITY:=2}

BDEPEND="dev-util/build2"

# @FUNCTION: build2_src_configure
# @DESCRIPTION:
# Set build2 preferences to match user settings.  Configure toolchain, build
# flags and installation prefix.
build2_src_configure() {
	debug-print-function ${FUNCNAME} "${@}"

	[[ -z ${mybargs} ]] && declare -a mybargs=()
	local mybargstype=$(declare -p mybargs 2>&-)
	if [[ "${mybargstype}" != "declare -a mybargs="* ]]; then
		die "mybargs must be declared as array"
	fi

	local bargs=(
		config.cxx="$(tc-getCXX)"
		config.cxx.coptions="${CXXFLAGS}"
		config.cxx.loptions="${LDFLAGS}"
		config.c="$(tc-getCC)"
		config.cc.coptions="${CFLAGS}"
		config.cc.loptions="${LDFLAGS}"
		config.bin.ar="$(tc-getAR)"
		config.bin.ranlib="$(tc-getRANLIB)"
		config.bin.lib=shared
		config.install.root="${EPREFIX}"/usr
		config.install.lib="${EPREFIX}"/usr/$(get_libdir)
		config.install.doc="${EPREFIX}"/usr/share/doc/${PF}
		"${mybargs[@]}"
		--jobs $(makeopts_jobs)
		--verbose "${BUILD2_VERBOSITY}"
	)

	edo b configure "${bargs[@]}"
}

# @FUNCTION: build2_src_compile
# @USAGE: [<b args>...]
# @DESCRIPTION:
# General function for compiling with build2.  Tests are built conditionally.
build2_src_compile() {
	debug-print-function ${FUNCNAME} "${@}"

	local build_tests=no
	local bargs=(
		"${@}"
		--jobs $(makeopts_jobs)
		--verbose "${BUILD2_VERBOSITY}"
	)

	edo b update-for-install "${bargs[@]}"
	has test ${FEATURES} && edo b update-for-test "${bargs[@]}"
}

# @FUNCTION: build2_src_test
# @USAGE: [<b args>...]
# @DESCRIPTION:
# Test the package using "b test".
build2_src_test() {
	debug-print-function ${FUNCNAME} "${@}"

	local bargs=(
		"${@}"
		--jobs $(makeopts_jobs)
		--verbose "${BUILD2_VERBOSITY}"
	)

	edo b test "${bargs[@]}"
}

# @FUNCTION: build2_src_install
# @USAGE: [<b args>...]
# @DESCRIPTION:
# Install the package using "b install".
build2_src_install() {
	debug-print-function ${FUNCNAME} "${@}"

	local bargs=(
		config.install.chroot="${D}"
		"${@}"
		--jobs $(makeopts_jobs)
		--verbose "${BUILD2_VERBOSITY}"
	)

	edo b install "${bargs[@]}"
	einstalldocs
}

# @FUNCTION: build2_pkg_die
# @INTERNAL
# @DESCRIPTION:
# EBUILD_DEATH_HOOK function to display a warning if ccache is enabled.

if ! has build2_pkg_die ${EBUILD_DEATH_HOOKS}; then
	EBUILD_DEATH_HOOKS="${EBUILD_DEATH_HOOKS} build2_pkg_die"
fi

build2_pkg_die() {
	if [[ "${EBUILD_PHASE}" != "compile" ]]; then
		return
	fi

	if has ccache ${FEATURES}; then
		# build2 doesn't support ccache:
		# https://github.com/build2/build2/issues/86#issuecomment-647401742
		ewarn
		ewarn "!!! You have enabled ccache. Please try disabling ccache"
		ewarn "!!! before reporting a bug."
		ewarn
	fi
}

_BUILD2_ECLASS=1
fi
