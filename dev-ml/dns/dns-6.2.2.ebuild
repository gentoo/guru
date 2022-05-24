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
	>=dev-ml/domain-name-0.4.0:=
	>=dev-ml/gmap-0.3.0:=
	>=dev-ml/cstruct-6.0.0:=
	>=dev-ml/ipaddr-5.2.0:=
	>=dev-ml/lru-0.3.0:=
	>=dev-ml/duration-0.1.2:=
	dev-ml/metrics:=
	>=dev-ml/ocaml-base64-3.3.0:=
	>=dev-ml/fmt-0.8.8:=

	dnssec? ( dev-ml/mirage-crypto:=[ec,pk] )
	certify? (
		>=dev-ml/randomconv-0.1.2:=
		>=dev-ml/mirage-time-2.0.0:=
		>=dev-ml/mirage-clock-3.0.0:=
		>=dev-ml/tcpip-7.0.0:=
		>=dev-ml/mirage-crypto-0.8.0:=[ec,pk,rng]
		>=dev-ml/x509-0.13.0:=
		>=dev-ml/lwt-4.2.1:=
	)
	cli? (
		>=dev-ml/bos-0.2.0:=
		>=dev-ml/cmdliner-1.1.0:=
		>=dev-ml/fpath-0.7.2:=
		>=dev-ml/x509-0.13.0:=
		>=dev-ml/mirage-crypto-0.8.0:=[ec,pk,rng]
		>=dev-ml/hex-1.4.0:=
		>=dev-ml/mtime-1.2.0:=
		>=dev-ml/fmt-0.8.8:=
		>=dev-ml/lwt-4.0.0:=
		dev-ml/randomconv:=
	)
	client? (
		>=dev-ml/fmt-0.8.0:=
		>=dev-ml/lwt-4.2.1:=
		>=dev-ml/tcpip-7.0.0:=
		>=dev-ml/mirage-random-2.0.0:=
		>=dev-ml/mirage-time-2.0.0:=
		>=dev-ml/mirage-clock-3.0.0:=
		>=dev-ml/mirage-crypto-0.8.0:=[rng]
		>=dev-ml/happy-eyeballs-0.1.0:=
		>=dev-ml/tls-0.15.0:=[mirage]
		>=dev-ml/x509-0.16.0:=
		dev-ml/ca-certs:=
		dev-ml/ca-certs-nss:=
	)
	mirage? (
		>=dev-ml/lwt-4.2.1:=
		>=dev-ml/tcpip-7.0.0:=
	)
	resolver? (
		>=dev-ml/randomconv-0.1.2:=
		>=dev-ml/lwt-4.2.1:=
		>=dev-ml/mirage-time-2.0.0:=
		>=dev-ml/mirage-clock-3.0.0:=
		>=dev-ml/mirage-random-2.0.0:=
		>=dev-ml/tcpip-7.0.0:=
		dev-ml/tls:=[mirage]
		>=dev-ml/duration-0.1.2:=
	)
	server? (
		>=dev-ml/randomconv-0.1.2:=
		>=dev-ml/duration-0.1.2:=
		>=dev-ml/lwt-4.2.1:=
		>=dev-ml/mirage-time-2.0.0:=
		>=dev-ml/mirage-clock-3.0.0:=
		>=dev-ml/tcpip-7.0.0:=
		dev-ml/mirage-crypto:=[rng]
	)
	stub? (
		>=dev-ml/randomconv-0.1.2:=
		>=dev-ml/lwt-4.2.1:=
		>=dev-ml/mirage-time-2.0.0:=
		>=dev-ml/mirage-clock-3.0.0:=
		>=dev-ml/mirage-random-2.0.0:=
		>=dev-ml/tcpip-7.0.0:=
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
