# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/dictd/dict}"
DEB="${MY_PN}_${PV}-6.4_all.deb"

DESCRIPTION="Grady Ward's Moby Thesaurus; 35000 root words and 2.5 million synonyms"
HOMEPAGE="https://tracker.debian.org/pkg/dict-moby-thesaurus"
SRC_URI="mirror://debian/pool/main/d/${MY_PN}/${DEB}"
S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=app-text/dictd-1.13.0-r3"

src_unpack () {
	unpack "${DEB}"
	unpack "${WORKDIR}/data.tar.xz"
	pushd "${WORKDIR}/usr/share/doc/${MY_PN}" || die
	for f in *.gz; do
		gunzip "${f}" || die
	done
	rm -r copyright || die
}

src_install () {
	dodoc usr/share/doc/dict-moby-thesaurus/*
	insinto /usr/share/dict
	doins usr/share/dictd/*
}
