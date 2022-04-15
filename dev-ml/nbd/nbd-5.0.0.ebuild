# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Ocaml NBD library"
HOMEPAGE="https://github.com/xapi-project/nbd"
SRC_URI="https://github.com/xapi-project/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test tool unix"

RDEPEND="
	dev-ml/cstruct[ppx]
	dev-ml/io-page
	dev-ml/mirage-block-unix
	dev-ml/lwt
	dev-ml/lwt_log
	dev-ml/ppx_sexp_conv
	dev-ml/rresult
	dev-ml/sexplib
	dev-ml/uri

	tool? ( dev-ml/cmdliner )
	unix? (
		dev-ml/cstruct[lwt]
		dev-ml/io-page[unix(-)]
		dev-ml/lwt_ssl
		dev-ml/ocaml-ssl
	)
"
DEPEND="
	${RDEPEND}
	test? (
		app-emulation/qemu
		dev-ml/alcotest
		dev-ml/io-page[unix(-)]
		sys-block/nbd
		|| ( net-analyzer/openbsd-netcat net-analyzer/nmap[ncat] )
	)
"

RESTRICT="!test? ( test )"
REQUIRED_USE="
	tool? ( unix )
	test? ( tool )
"

src_compile() {
	local pkgs="nbd"
	for u in tool unix ; do
		if use ${u} ; then
			pkgs="${pkgs},nbd-${u}"
		fi
	done
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install nbd
	use tool && dune_src_install nbd-tool
	use unix && dune_src_install nbd-unix
}
