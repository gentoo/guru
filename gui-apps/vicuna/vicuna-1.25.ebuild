# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tool for uploading files to Wikimedia Commons and other Wikimedia projects"
HOMEPAGE="https://commons.wikimedia.org/wiki/Commons:Vicu%C3%B1aUploader"

SRC_URI="https://github.com/yarl/${PN}/releases/download/${PV}/${PN}-${PV}.tar"
KEYWORDS="~amd64"

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="
	virtual/jre
"

S="${WORKDIR}"

src_install() {
	local apphome="/opt/${PN}"
	mkdir -p "${ED}/${apphome}"

	cp -r . "${ED}"/opt || die

	dosym ${apphome}/bin/vicuna /usr/bin/vicuna
}
