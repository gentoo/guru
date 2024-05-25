# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
inherit linux-mod-r1 python-single-r1

DESCRIPTION="Extensible Virtual Display Interface"
HOMEPAGE="https://github.com/DisplayLink/evdi"
SRC_URI="https://github.com/DisplayLink/evdi/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="python test"

RDEPEND="${PYTHON_DEPS}
	x11-libs/libdrm
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
	sys-kernel/linux-headers
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RESTRICT="!test? ( test )"

CONFIG_CHECK="~FB_VIRTUAL ~I2C"

PATCHES=(
	"${FILESDIR}/${PN}-1.14.4-format-truncation.patch"
)

pkg_setup() {
	linux-mod-r1_pkg_setup
	use python && python-single-r1_pkg_setup
}

src_compile() {
	local modlist=(
		"evdi=video:${S}/module"
	)
	linux-mod-r1_src_compile

	emake library
	ln -srf "${S}/library/libevdi.so"{".$(ver_cut 1)",} || die

	use python && emake pyevdi
}

src_test() {
	use python && emake -C pyevdi tests
}

src_install() {
	linux-mod-r1_src_install

	dolib.so "library/libevdi.so.${PV}"

	dosym "libevdi.so.${PV}" "/usr/$(get_libdir)/libevdi.so.$(ver_cut 1)"
	dosym "libevdi.so.$(ver_cut 1)" "/usr/$(get_libdir)/libevdi.so"

	use python && DESTDIR="${D}" emake -C pyevdi install
}
