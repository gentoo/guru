# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Unviersal markup converter pandoc without ~170 haskell dependencies"

HOMEPAGE="https://github.com/jgm/pandoc"

SRC_URI="
	https://github.com/jgm/pandoc/archive/${PV}.tar.gz -> ${P}-source.tar.gz
	amd64? ( https://github.com/jgm/pandoc/releases/download/${PV}/pandoc-${PV}-linux-amd64.tar.gz -> ${P}-amd64.tar.gz )
	arm64? ( https://github.com/jgm/pandoc/releases/download/${PV}/pandoc-${PV}-linux-arm64.tar.gz -> ${P}-arm64.tar.gz )
"

# License of the package.  This must match the name of file(s) in the
# licenses/ directory.  For complex license combination see the developer
# docs on gentoo.org for details.
LICENSE="GPL-2+ BSD GPL-3+ WTFPL MIT"

SLOT="0"
DEPEND="!!app-text/pandoc"

KEYWORDS="-* ~amd64 ~arm64"
S="${WORKDIR}/pandoc-${PV}"

src_compile() {
	true
}

src_install() {

	gunzip "${S}/share/man/man1/pandoc.1.gz"

	doman "${S}/share/man/man1/pandoc.1"
	dobin "${S}/bin/pandoc"

	insinto /usr/share/pandoc
	doins -r "${WORKDIR}/pandoc-${PV}/data"
	doins COPYRIGHT
	dodoc MANUAL.txt
}
