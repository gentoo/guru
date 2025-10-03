# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

declare -A GIT_CRATES=(
	[nvml-wrapper-sys]='https://github.com/codifryed/nvml-wrapper;572095f631da93be8d243c73820e581676969897;nvml-wrapper-%commit%/nvml-wrapper-sys'
	[nvml-wrapper]='https://github.com/codifryed/nvml-wrapper;572095f631da93be8d243c73820e581676969897;nvml-wrapper-%commit%/nvml-wrapper'
	[tower_governor]='https://github.com/codifryed/tower-governor;9cc5a4433fa4f5fc7ffaf82ac277471d056ceef4;tower-governor-%commit%'
)

RUST_MIN_VER=1.86

PYTHON_COMPAT=( python3_{11..13} )

inherit cargo eapi9-ver optfeature python-single-r1 systemd

DESCRIPTION="Monitor and control your cooling and other devices (daemon)"
HOMEPAGE="https://gitlab.com/coolercontrol/coolercontrol"
SRC_URI="
	https://gitlab.com/coolercontrol/coolercontrol/-/archive/${PV}/coolercontrol-${PV}.tar.bz2
	${CARGO_CRATE_URIS}
"
if [[ ${PKGBUMPING} != ${PVR} ]]; then
	SRC_URI+="
		https://gitlab.com/api/v4/projects/32909921/packages/generic/coolercontrol/${PV}/coolercontrol-${PV}-dist.tar.xz
		https://gitlab.com/api/v4/projects/32909921/packages/generic/coolercontrol/${PV}/coolercontrold-${PV}-crates.tar.xz
	"
fi
S="${WORKDIR}/coolercontrol-${PV}/${PN}"

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

QA_FLAGS_IGNORED=".*"

PATCHES=(
	"${FILESDIR}"/coolercontrold-3.0.0-liquidctl.patch
)

pkg_setup() {
	rust_pkg_setup
	use liquidctl && python-single-r1_pkg_setup
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

	cp -rf "${WORKDIR}"/dist/* "${S}"/resources/app/ || die
}

src_configure() {
	export ZSTD_SYS_USE_PKG_CONFIG=1

	cargo_src_configure
}

src_install() {
	cargo_src_install

	einstalldocs

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
