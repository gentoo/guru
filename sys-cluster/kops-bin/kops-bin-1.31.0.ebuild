# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Kubernetes Operations"
HOMEPAGE="https://kops.sigs.k8s.io/"
SRC_URI="https://github.com/kubernetes/${PN%-bin}/releases/download/v${PV}/kops-linux-amd64 -> ${PN%-bin}"
S="${WORKDIR}"

LICENSE="Apache-2.0 BSD-2 BSD-4 ECL-2.0 imagemagick ISC JSON MIT MIT-with-advertising MPL-2.0 unicode"
SLOT="0"
KEYWORDS="~amd64"

src_compile() { :; }

src_install() {
	dobin "${DISTDIR}/kops"
}
