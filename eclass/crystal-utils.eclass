# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: crystal-utils.eclass
# @MAINTAINER:
# Anna <cyber+gentoo@sysrq.in>
# @AUTHOR:
# Anna <cyber+gentoo@sysrq.in>
# @SUPPORTED_EAPIS: 8
# @BLURB: utility functions for Crystal packages
# @DESCRIPTION:
# A utility eclass providing functions to invoke Crystal.
#
# This eclass does not set any metadata variables nor export any phase, so it
# can be inherited safely.
#
# All helper functions die on failure and support being called via 'nonfatal'.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

if [[ ! ${_CRYSTAL_UTILS_ECLASS} ]]; then
_CRYSTAL_UTILS_ECLASS=1

inherit edo flag-o-matic

# @ECLASS_VARIABLE: CRYSTAL_DEPS
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# This is an eclass-generated Crystal dependency string.
CRYSTAL_DEPS="
	|| (
		dev-lang/crystal
		dev-lang/crystal-bin
	)
"

# @ECLASS_VARIABLE: SHARDS_DEPS
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# This is an eclass-generated Shards dependency string.
SHARDS_DEPS="
	|| (
		dev-util/shards
		dev-lang/crystal-bin
	)
"

# @FUNCTION: _crystal_get_colors_opt
# @INTERNAL
# @RETURN: "--no-color" if colors should be disabled, empty string otherwise
_crystal_get_colors_opt() {
	if [[ ${NOCOLOR} == "true" || ${NOCOLOR} == "yes" ]]; then
		echo "--no-color"
	fi
}

# @FUNCTION: _crystal_get_debug_opt
# @INTERNAL
# @RETURN: "--debug" if USE=debug, "--no-debug" otherwise
_crystal_get_debug_opt() {
	if has debug ${IUSE} && use debug; then
		echo "--debug"
	else
		echo "--no-debug"
	fi
}

# @FUNCTION: crystal_configure
# @DESCRIPTION:
# Set Crystal environment variables to match user settings.
#
# Passes arguments to Crystal by reading from an optionally pre-defined local
# mycrystalargs bash array.
#
# Must be run or ecrystal/eshards will fail.
#
# @CODE
# src_configure() {
#       local mycrystalargs=(
#               -Dfoo
#       )
#       crystal_configure
# }
# @CODE
crystal_configure() {
	debug-print-function ${FUNCNAME} "${@}"

	# avoid possible sandbox violation
	export CRYSTAL_CACHE_DIR="${T}/crystal"
	export SHARDS_CACHE_PATH="${T}/shards"

	[[ -z ${mycrystalargs} ]] && local -a mycrystalargs=()
	local mycrystalargstype=$(declare -p mycrystalargs 2>&-)
	if [[ "${mycrystalargstype}" != "declare -a mycrystalargs="* ]]; then
		die "mycrystalargs must be declared as array"
	fi

	local args=(
		--link-flags="\"${LDFLAGS}\""
		--release
		--progress
		$(_crystal_get_debug_opt)
		$(_crystal_get_colors_opt)
		$(is-flagq -mcpu && echo "--mcpu=$(get-flag mcpu)")
		$(is-flagq -mcmodel && echo "--mcmodel=$(get-flag mcmodel)")
		# TODO: --mattr
		"${mycrystalargs[@]}"
	)

	export CRYSTAL_OPTS="${args[@]}"

	_CRYSTAL_CONFIGURE_HAS_RUN=1
}

# @FUNCTION: ecrystal
# @USAGE: [<args>...]
# @DESCRIPTION:
# Call crystal, passing supplied arguments.
ecrystal() {
	debug-print-function ${FUNCNAME} "${@}"

	[[ ${_CRYSTAL_CONFIGURE_HAS_RUN} ]] || \
		die "${FUNCNAME}: crystal_configure has not been run"

	mkdir -p "${CRYSTAL_CACHE_DIR}" || die "Creating Crystal cache dir failed"
	edo crystal "${@}"
}

# @FUNCTION: eshards
# @USAGE: [<args>...]
# @DESCRIPTION:
# Call shards, passing the standard set of options, then supplied arguments.
eshards() {
	debug-print-function ${FUNCNAME} "${@}"

	[[ ${_CRYSTAL_CONFIGURE_HAS_RUN} ]] || \
		die "${FUNCNAME}: crystal_configure has not been run"

	mkdir -p "${CRYSTAL_CACHE_DIR}" || die "Creating Crystal cache dir failed"
	mkdir -p "${SHARDS_CACHE_PATH}" || die "Creating Shards cache dir failed"

	local args=(
		--local
		--without-development
		$(_crystal_get_colors_opt)
	)

	edo shards "${args[@]}" "${@}"
}

fi
