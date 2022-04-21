# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Very lightweight HTTP server using Lwt or Async"
HOMEPAGE="
	https://github.com/mirage/ocaml-cohttp
	https://opam.ocaml.org/packages/cohttp/
"
SRC_URI="https://github.com/mirage/ocaml-cohttp/archive/v${PV}.tar.gz -> ocaml-cohttp-${PV}.tar.gz"
S="${WORKDIR}/ocaml-cohttp-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="async bench curl curl-async curl-lwt lwt lwt-jsoo lwt-unix mirage ocamlopt server-lwt-unix test top"

RDEPEND="
	async? (
		dev-ml/async:=
		dev-ml/async_kernel:=
		dev-ml/async_unix:=
		dev-ml/base:=
		dev-ml/core_unix:=
		dev-ml/conduit:=[async]
		dev-ml/fmt:=
		dev-ml/ipaddr:=
		dev-ml/logs:=
		dev-ml/magic-mime:=
		dev-ml/mirage-crypto:=
	)
	bench? (
		dev-ml/core:=
		dev-ml/core_bench:=
	)
	curl-async? (
		dev-ml/async_kernel:=
		dev-ml/async_unix:=
		dev-ml/core_kernel:=
		dev-ml/ocurl:=
	)
	curl? ( dev-ml/ocurl:= )
	curl-lwt? (
		dev-ml/lwt:=
		dev-ml/ocurl:=
	)
	lwt? (
		dev-ml/logs:=
		dev-ml/lwt:=
		dev-ml/ppx_sexp_conv:=
	)
	lwt-jsoo? (
		>=dev-ml/js_of_ocaml-3.5.0:=[lwt,ppx]
		dev-ml/logs:=
		>=dev-ml/lwt-3.0.0:=
	)
	lwt-unix? (
		dev-ml/cmdliner:=
		>=dev-ml/conduit-5.0.0:=[lwt,lwt-unix]
		>=dev-ml/fmt-0.8.2:=
		dev-ml/logs:=
		>=dev-ml/lwt-3.0.0:=
		dev-ml/magic-mime:=
		>=dev-ml/ppx_sexp_conv-0.13.0:=
	)
	mirage? (
		dev-ml/astring:=
		>=dev-ml/conduit-2.0.2:=[mirage]
		>=dev-ml/fmt-0.8.7:=
		>=dev-ml/lwt-2.4.3:=
		dev-ml/magic-mime:=
		>=dev-ml/mirage-channel-4.0.0:=
		>=dev-ml/mirage-flow-2.0.0:=
		>=dev-ml/mirage-kv-3.0.0:=
		>=dev-ml/ppx_sexp_conv-0.13.0:=
	)
	server-lwt-unix? (
		dev-ml/lwt:=
	)

	>=dev-lang/ocaml-4.08:=[ocamlopt?]
	>=dev-ml/ocaml-base64-3.1.0:=
	>=dev-ml/re-1.9.0:=
	dev-ml/sexplib0:=
	dev-ml/stringext:=
	>=dev-ml/uri-2.0.0:=[sexp]
"
DEPEND="
	${RDEPEND}
	dev-ml/jsonm:=
	test? (
		dev-ml/alcotest
		dev-ml/base_quickcheck
		dev-ml/ppx_assert
		dev-ml/ppx_sexp_conv
		dev-ml/ppx_compare
		dev-ml/ppx_here
		dev-ml/core
		dev-ml/core_bench
		dev-ml/crowbar
		dev-ml/fmt
		dev-ml/conduit[lwt,lwt-unix]
		dev-ml/ounit2
		dev-ml/lwt
		net-libs/nodejs[npm]
		dev-ml/mirage-crypto
	)
"

RESTRICT="!test? ( test )"
REQUIRED_USE="
	bench? ( async lwt-unix server-lwt-unix )
	curl-lwt? ( curl )
	lwt-jsoo? ( lwt )
	lwt-unix? ( lwt )
	mirage? ( lwt )
	server-lwt-unix? ( lwt )
	test? ( async curl-async curl-lwt lwt-jsoo lwt-unix lwt )
"

src_compile() {
#	local pkgs="http,cohttp"
	local pkgs="cohttp"
	use async && pkgs="${pkgs},cohttp-async"
	use bench && pkgs="${pkgs},cohttp-bench"
	use curl-async && pkgs="${pkgs},cohttp-curl-async"
	use curl-lwt && pkgs="${pkgs},cohttp-curl-lwt"
	use curl && pkgs="${pkgs},cohttp-curl"
	use lwt-jsoo && pkgs="${pkgs},cohttp-lwt-jsoo"
	use lwt-unix && pkgs="${pkgs},cohttp-lwt-unix"
	use lwt && pkgs="${pkgs},cohttp-lwt"
	use mirage && pkgs="${pkgs},cohttp-mirage"
	use server-lwt-unix && pkgs="${pkgs},cohttp-server-lwt-unix"
	use top && pkgs="${pkgs},cohttp-top"
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
#	dune_src_install http
	dune_src_install cohttp
	use async && dune_src_install cohttp-async
	use bench && dune_src_install cohttp-bench
	use curl-async && dune_src_install cohttp-curl-async
	use curl-lwt && dune_src_install cohttp-curl-lwt
	use curl && dune_src_install cohttp-curl
	use lwt-jsoo && dune_src_install cohttp-lwt-jsoo
	use lwt-unix && dune_src_install cohttp-lwt-unix
	use lwt && dune_src_install cohttp-lwt
	use mirage && dune_src_install cohttp-mirage
	use server-lwt-unix && dune_src_install cohttp-server-lwt-unix
	use top && dune_src_install cohttp-top
}
