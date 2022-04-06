# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

MY_P="rpclib-${PV}"

DESCRIPTION="Light library to deal with RPCs in OCaml"
HOMEPAGE="https://github.com/mirage/ocaml-rpc"
SRC_URI="https://github.com/mirage/ocaml-${PN}/releases/download/${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="async html js ocamlopt test"

DEPEND="
	dev-ml/cmdliner:=
	dev-ml/lwt:=
	dev-ml/ocaml-base64:=
	dev-ml/ppxlib:=
	dev-ml/result:=
	dev-ml/rresult:=
	dev-ml/xmlm:=
	dev-ml/yojson:=

	async? ( dev-ml/async:= )
	html? ( dev-ml/cow:= )
	js? ( dev-ml/js_of_ocaml:=[ppx] )
"
RDEPEND="
	${DEPEND}
	test? (
		dev-ml/alcotest
		dev-ml/alcotest-lwt
		sys-apps/which
	)
"
BDEPEND="app-text/md2mld"

RESTRICT="!test? ( test )"

src_compile() {
	local pkgs="rpclib,rpc,rpclib-lwt,ppx_deriving_rpc"
	for u in async js html ; do
		if use ${u} ; then
			pkgs="${pkgs},rpclib-${u}"
		fi
	done
	dune build --only-packages "${pkgs}" -j $(makeopts_jobs) --profile release || die
}

src_install() {
	dune_src_install rpclib-lwt
	dune_src_install rpclib
	dune_src_install ppx_deriving_rpc
	dune_src_install rpc
	use async && dune_src_install rpclib-async
	use html && dune_src_install rpclib-html
	use js && dune_src_install rpclib-js
}
