# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="Pinset orchestration for IPFS"
HOMEPAGE="https://ipfscluster.io/"
SRC_URI="https://github.com/ipfs/ipfs-cluster/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://ipfs.infura.io/ipfs/QmUGftdXbN815P1GvurGRBa5fYFiGfTDAdBXToadzYAqw3/${P}-vendor.tar.xz"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	net-p2p/kubo
"

DOCS=( CHANGELOG.md CONTRIBUTING.md README.md )

src_compile() {
	pushd cmd/ipfs-cluster-ctl
	ego build
	mv ipfs-cluster-ctl $OLDPWD
	popd

	pushd cmd/ipfs-cluster-follow
	ego build
	mv ipfs-cluster-follow $OLDPWD
	popd

	pushd cmd/ipfs-cluster-service
	ego build
	mv ipfs-cluster-service $OLDPWD
	popd
}

src_test() {
	go test ./cmd/ipfs-cluster-ctl/... ./cmd/ipfs-cluster-follow/... ./cmd/ipfs-cluster-service/... || die
}

src_install() {
	dobin ipfs-cluster-ctl
	dobin ipfs-cluster-follow
	dobin ipfs-cluster-service
	einstalldocs

	systemd_dounit "${FILESDIR}/ipfs-cluster.service"
	systemd_newunit "${FILESDIR}/ipfs-cluster.service" "ipfs-cluster@.service"

	newinitd "${FILESDIR}/ipfs-cluster.init" ipfs-cluster
	newconfd /dev/null ipfs-cluster

	keepdir /var/log/ipfs-cluster
	fowners -R ipfs:ipfs /var/log/ipfs-cluster
}

pkg_postinst() {
	elog 'To be able to use the ipfs-cluster service you will need to setup the configuration'
	elog '(eg: su -s /bin/sh -c "ipfs-cluster init" ipfs)'
}
