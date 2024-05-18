# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="c4e89ab30116fbe22cb9fed4e22f4340fdbcfc4d"
DESCRIPTION="Tools to customize speakup module"
HOMEPAGE="https://salsa.debian.org/a11y-team/speakup-tools"
SRC_URI="https://salsa.debian.org/a11y-team/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	:
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}"/usr install
	einstalldocs
}
