# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="X.509 trust anchors extracted from Mozilla's NSS"
HOMEPAGE="
	https://github.com/mirage/ca-certs-nss
	https://opam.ocaml.org/packages/ca-certs-nss/
"
SRC_URI="https://github.com/mirage/${PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	dev-ml/mirage-crypto:=
	>=dev-ml/mirage-clock-3.0.0:=
	>=dev-ml/x509-0.15.0:=
"
DEPEND="
	${RDEPEND}
	dev-ml/logs
	>=dev-ml/fmt-0.8.7
	dev-ml/bos
	dev-ml/astring
	>=dev-ml/cmdliner-1.1.0
	dev-ml/alcotest
"

RESTRICT="!test? ( test )"
