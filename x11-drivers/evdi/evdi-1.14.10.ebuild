# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
inherit linux-mod-r1 python-single-r1 flag-o-matic

DESCRIPTION="Extensible Virtual Display Interface"
HOMEPAGE="https://github.com/DisplayLink/evdi"
SRC_URI="https://github.com/DisplayLink/evdi/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0/$(ver_cut 1)"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="python test"

RDEPEND="${PYTHON_DEPS}
	python? (
		$(python_gen_cond_dep '
			dev-python/pybind11[${PYTHON_USEDEP}]
			test? (
				dev-python/pytest-mock[${PYTHON_USEDEP}]
			)
		')
	)
"

DEPEND="${RDEPEND}
	x11-libs/libdrm
	sys-kernel/linux-headers
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RESTRICT="!test? ( test )"

# module/Kconfig
CONFIG_CHECK="~FB_VIRTUAL ~I2C ~DRM ~USB_SUPPORT ~USB_ARCH_HAS_HCD MODULES"

PATCHES=(
	"${FILESDIR}/${PN}-1.14.4-format-truncation.patch"
)

pkg_setup() {
	linux-mod-r1_pkg_setup
	use python && python-single-r1_pkg_setup
}

src_compile() {
	filter-lto

	local modlist=(
		"evdi=video:module"
	)
	local modargs=(
		CONFIG_DRM_EVDI="m" # https://github.com/DisplayLink/evdi/issues/476
		KVER="${KV_FULL}"
		KDIR="${KV_OUT_DIR}"
	)
	linux-mod-r1_src_compile

	emake -C library

	use python && emake -C pyevdi
}

src_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1

	use python && emake -C pyevdi tests
}

src_install() {
	linux-mod-r1_src_install

	local -x DESTDIR="${ED}" PREFIX="${EPREFIX}"

	LIBDIR="/usr/$(get_libdir)" emake -C library install

	use python && emake -C pyevdi install
}
