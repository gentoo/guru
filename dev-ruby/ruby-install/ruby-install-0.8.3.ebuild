# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Installs Ruby, JRuby, Rubinius, TruffleRuby (native / GraalVM), or mruby."
HOMEPAGE="https://github.com/postmodern/ruby-install"
SRC_URI="https://github.com/postmodern/ruby-install/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=app-shells/bash-3.0:*"
RDEPEND="${DEPEND}
	sys-apps/grep
	|| ( >net-misc/wget-1.12 net-misc/curl )
	dev-libs/openssl
	app-arch/tar
	app-arch/bzip2
	sys-devel/patch
	|| ( >=sys-devel/gcc-4.2 sys-devel/clang )"

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
