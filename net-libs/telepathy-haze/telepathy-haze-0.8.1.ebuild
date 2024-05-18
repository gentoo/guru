# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit python-any-r1

DESCRIPTION="Telepathy connection manager providing libpurple supported protocols"
HOMEPAGE="
	https://telepathy.freedesktop.org
	https://developer.pidgin.im/wiki/TelepathyHaze
"
SRC_URI="https://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	net-im/pidgin[dbus]
	net-libs/telepathy-glib
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-libs/libxslt
	dev-util/glib-utils
"

BDEPEND="
	virtual/pkgconfig
	test? (
		dev-python/pygobject:3
		$(python_gen_any_dep 'dev-python/twisted[${PYTHON_USEDEP}]')
	)
"

RESTRICT="!test? ( test )"

python_check_deps() {
	if use test ; then
		python_has_version "dev-python/twisted[${PYTHON_USEDEP}]"
	fi
}
