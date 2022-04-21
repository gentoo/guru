# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

MYPN="ocaml-${PN}"

DESCRIPTION="Dereference URIs into communication channels for Async or Lwt"
HOMEPAGE="
	https://github.com/mirage/ocaml-conduit
	https://opam.ocaml.org/packages/conduit/
"
SRC_URI="https://github.com/mirage/${MYPN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="async lwt lwt-unix mirage ocamlopt"

# lwt-unix? tls lwt_ssl launchd
RDEPEND="
	dev-ml/astring:=
	dev-ml/ipaddr:=[sexp]
	dev-ml/logs:=
	dev-ml/ppx_sexp_conv:=
	dev-ml/sexplib:=
	dev-ml/uri:=
	dev-lang/ocaml:=[ocamlopt?]

	async? (
		dev-ml/async:=
		dev-ml/async_ssl:=
		dev-ml/core:=
		dev-ml/ppx_here:=
	)
	lwt? ( dev-ml/lwt:= )
	lwt-unix? (
		dev-ml/ca-certs:=
		dev-ml/lwt:=
	)
	mirage? (
		dev-ml/base:=
		dev-ml/ca-certs-nss:=
		dev-ml/cstruct:=
		dev-ml/dns:=[client]
		dev-ml/fmt:=
		dev-ml/mirage-clock:=
		dev-ml/mirage-flow:=[combinators]
		dev-ml/mirage-random:=
		dev-ml/mirage-time:=
		dev-ml/tcpip:=
		dev-ml/tls:=[mirage]
		dev-ml/vchan:=
		dev-ml/xenstore:=
	)
"
DEPEND="${RDEPEND}"

REQUIRED_USE="
	lwt-unix? ( lwt )
	mirage? ( lwt )
"

src_compile() {
	local pkgs="conduit"
	for u in async lwt lwt-unix mirage ; do
		if use ${u} ; then
			pkgs="${pkgs},conduit-${u}"
		fi
	done
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install conduit
	for u in async lwt lwt-unix mirage ; do
		if use ${u} ; then
			dune_src_install "conduit-${u}"
		fi
	done
}
