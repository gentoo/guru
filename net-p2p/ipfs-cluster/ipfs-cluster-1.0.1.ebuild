# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 go-module systemd

DESCRIPTION="Pinset orchestration for IPFS"
HOMEPAGE="https://ipfscluster.io/"
SRC_URI="https://github.com/ipfs/ipfs-cluster/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://ipfs.infura.io/ipfs/QmUGftdXbN815P1GvurGRBa5fYFiGfTDAdBXToadzYAqw3/${P}-vendor.tar.xz"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	net-p2p/go-ipfs
"

DOCS=( CHANGELOG.md CONTRIBUTING.md README.md )

src_compile() {
	default

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

	#systemd_dounit "${FILESDIR}/ipfs-cluster-service.service"
	#systemd_newunit "${FILESDIR}/ipfs-cluster-service.service" "ipfs-cluster-service@.service"

	#newinitd "${FILESDIR}/ipfs-cluster-service.init" ipfs
	#newconfd "${FILESDIR}/ipfs-cluster-service.confd" ipfs

	keepdir /var/log/ipfs-cluster
	fowners -R ipfs:ipfs /var/log/ipfs-cluster
}
