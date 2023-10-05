# Copyright 2019-2023 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: mix.eclass
# @MAINTAINER:
# Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# @AUTHOR:
# Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# @SUPPORTED_EAPIS: 6 7 8
# @BLURB: Build Elixir projects using Elixir's mix
# @DESCRIPTION:
# An eclass providing functions to build Elixir projects using Elixir's mix
#
# mix is a tool which tries to resolve dependencies itself

case "${EAPI:-0}" in
	0|1|2|3|4|5)
		die "Unsupported EAPI=${EAPI:-0} (too old) for ${ECLASS}"
		;;
	6|7)
		;;
	*)
		die "Unsupported EAPI=${EAPI} (unknown) for ${ECLASS}"
		;;
esac

EXPORT_FUNCTIONS src_prepare src_compile src_install

RDEPEND="
	dev-lang/elixir
	dev-lang/erlang:=
"
DEPEND="${RDEPEND}"

# Erlang/Elixir software fails to build when another version with API 
# differences is present
BDEPEND="!<${CATEGORY}/${P} !>${CATEGORY}/${PF}"

# @ECLASS_VARIABLE: HEX_OFFLINE
HEX_OFFLINE=1

# @ECLASS_VARIABLE: MIX_ENV
MIX_ENV="prod"

# @ECLASS_VARIABLE: MIX_NO_DEPS
MIX_NO_DEPS=1

# @FUNCTION: emix
# @USAGE: <targets>
# @DESCRIPTION:
# Run mix with provided arguments. Die on failure
emix() {
	debug-print-function ${FUNCNAME} "${@}"

	(( $# > 0 )) || die "emix: at least one target is required"

	MIX_ENV="${MIX_ENV}" mix "$@" || die -n "mix $@ failed"
}

# @ECLASS_VARIABLE: MIX_REWRITE
MIX_REWRITE=""

# @ECLASS_VARIABLE: MIX_BUILD_NAME
MIX_BUILD_NAME="${MIX_ENV}"

# @FUNCTION: mix_src_prepare
mix_src_prepare() {
	if [[ "${MIX_REWRITE}" != "" ]]
	then
		sed -i -E -e 's@\{.*(only|optional): .*},?@@' mix.exs || die "failed removing only & optionnal deps"
		rm -f mix.lock
	fi

	default
}

# @FUNCTION: mix_src_compile
# @DESCRIPTION:
# Compile project with mix.
mix_src_compile() {
	debug-print-function ${FUNCNAME} "${@}"

	emix compile --no-deps-check
}

# @FUNCTION: mix_src_install
# @DESCRIPTION:
# Install project with mix.
mix_src_install() {
	debug-print-function ${FUNCNAME} "${@}"

	insinto "/usr/$(get_libdir)/elixir/lib/${P}"
	pushd "_build/${MIX_BUILD_NAME}/lib/${PN}" >/dev/null
	for reldir in src ebin priv include; do
		[ -d "$reldir" ] && doins -r "$(realpath ${reldir})"
	done
	popd >/dev/null
}
