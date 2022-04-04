# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_OPTIONAL=1
PYTHON_COMPAT=( python3_{8..9} )

inherit bash-completion-r1 distutils-r1 dune pam systemd

DESCRIPTION="Xen API SDK, for communication with Citrix XenServer and Xen Cloud Platform"
HOMEPAGE="
	https://xenproject.org/developers/teams/xen-api
	https://github.com/xapi-project/xen-api
	https://pypi.org/project/XenAPI
"
SRC_URI="https://github.com/xapi-project/xen-api/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/xen-api-${PV}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ocamlopt pam python"

RDEPEND="
	python? ( ${PYTHON_DEPS} )

	dev-libs/xxhash
	dev-ml/cstruct
	dev-ml/ezjsonm
	dev-ml/ezxenstore
	dev-ml/mtime
	dev-ml/rpc
	dev-ml/uuidm
	dev-ml/xapi-backtrace
	dev-ml/xapi-stdext
	dev-ml/xcp-inventory
	dev-ml/xcp-rrd
	dev-ml/xen-gnt
	dev-ml/xenctrl
	dev-ml/xenstore
	dev-ml/xenstore-clients
	dev-ml/xmlm
"
DEPEND="${RDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

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
