# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Yet another system fetch that is minimal and customizable."
HOMEPAGE="https://github.com/deepjyoti30/yaf"
SRC_URI="https://github.com/deepjyoti30/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-lang/go"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
}
