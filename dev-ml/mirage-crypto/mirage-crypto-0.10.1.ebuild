# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

MY_P="${PN}-v${PV}"

DESCRIPTION="Simple symmetric cryptography for the modern age"
HOMEPAGE="https://github.com/mirage/mirage-crypto"
SRC_URI="https://github.com/mirage/mirage-crypto/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ec ocamlopt pk rng rng-async rng-mirage test"

DEPEND="
	dev-ml/cstruct:=
	dev-ml/eqaf:=

	pk? (
		dev-libs/gmp
		dev-ml/mirage:=
		dev-ml/sexplib0:=
		dev-ml/zarith:=
	)
	rng? (
		dev-ml/duration:=
		dev-ml/logs:=
	)
	rng-async? ( dev-ml/async:= )
	rng-mirage? (
		dev-ml/lwt:=
		dev-ml/mirage:=
		dev-ml/mirage-clock:=
		dev-ml/mirage-time:=[unix]
		dev-ml/mirage-unix:=
	)
"
RDEPEND="
	${DEPEND}
	test? (
		>=dev-ml/ounit-2
		dev-ml/randomconv
		dev-ml/hex
		dev-ml/asn1-combinators
		dev-ml/ppx_deriving
		dev-ml/ppx_deriving_yojson
		dev-ml/yojson
		dev-ml/alcotest
		dev-ml/mirage-clock-unix
	)
"
BDEPEND="
	dev-ml/dune-configurator
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
