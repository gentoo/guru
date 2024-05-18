# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Kubernetes Operations"
HOMEPAGE="https://kops.sigs.k8s.io/ https://github.com/kubernetes/kops"
SRC_URI="https://github.com/kubernetes/${PN%-bin}/releases/download/v${PV}/kops-linux-amd64 -> ${P}.bin"

LICENSE="Apache-2.0 BSD-2 BSD-4 ECL-2.0 imagemagick ISC JSON MIT MIT-with-advertising MPL-2.0 unicode"
SLOT="0"
KEYWORDS="~amd64"

src_unpack() {
	mkdir -p -- "${S}"
	cp -- "${DISTDIR}/${A}" "${S}/${PN%-bin}"
}

src_compile() { :; }

src_install() {
	dobin "${S}/${PN%-bin}"
}
