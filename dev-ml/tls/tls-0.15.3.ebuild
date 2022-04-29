# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Transport Layer Security purely in OCaml"
HOMEPAGE="https://github.com/mirleft/ocaml-tls"
SRC_URI="https://github.com/mirleft/ocaml-tls/releases/download/v${PV}/${P}.tbz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="async mirage ocamlopt test"

RDEPEND="
	>=dev-lang/ocaml-4.08.0:=[ocamlopt?]
	>=dev-ml/ppx_sexp_conv-0.9.0:=
	>=dev-ml/cstruct-6.0.0:=[ppx,sexp]
	dev-ml/sexplib:=
	>=dev-ml/mirage-crypto-0.10.0:=[ec,pk,rng]
	>=dev-ml/x509-0.13.0:=
	>=dev-ml/domain-name-0.3.0:=
	>=dev-ml/fmt-0.8.7:=
	>=dev-ml/lwt-3.0.0:=
	>=dev-ml/ptime-0.8.1:=
	dev-ml/hkdf:=
	dev-ml/logs:=
	dev-ml/ipaddr:=[sexp]

	async? (
		>=dev-ml/async-0.15:=
		>=dev-ml/async_unix-0.15:=
		>=dev-ml/core-0.15:=
		dev-ml/cstruct:=[async]
		>=dev-ml/ppx_jane-0.15:=
		dev-ml/mirage-crypto:=[rng-async]
		>=dev-ml/x509-0.14.0:=
	)
	mirage? (
		>=dev-ml/mirage-flow-2.0.0:=
		>=dev-ml/mirage-kv-3.0.0:=
		>=dev-ml/mirage-clock-3.0.0:=
		dev-ml/mirage-crypto:=[pk]
	)
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-ml/cstruct-3.0.0[unix]
		dev-ml/alcotest
		dev-ml/randomconv
		dev-ml/ounit2
	)
"

RESTRICT="!test? ( test )"

src_compile() {
	local pkgs="tls"
	for u in async mirage ; do
		if use ${u} ; then
			pkgs="${pkgs},tls-${u}"
		fi
	done
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install tls
	use async && dune_src_install tls-async
	use mirage && dune_src_install tls-mirage
}
