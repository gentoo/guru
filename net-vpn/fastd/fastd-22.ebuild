# Copyright 1999-2023 Gentoo Authors
#
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit linux-info meson systemd

DESCRIPTION="A very small VPN daemon which tunnels IP packets and Ethernet frames over UDP."
HOMEPAGE="https://fastd.readthedocs.io/"
SRC_URI="https://github.com/NeoRaider/fastd/releases/download/v${PV}/${P}.tar.xz"

# while source COPYRIGHT also mentions LGPLv2.1+, that only applies to
# vendored libmnl. we are using system libmnl.
LICENSE="BSD BSD-2"

SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+caps doc offload-l2tp systemd test"
RESTRICT="!test? ( test )"

RDEPEND="
>=net-libs/libuecc-6
dev-libs/json-c
dev-libs/libsodium
dev-libs/openssl
offload-l2tp? ( net-libs/libmnl )
caps? ( sys-libs/libcap )
test? ( dev-util/cmocka )
"
DEPEND="${RDEPEND}"
BDEPEND="
sys-devel/bison
doc? ( dev-python/sphinx )
"

pkg_setup() {
	if use offload-l2tp; then
		CONFIG_CHECK="~L2TP ~L2TP_V3 ~L2TP_ETH"
		declare -g ERROR_L2TP="CONFIG_L2TP     isn't set. Offloading L2TP to kernel will not work."
		declare -g ERROR_L2TP_V3="CONFIG_L2TP_V3  isn't set. Offloading L2TP to kernel will not work."
		declare -g ERROR_L2TP_ETH="CONFIG_L2TP_ETH isn't set. Offloading L2TP to kernel will not work."
		linux-info_pkg_setup
	fi
}

src_configure() {
	local emesonargs=(
		$(meson_feature caps capabilities)
		$(meson_feature offload-l2tp offload_l2tp)
		$(meson_feature systemd)
		$(meson_use test build_tests)
		-Dlibmnl_builtin=false
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
	if use doc; then
		einfo "Building documentation ..."
		local doc_dir="${S}/doc"
		cd "${doc_dir}" || die "Cannot chdir into \"${doc_dir}\"!"
		emake man || die "Building documentation failed!"
	fi
}

src_install() {
	meson_src_install
	systemd_dounit "doc/examples/fastd@.service"
	newinitd "${FILESDIR}/fastd.init" fastd
	use doc && doman doc/build/man/*
	keepdir /etc/fastd
}
