# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_COMMIT="fda30fba867c08c82dbbecbcc72120652e40d5cb"

DESCRIPTION="Simple library to speed up or slow down speech"
HOMEPAGE="https://github.com/waywardgeek/sonic"
SRC_URI="https://github.com/waywardgeek/sonic/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	emake \
		DESTDIR="${ED}" \
		LIBDIR="/usr/$(get_libdir)" \
		install
}
