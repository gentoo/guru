# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

RUST_MIN_VER=1.86

PYTHON_COMPAT=( python3_{11..14} )

inherit cargo eapi9-ver optfeature python-single-r1 systemd

DESCRIPTION="Monitor and control your cooling and other devices (daemon)"
HOMEPAGE="https://gitlab.com/coolercontrol/coolercontrol"

MY_P="coolercontrol-${PV}"
SRC_URI="
	https://gitlab.com/coolercontrol/coolercontrol/-/releases/${PV}/downloads/packages/${MY_P}.tar.gz
	https://gitlab.com/coolercontrol/coolercontrol/-/releases/${PV}/downloads/packages/coolercontrold-vendor.tar.gz
		-> ${P}-vendor.tar.gz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${MY_P}/${PN}"

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+="
	AGPL-3+ Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD GPL-3+
	ISC MIT UoI-NCSA Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

IUSE="liquidctl"
REQUIRED_USE="liquidctl? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	app-arch/zstd:=
	liquidctl? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep '
			app-misc/liquidctl[${PYTHON_USEDEP}]
		')
	)
"
DEPEND="${RDEPEND}"
BDEPEND="dev-libs/protobuf[protoc(+)]"

QA_FLAGS_IGNORED=".*"

PATCHES=(
	"${FILESDIR}"/coolercontrold-3.0.2-liquidctl.patch
)

pkg_setup() {
	rust_pkg_setup
	use liquidctl && python-single-r1_pkg_setup
}

src_unpack() {
	# trickery to avoid double unpacking :/
	A="${A[@]/${P}-vendor.tar.gz/}" cargo_src_unpack
	pushd "${S}" >/dev/null || die
	unpack ${P}-vendor.tar.gz
	popd >/dev/null || die
}

src_prepare() {
	pushd .. >/dev/null || die
	default
	popd >/dev/null || die

	if use liquidctl; then
		# Upstream solution not suitable for Gentoo where multiple python targets are available.
		sed -e "s|@@PYTHON@@|${PYTHON}|" \
			-i src/repositories/liquidctl/liqctld_service.rs || die
	fi
}

src_configure() {
	export ZSTD_SYS_USE_PKG_CONFIG=1

	cargo_src_configure
}

src_install() {
	cargo_src_install

	einstalldocs

	doman ../packaging/man/coolercontrold.8

	doinitd ../packaging/openrc/init.d/coolercontrol
	doconfd ../packaging/openrc/conf.d/coolercontrol

	# Match documentation and systemd name to avoid confusion
	newinitd ../packaging/openrc/init.d/coolercontrol coolercontrold
	newconfd ../packaging/openrc/conf.d/coolercontrol coolercontrold

	systemd_dounit ../packaging/systemd/coolercontrold.service
}

pkg_postinst() {
	# libdrm[video_cards_amdgpu] dlopen'd, but the feature is not really noteworthy enough for optfeature
	# (more accurate gpu names for amd)
	optfeature "sensors support" sys-apps/lm-sensors

	if ver_replacing -lt 3.0.0; then
		elog "coolercontrol-liqctld isn't packaged separately anymore. It's behind the liqtctl use flag now."
	fi
}
