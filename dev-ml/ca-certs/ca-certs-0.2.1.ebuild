# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_P="${PN}-v${PV}"

DESCRIPTION="Detect root CA certificates from the operating system"
HOMEPAGE="https://github.com/mirage/ca-certs"
SRC_URI="https://github.com/mirage/${PN}/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	dev-ml/astring
	dev-ml/bos
	dev-ml/fpath
	dev-ml/ptime
	dev-ml/logs
	dev-ml/mirage-crypto
	dev-ml/x509
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/alcotest
		dev-ml/fmt
	)
"

RESTRICT="!test? ( test )"
