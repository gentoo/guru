# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Implementation of quoted-printable encoder/decoder from RFC2045"
HOMEPAGE="https://github.com/mirage/pecu"
SRC_URI="https://github.com/mirage/${PN}/releases/download/v${PV}/${PN}-v${PV}.tbz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

DEPEND="
	test? (
		dev-ml/alcotest
		dev-ml/astring
		dev-ml/crowbar
		dev-ml/fmt
	)
"

RESTRICT="!test? ( test )"
