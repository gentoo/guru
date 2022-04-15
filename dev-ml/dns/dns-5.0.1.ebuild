# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="A pure OCaml implementation of the DNS protocol"
HOMEPAGE="https://github.com/mirage/ocaml-dns"
SRC_URI="https://github.com/mirage/ocaml-${PN}/archive/v${PV}.tar.gz -> ocaml-${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="certify cli client dnssec mirage ocamlopt resolver server stub test tsig"

RDEPEND="
	dev-ml/logs:=
	dev-ml/ptime:=
	dev-ml/domain-name:=
	dev-ml/gmap:=
	dev-ml/cstruct:=
	dev-ml/ipaddr:=
	dev-ml/lru:=
	dev-ml/duration:=
	dev-ml/metrics:=
	dev-ml/ocaml-base64:=

	dnssec? ( dev-ml/mirage-crypto:=[ec,pk] )
	certify? (
		dev-ml/randomconv:=
		dev-ml/mirage-time:=
		dev-ml/mirage-clock:=
		dev-ml/tcpip:=
		dev-ml/mirage-crypto:=[ec,pk,rng]
		dev-ml/x509:=
		dev-ml/lwt:=
	)
	cli? (
		dev-ml/bos:=
		dev-ml/cmdliner:=
		dev-ml/fpath:=
		dev-ml/x509:=
		dev-ml/mirage-crypto:=[ec,pk]
		dev-ml/hex:=
		dev-ml/mtime:=
		dev-ml/fmt:=
		dev-ml/lwt:=
		dev-ml/randomconv:=
	)
	client? (
		dev-ml/fmt:=
		dev-ml/lwt:=
		dev-ml/tcpip:=
		dev-ml/mirage-random:=
		dev-ml/mirage-time:=
		dev-ml/mirage-clock:=
		dev-ml/mirage-crypto:=[rng]
		dev-ml/happy-eyeballs:=
		dev-ml/tls:=[mirage]
		dev-ml/x509:=
		dev-ml/ca-certs:=
		dev-ml/ca-certs-nss:=
	)
	mirage? (
		dev-ml/lwt:=
		dev-ml/tcpip:=
	)
	resolver? (
		dev-ml/randomconv:=
		dev-ml/lwt:=
		dev-ml/mirage-time:=
		dev-ml/mirage-clock:=
		dev-ml/mirage-random:=
		dev-ml/tcpip:=
		dev-ml/tls:=[mirage]
		dev-ml/duration:=
	)
	server? (
		dev-ml/randomconv:=
		dev-ml/duration:=
		dev-ml/lwt:=
		dev-ml/mirage-time:=
		dev-ml/mirage-clock:=
		dev-ml/tcpip:=
		dev-ml/mirage-crypto:=[rng]
	)
	stub? (
		dev-ml/randomconv:=
		dev-ml/lwt:=
		dev-ml/mirage-time:=
		dev-ml/mirage-clock:=
		dev-ml/mirage-random:=
		dev-ml/tcpip:=
	)
	tsig? ( dev-ml/mirage-crypto:= )
"
DEPEND="
	${RDEPEND}
	test? ( dev-ml/alcotest )
"

RESTRICT="!test? ( test )"
REQUIRED_USE="
	certify? ( mirage tsig )
	cli? ( certify client dnssec server tsig )
	resolver? ( dnssec mirage server )
	server? ( mirage )
	stub? ( client mirage resolver tsig server )
	test? ( cli dnssec resolver server tsig )
"

src_compile() {
	local pkgs="dns"
	use dnssec && pkgs="${pkgs},dnssec"
	for u in certify cli client mirage resolver server stub tsig ; do
		if use ${u} ; then
			pkgs="${pkgs},dns-${u}"
		fi
	done
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install dns
	use dnssec && dune_src_install dnssec
	for u in certify cli client mirage resolver server stub tsig ; do
		if use ${u} ; then
			dune_src_install "dns-${u}"
		fi
	done
}
