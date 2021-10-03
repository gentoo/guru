# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_COMMIT="22f58922da16c3b94d293d98a07cb7caa7a019e8"
DESCRIPTION="A simple async wrapper around CURL for C++"
HOMEPAGE="https://nheko.im/nheko-reborn/coeurl"
SRC_URI="https://nheko.im/nheko-reborn/coeurl/-/archive/${MY_COMMIT}/${PN}-${MY_COMMIT}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # Tests turned off because they need a local webserver.

RDEPEND="
	net-misc/curl
	dev-libs/libevent
	dev-libs/spdlog
"
DEPEND="${RDEPEND}"
