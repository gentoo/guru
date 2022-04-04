# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_P="rpclib-${PV}"

DESCRIPTION="Light library to deal with RPCs in OCaml"
HOMEPAGE="https://github.com/mirage/ocaml-rpc"
SRC_URI="https://github.com/mirage/ocaml-${PN}/releases/download/${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/async
	dev-ml/ocaml-base64
	dev-ml/cmdliner
	dev-ml/cow
	dev-ml/js_of_ocaml
	dev-ml/lwt
	dev-ml/ppxlib
	dev-ml/result
	dev-ml/rresult
	dev-ml/xmlm
	dev-ml/yojson
"
RDEPEND="${DEPEND}"
BDEPEND="app-text/md2mld"

src_install() {
	dune_src_install ppx_deriving_rpc
	dune_src_install rpc
	dune_src_install rpclib-async
	dune_src_install rpclib-html
	dune_src_install rpclib-js
	dune_src_install rpclib-lwt
	dune_src_install rpclib
}
