# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
inherit linux-mod-r1 python-single-r1 flag-o-matic

DESCRIPTION="Extensible Virtual Display Interface"
HOMEPAGE="https://github.com/DisplayLink/evdi"

if [[ "${PV}" = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/DisplayLink/evdi.git"
else
	if [[ "${PV}" = *_p* ]] ; then
		EVDI_COMMIT="5d708d117baab842d6960f0ec61808a1541bda57"
		SRC_URI="https://github.com/DisplayLink/evdi/archive/${EVDI_COMMIT}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/${PN}-${EVDI_COMMIT}"
	else
		SRC_URI="https://github.com/DisplayLink/evdi/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	fi

	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0/$(ver_cut 1)"

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

PATCHES=(
	"${FILESDIR}/${PN}-1.14.4-format-truncation.patch"
)

pkg_setup() {
	# module/Kconfig
	local CONFIG_CHECK="~FB_VIRTUAL ~I2C ~DRM ~USB_SUPPORT ~USB_ARCH_HAS_HCD MODULES"

	linux-mod-r1_pkg_setup

	use python && python-single-r1_pkg_setup
}

src_compile() {
	# TODO ERROR: modpost: missing MODULE_LICENSE() in evdi.o
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
