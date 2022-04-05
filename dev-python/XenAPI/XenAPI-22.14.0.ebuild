# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_OPTIONAL=1
PYTHON_COMPAT=( python3_{8..9} )

inherit bash-completion-r1 distutils-r1 dune pam systemd

DESCRIPTION="Xen API SDK, for communication with Citrix XenServer and Xen Cloud Platform"
HOMEPAGE="
	https://xenproject.org/developers/teams/xen-api/
	https://github.com/xapi-project/xen-api
	https://pypi.org/project/XenAPI/
"
SRC_URI="https://github.com/xapi-project/xen-api/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/xen-api-${PV}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ocamlopt pam python test"

RDEPEND="
	python? ( ${PYTHON_DEPS} )

	app-emulation/xen
	dev-libs/openssl
	dev-libs/xxhash
	dev-ml/alcotest:=
	dev-ml/angstrom:=
	dev-ml/astring:=
	dev-ml/async_inotify:=
	dev-ml/async_unix:=
	dev-ml/async:=
	dev-ml/base-threads:=
	dev-ml/base-unix:=
	dev-ml/cdrom:=
	dev-ml/cmdliner:=
	dev-ml/cohttp:=[async,lwt,lwt-unix]
	dev-ml/core:=
	dev-ml/crc:=
	dev-ml/cstruct:=[ppx,unix]
	dev-ml/domain-name:=
	dev-ml/dune-build-info:=
	dev-ml/ezjsonm:=
	dev-ml/ezxenstore:=
	dev-ml/fd-send-recv:=
	dev-ml/fmt:=
	dev-ml/fpath:=
	dev-ml/inotify:=
	dev-ml/io-page:=[unix(-)]
	dev-ml/ipaddr:=
	dev-ml/logs:=
	dev-ml/lwt:=
	dev-ml/lwt_log:=
	dev-ml/lwt_ssl:=
	dev-ml/mirage-block-unix:=
	dev-ml/mirage-crypto:=[pk]
	dev-ml/mtime:=
	dev-ml/mustache:=
	dev-ml/nbd:=[unix]
	dev-ml/netlink:=
	dev-ml/ocaml-base64:=
	dev-ml/ocaml-ctypes:=
	dev-ml/ocaml-migrate-parsetree:=
	dev-ml/ocaml-sha:=
	dev-ml/pci:=
	dev-ml/polly:=
	dev-ml/ppx_sexp_conv:=
	dev-ml/qmp:=
	dev-ml/re:=
	dev-ml/result:=
	dev-ml/rpc:=[async]
	dev-ml/rresult:=
	dev-ml/sexplib:=
	dev-ml/sexplib0:=
	dev-ml/shared-block-ring:=
	dev-ml/systemd:=
	dev-ml/tar:=[unix]
	dev-ml/uri:=
	dev-ml/uuidm:=
	dev-ml/uutf:=
	dev-ml/vhd:=[lwt]
	dev-ml/x509:=
	dev-ml/xapi-backtrace:=
	dev-ml/xapi-stdext:=
	dev-ml/xapi-test-utils:=
	dev-ml/xcp-inventory:=
	dev-ml/xcp-rrd:=
	dev-ml/xenctrl:=
	dev-ml/xen-gnt:=[unix]
	dev-ml/xenstore:=
	dev-ml/xenstore-clients:=
	dev-ml/xmlm:=
	dev-ml/yojson:=
	sys-libs/pam
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/mirage-crypto[rng]
		>=dev-ml/ounit-2
		dev-ml/qcheck
	)
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

src_compile() {
	dune_src_compile
	if use python; then
		pushd scripts/examples/python || die
		python_foreach_impl distutil-r1_python_compile
		popd || die
	fi
}

src_install() {
	for p in *.opam ; do
		dune_src_install "${p/.opam/}"
	done

	pushd scripts || die
	emake install
	popd || die

	if use python; then
		pushd scripts/examples/python || die
		python_foreach_impl distutils-r1_python_install
		popd || die
	fi

#	newbashcomp scripts/xe-switch-network-backend-bash-completion xe-switch-network-backend
#
#	insinto /etc/logrotate
#	newins scripts/audit-logrotate audit.conf
#
#	for s in scripts/*.service ; do
#		systemd_dounit "${s}"
#	done
#
#	use pam && newpamd scripts/pam.d-xapi xapi
}
