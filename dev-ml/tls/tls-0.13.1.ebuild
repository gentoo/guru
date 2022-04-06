# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

MY_P="${PN}-v${PV}"

DESCRIPTION="Transport Layer Security purely in OCaml"
HOMEPAGE="https://github.com/mirleft/ocaml-tls"
SRC_URI="https://github.com/mirleft/ocaml-tls/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="async mirage ocamlopt test"

RDEPEND="
	dev-ml/ppx_sexp_conv
	dev-ml/cstruct[ppx,sexp]
	dev-ml/sexplib
	dev-ml/mirage-crypto[ec,pk,rng]
	dev-ml/x509
	dev-ml/domain-name
	dev-ml/fmt
	dev-ml/lwt
	dev-ml/ptime
	dev-ml/hkdf
	dev-ml/logs
	dev-ml/ipaddr[sexp]

	async? (
		dev-ml/async
		dev-ml/async_unix
		dev-ml/core
		dev-ml/cstruct[async]
		dev-ml/ppx_jane
		dev-ml/mirage-crypto[rng-async]
	)
	mirage? (
		dev-ml/mirage-flow
		dev-ml/mirage-kv
		dev-ml/mirage-clock
		dev-ml/mirage-crypto[pk]
	)
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/cstruct[unix]
		dev-ml/alcotest
		dev-ml/randomconv
		>=dev-ml/ounit-2
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
	dune build --only-packages "${pkgs}" -j $(makeopts_jobs) --profile release || die
}

src_install() {
	dune_src_install tls
	use async && dune_src_install tls-async
	use mirage && dune_src_install tls-mirage
}
