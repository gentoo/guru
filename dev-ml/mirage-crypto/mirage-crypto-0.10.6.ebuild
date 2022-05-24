# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Simple symmetric cryptography for the modern age"
HOMEPAGE="
	https://github.com/mirage/mirage-crypto
	https://opam.ocaml.org/packages/mirage-crypto/
"
SRC_URI="https://github.com/mirage/mirage-crypto/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ec ocamlopt pk rng rng-async rng-mirage test"

DEPEND="
	>=dev-lang/ocaml-4.08.0:=[ocamlopt?]
	>=dev-ml/cstruct-6.0.0:=
	>=dev-ml/eqaf-0.8:=

	pk? (
		dev-libs/gmp
		>=dev-ml/mirage-4.0:=
		dev-ml/sexplib0:=
		>=dev-ml/zarith-1.4:=
	)
	rng? (
		dev-ml/duration:=
		dev-ml/logs:=
		>=dev-ml/lwt-4.0.0:=
		>=dev-ml/mtime-1.0.0:=
	)
	rng-async? ( >=dev-ml/async-0.14:= )
	rng-mirage? (
		>=dev-ml/lwt-4.0.0:=
		>=dev-ml/mirage-3.8.0:=
		>=dev-ml/mirage-clock-3.0.0:=
	)
"
RDEPEND="
	${DEPEND}
	test? (
		dev-ml/ounit2
		>=dev-ml/randomconv-0.1.3
		dev-ml/hex
		>=dev-ml/asn1-combinators-0.2.5
		dev-ml/ppx_deriving
		dev-ml/ppx_deriving_yojson
		>=dev-ml/yojson-1.6.0
		dev-ml/alcotest
		>=dev-ml/mirage-clock-unix-3.0.0
		>=dev-ml/mirage-time-2.0.0[unix]
		>=dev-ml/mirage-unix-5.0.0
	)
"
BDEPEND="
	>=dev-ml/dune-configurator-2.0.0
	virtual/pkgconfig
"

RESTRICT="!test? ( test )"
REQUIRED_USE="
	test? ( ec pk rng )
	ec? ( rng )
	pk? ( rng )
	rng-async? ( rng )
	rng-mirage? ( rng )
"

src_compile() {
	local pkgs="mirage-crypto"
	for u in rng rng-async rng-mirage pk ec ; do
		if use ${u} ; then
			pkgs="${pkgs},mirage-crypto-${u}"
		fi
	done
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install mirage-crypto
	use rng && dune_src_install mirage-crypto-rng
	use ec && dune_src_install mirage-crypto-ec
	use pk && dune_src_install mirage-crypto-pk
	use rng-async && dune_src_install mirage-crypto-rng-async
	use rng-mirage && dune_src_install mirage-crypto-rng-mirage
}
