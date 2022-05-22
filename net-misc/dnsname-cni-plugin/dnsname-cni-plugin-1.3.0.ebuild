# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
EGIT_COMMIT="dc59f285546a0b0d8b8f20033e1637ea82587840"
MY_PN=${PN//-cni-plugin}
MY_P=${MY_PN}-${PV}

inherit flag-o-matic go-module

DESCRIPTION="name resolution for containers"
HOMEPAGE="https://github.com/containers/dnsname"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/containers/dnsname.git"
	RESTRICT="fetch mirror test"
else
	SRC_URI="https://github.com/containers/dnsname/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" https://github.com/ran-dall/portage-deps/raw/master/${P}-deps.tar.xz"
	KEYWORDS="~amd64 ~arm64"
	RESTRICT="mirror test"
	S="${WORKDIR}"/${MY_P}
fi

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="
	app-containers/podman
	net-misc/cni-plugins
	net-dns/dnsmasq
"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	if [[ ${PV} == *9999 ]]; then
		git-r3_fetch
		git-r3_checkout
		pushd ${P}/plugins/meta/dnsname || die "location change for module building failed"
		ego get
		popd || die "location reset from module building failed"
	fi
}

src_compile() {
	local git_commit=${EGIT_COMMIT}
	# Disable LDFLAGS to avoid complation error; fixed in v1.3.1.
	filter-ldflags ${LDFLAGS}
	export -n GOCACHE GOPATH XDG_CACHE_HOME
	GOBIN="${S}/bin" \
	emake all \
		GIT_BRANCH=master \
		GIT_BRANCH_CLEAN=master \
		COMMIT_NO="${git_commit}" \
		GIT_COMMIT="${git_commit}"
}

src_install() {
	exeinto /opt/cni/bin
	doexe bin/*
	dodoc README.md
}
