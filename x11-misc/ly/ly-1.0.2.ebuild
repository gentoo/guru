# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo pam systemd prefix

DESCRIPTION="Ly - a TUI display manager"
HOMEPAGE="https://github.com/fairyglade/ly"

CLAP="8c98e6404b22aafc0184e999d8f068b81cc22fa1"
ZIGINI="0bba97a12582928e097f4074cc746c43351ba4c8"
ZIGLIBINI="e18d36665905c1e7ba0c1ce3e8780076b33e3002"

SRC_URI="
	https://github.com/fairyglade/ly/archive/v${PV}/${P}.tar.gz
	https://github.com/Hejsil/zig-clap/archive/${CLAP}.tar.gz -> zig-clap-${CLAP}.tar.gz
	https://github.com/Kawaii-Ash/zigini/archive/${ZIGINI}.tar.gz -> zigini-${ZIGINI}.tar.gz
	https://github.com/ziglibs/ini/archive/${ZIGLIBINI}.tar.gz -> ziglibini-${ZIGLIBINI}.tar.gz
"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"

EZIG_MIN="0.12"
EZIG_MAX_EXCLUSIVE="0.13"

DEPEND="
	|| ( dev-lang/zig-bin:${EZIG_MIN} dev-lang/zig:${EZIG_MIN} )
	sys-libs/pam
	x11-libs/libxcb
"
RDEPEND="
	x11-base/xorg-server
	x11-apps/xauth
	x11-apps/xrdb
	x11-apps/xmessage
	sys-libs/ncurses
"

# https://github.com/ziglang/zig/issues/3382
QA_FLAGS_IGNORED="usr/bin/ly"

RES="${S}/res"

# copied from sys-fs/ncdu::gentoo
# Many thanks to Florian Schmaus (Flowdalic)!
# Adapted from https://github.com/gentoo/gentoo/pull/28986
# Set the EZIG environment variable.
zig-set_EZIG() {
	[[ -n ${EZIG} ]] && return

	if [[ -n ${EZIG_OVERWRITE} ]]; then
		export EZIG="${EZIG_OVERWRITE}"
		return
	fi

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

ezig() {
	zig-set_EZIG
	edo "${EZIG}" "${@}"
}

src_unpack() {
	default

	mkdir "${WORKDIR}/deps" || die
	ezig fetch --global-cache-dir "${WORKDIR}/deps" "${DISTDIR}/zig-clap-${CLAP}.tar.gz"
	ezig fetch --global-cache-dir "${WORKDIR}/deps" "${DISTDIR}/zigini-${ZIGINI}.tar.gz"
	ezig fetch --global-cache-dir "${WORKDIR}/deps" "${DISTDIR}/ziglibini-${ZIGLIBINI}.tar.gz"
}

src_prepare(){
	default
	# Adjusting absolute paths in the following files to use Gentoo's ${EPREFIX}
	hprefixify "${RES}/config.ini" "${RES}/xsetup.sh" "${RES}/wsetup.sh"
}

src_compile() {
	# Building ly & accomodate for prefixed environment
	ezig build --system "${WORKDIR}/deps/p" -Doptimize=ReleaseSafe -Ddata_directory="${EPREFIX}/etc/ly"
}

src_install() {
	dobin "${S}/zig-out/bin/${PN}"
	newinitd "${RES}/${PN}-openrc" ly
	systemd_dounit "${RES}/${PN}.service"
	insinto /etc/ly
	doins "${RES}/config.ini" "${RES}/xsetup.sh" "${RES}/wsetup.sh"
	insinto /etc/ly/lang
	doins "${RES}"/lang/*.ini
	newpamd "${RES}/pam.d/ly" ly
	fperms +x /etc/${PN}/{x,w}setup.sh
}

pkg_postinst() {
	systemd_reenable "${PN}.service"

	ewarn
	ewarn "The init scripts are installed only for systemd/openrc"
	ewarn "If you are using something else like runit etc."
	ewarn "Please check upstream for get some help"
	ewarn "You may need to take a look at /etc/ly/config.ini"
	ewarn "If you are using a window manager as DWM"
	ewarn "Please make sure there is a .desktop file in /usr/share/xsessions for it"
}
