# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Installs Ruby, JRuby, Rubinius, TruffleRuby, or MRuby."
HOMEPAGE="https://github.com/postmodern/ruby-install"
SRC_URI="https://github.com/postmodern/ruby-install/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

PROPERTIES="test_network"
RESTRICT="!test? ( test )"

DEPEND=">=app-shells/bash-3.0:*"
RDEPEND="${DEPEND}
	sys-apps/grep
	|| ( >net-misc/wget-1.12 net-misc/curl )
	dev-libs/openssl
	app-arch/tar
	app-arch/bzip2
	app-arch/xz-utils
	sys-devel/patch
	|| ( >=sys-devel/gcc-4.2 sys-devel/clang )"
BDEPEND="test? ( dev-util/shunit2 )"

# BUG: `make check` fails: https://github.com/postmodern/ruby-install/issues/442
src_test() {
	emake test
}

src_prepare() {
	default

	sed -i Makefile -e "s/^VERSION=${PV}$/VERSION=${PVR}/" \
		|| die "Cannot fix doc location to follow Gentoo/FHS guidelines"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
