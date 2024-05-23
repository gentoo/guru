# Copyright 2024 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Public domain POSIX make"
HOMEPAGE="https://frippery.org/make"
SRC_URI="https://frippery.org/make/pdpmake-1.4.2.tgz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

src_test() {
	emake test
}

src_install() {
	emake install DESTDIR="${ED}" PREFIX=/usr
}
