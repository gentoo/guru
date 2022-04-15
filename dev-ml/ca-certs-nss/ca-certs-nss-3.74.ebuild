# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="X.509 trust anchors extracted from Mozilla's NSS"
HOMEPAGE="https://github.com/mirage/ca-certs-nss"
SRC_URI="https://github.com/mirage/${PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	dev-ml/mirage-crypto
	dev-ml/mirage-clock
	dev-ml/x509
"
DEPEND="
	${RDEPEND}
	dev-ml/logs
	dev-ml/fmt
	dev-ml/bos
	dev-ml/astring
	dev-ml/cmdliner
	dev-ml/alcotest
"

RESTRICT="!test? ( test )"
