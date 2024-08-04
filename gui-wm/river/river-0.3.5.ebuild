# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://isaacfreund.com/software/river/"

SRC_URI="
	https://codeberg.org/river/river/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://codeberg.org/ifreund/zig-pixman/archive/v0.2.0.tar.gz -> zig-pixman-0.2.0.tar.gz
	https://codeberg.org/ifreund/zig-wayland/archive/v0.2.0.tar.gz -> zig-wayland-0.2.0.tar.gz
	https://codeberg.org/ifreund/zig-wlroots/archive/v0.18.0.tar.gz -> zig-wlroots-0.18.0.tar.gz
	https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.2.0.tar.gz -> zig-xkbcommon-0.2.0.tar.gz
"
S="${WORKDIR}/${PN}"

PATCHES=(
	"${FILESDIR}/${P}-build-zig-zon.patch"
	"${FILESDIR}/${P}-zig-0.12.0.patch"
)

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+llvm +man pie xwayland bash-completion zsh-completion fish-completion"

EZIG_MIN="0.12"
EZIG_MAX_EXCLUSIVE="0.13"

DEPEND="
	|| ( dev-lang/zig-bin:${EZIG_MIN} dev-lang/zig:${EZIG_MIN} )
	dev-libs/wayland
	gui-libs/wlroots:0.18
	xwayland? ( x11-base/xwayland )
	x11-libs/libxkbcommon
	x11-libs/pixman
"
RDEPEND="${DEPEND}"

DOCS=( README.md )

# https://github.com/ziglang/zig/issues/3382
QA_FLAGS_IGNORED="usr/bin/*"

# Many thanks to Florian Schmaus (Flowdalic)!
# Adapted from https://github.com/gentoo/gentoo/pull/28986
# Set the EZIG environment variable.
zig-set_EZIG() {
	[[ -n ${EZIG} ]] && return

	local candidate selected selected_ver ver

	for candidate in "${BROOT}"/usr/bin/zig-*; do
		if [[ ! -L ${candidate} || ${candidate} != */zig?(-bin)-+([0-9.]) ]]; then
			continue
		fi

		ver=${candidate##*-}

		if [[ -n ${EZIG_EXACT_VER} ]]; then
			ver_test "${ver}" -ne "${EZIG_EXACT_VER}" && continue

			selected="${candidate}"
			selected_ver="${ver}"
			break
		fi

		if [[ -n ${EZIG_MIN} ]] \
			   && ver_test "${ver}" -lt "${EZIG_MIN}"; then
			# Candidate does not satisfy EZIG_MIN condition.
			continue
		fi

		if [[ -n ${EZIG_MAX_EXCLUSIVE} ]] \
			   && ver_test "${ver}" -ge "${EZIG_MAX_EXCLUSIVE}"; then
			# Candidate does not satisfy EZIG_MAX_EXCLUSIVE condition.
			continue
		fi

		if [[ -n ${selected_ver} ]] \
			   && ver_test "${selected_ver}" -gt "${ver}"; then
			# Candidate is older than the currently selected candidate.
			continue
		fi

		selected="${candidate}"
		selected_ver="${ver}"
	done

	if [[ -z ${selected} ]]; then
		die "Could not find (suitable) zig installation in ${BROOT}/usr/bin"
	fi

	export EZIG="${selected}"
	export EZIG_VER="${selected_ver}"
}

# Invoke zig with the optionally provided arguments.
ezig() {
	zig-set_EZIG

	edo "${EZIG}" "${@}"
}

src_unpack() {
	default

	mkdir "${S}/deps" || die
	mv zig-pixman "${S}/deps" || die
	mv zig-wayland "${S}/deps" || die
	mv zig-wlroots "${S}/deps" || die
	mv zig-xkbcommon "${S}/deps" || die
}

src_configure() {
	export ZBS_ARGS=(
		--prefix usr/
		-Doptimize=ReleaseSafe

		-Dpie=$(usex pie true false)
		-Dno-llvm=$(usex llvm false true)
		-Dman-pages=$(usex man true false)
		-Dbash-completion=$(usex bash-completion true false)
		-Dzsh-completion=$(usex zsh-completion true false)
		-Dfish-completion=$(usex fish-completion true false)
		-Dxwayland=$(usex xwayland true false)
	)
}

src_compile() {
	ezig build "${ZBS_ARGS[@]}"
}

src_test() {
	ezig build test "${ZBS_ARGS[@]}"
}

src_install() {
	DESTDIR="${ED}" ezig build install "${ZBS_ARGS[@]}"
	einstalldocs

	insinto /usr/share/wayland-sessions
	doins contrib/river.desktop

	insinto /usr/share/${PN}
	doins -r example
}
