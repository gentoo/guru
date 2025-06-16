# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

declare -A GIT_CRATES=(
	[nvml-wrapper-sys]='https://github.com/codifryed/nvml-wrapper;572095f631da93be8d243c73820e581676969897;nvml-wrapper-%commit%/nvml-wrapper-sys'
	[nvml-wrapper]='https://github.com/codifryed/nvml-wrapper;572095f631da93be8d243c73820e581676969897;nvml-wrapper-%commit%/nvml-wrapper'
	[tower_governor]='https://github.com/codifryed/tower-governor;fd799d86418e58179468953c80ad7094a81a9e37;tower-governor-%commit%'
)

inherit cargo optfeature systemd

DESCRIPTION="Monitor and control your cooling and other devices (daemon)"
HOMEPAGE="https://gitlab.com/coolercontrol/coolercontrol"
SRC_URI="
	https://gitlab.com/coolercontrol/coolercontrol/-/archive/${PV}/coolercontrol-${PV}.tar.bz2
	https://gitlab.com/api/v4/projects/32909921/packages/generic/coolercontrol/${PV}/coolercontrol-${PV}-dist.tar.xz
	https://gitlab.com/api/v4/projects/32909921/packages/generic/coolercontrol/${PV}/coolercontrold-${PV}-crates.tar.xz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/coolercontrol-${PV}/${PN}"

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+="
	AGPL-3+ Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD GPL-3+
	ISC MIT MPL-2.0 UoI-NCSA Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

IUSE="video_cards_amdgpu"

RDEPEND="
	app-arch/zstd:=
	video_cards_amdgpu? (
		x11-libs/libdrm[video_cards_amdgpu]
	)
"
DEPEND="${RDEPEND}"

QA_FLAGS_IGNORED=".*"

PATCHES=(
	"${FILESDIR}"/coolercontrold-2.1.0-optional-libdrm_amdgpu.patch
)

src_prepare() {
	pushd .. >/dev/null || die
	default
	popd >/dev/null || die

	# Disable stripping
	sed -i -e '/^strip =/d' Cargo.toml || die

	cp -rf "${WORKDIR}"/dist/* "${S}"/resources/app/ || die
}

src_configure() {
	export ZSTD_SYS_USE_PKG_CONFIG=1

	local myfeatures=(
		$(usev video_cards_amdgpu libdrm_amdgpu)
	)

	cargo_src_configure
}

src_install() {
	cargo_src_install

	einstalldocs

	doinitd ../packaging/openrc/init.d/coolercontrol
	doconfd ../packaging/openrc/conf.d/coolercontrol

	systemd_dounit ../packaging/systemd/coolercontrold.service
}

pkg_postinst() {
	optfeature "interact with AIO liquid coolers and other devices" sys-apps/coolercontrol-liqctld

	if [[ -n ${REPLACING_VERSIONS} ]]; then
		elog "Remember to restart coolercontrol service to use the new version."
	fi
}
