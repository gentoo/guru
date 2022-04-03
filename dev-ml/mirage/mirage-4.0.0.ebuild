# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="MirageOS is a library operating system that constructs unikernels"
HOMEPAGE="
	https://mirage.io/
	https://github.com/mirage/mirage
"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/ipaddr
	dev-ml/bos
	dev-ml/astring
	dev-ml/logs
	dev-ml/lwt
	dev-ml/emile
	dev-ml/cmdliner
	dev-ml/base
	dev-ml/result
	dev-ml/rresult
	dev-ml/uri
"
DEPEND="${RDEPEND}"

src_install() {
	dune_src_install mirage
	dune_src_install mirage-runtime
	dune_src_install functoria
	dune_src_install functoria-runtime
}
