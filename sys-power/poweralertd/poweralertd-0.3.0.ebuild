# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="UPower-powered power alerter"
HOMEPAGE="https://sr.ht/~kennylevinsen/poweralertd/"
SRC_URI="https://git.sr.ht/~kennylevinsen/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="elogind systemd"
REQUIRED_USE="?? ( elogind systemd )"

RDEPEND="
	sys-apps/dbus
	sys-power/upower
	elogind? ( sys-auth/elogind )
	systemd? ( sys-apps/systemd )
	!elogind? ( !systemd? ( sys-libs/basu ) )
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-text/scdoc
	virtual/pkgconfig
"

src_prepare() {
	default

	# Upstream probes basu, libelogind and libsystemd in that order and
	# links against whichever turns up first; make it follow the USE
	# flag
	if use systemd; then
		sed -i -e 's/^if basu.found()/if false/' \
			-e 's/^elif elogind.found()/elif false/' meson.build || die
	elif use elogind; then
		sed -i -e 's/^if basu.found()/if false/' meson.build || die
	fi
}

src_configure() {
	local emesonargs=(
		-Dman-pages=enabled
	)

	meson_src_configure
}
