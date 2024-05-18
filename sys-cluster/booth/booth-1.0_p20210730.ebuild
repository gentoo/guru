# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools systemd

COMMIT="95d854b32a7cb20cb9a0e90c71d8cc269657304d"

DESCRIPTION="The Booth Cluster Ticket Manager"
HOMEPAGE="https://github.com/ClusterLabs/booth"
SRC_URI="https://github.com/ClusterLabs/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+glue test"

RDEPEND="
	acct-group/haclient
	acct-user/hacluster
	dev-libs/libxml2
	sys-cluster/pacemaker
	sys-libs/zlib

	|| (
		dev-libs/libgcrypt
		app-crypt/mhash
	)

	glue? ( sys-cluster/cluster-glue )
	!glue? (
		dev-libs/glib
		sys-apps/systemd
		sys-cluster/libqb
	)
"
DEPEND="${RDEPEND}"

RESTRICT="!test? ( test )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-coverage
		--disable-fatal-warnings
		--enable-user-flags

		--with-initddir="${EPREFIX}/etc/init.d"
		--with-ocfdir="${EPREFIX}/usr/$(get_libdir)/ocd"

		$(use_with glue)
		$(use_with test run-build-tests)
	)
	econf "${myconf[@]}"
}

src_install() {
	default

	insinto "/usr/$(get_libdir)/firewalld/services"
	doins contrib/geo-cluster.firewalld.xml

	systemd_dounit conf/booth{@,-arbitrator}.service
}
