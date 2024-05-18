# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature

DESCRIPTION="SVG Parsing for Elements, Paths, and other SVG Objects."
HOMEPAGE="https://github.com/meerk40t/svgelements https://pypi.org/project/svgelements"
SRC_URI="https://github.com/meerk40t/svgelements/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}/fix_tests.patch"
)

BDEPEND="
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
	)
"
DEPEND="${BDEPEND}"

distutils_enable_tests pytest

src_prepare() {
	default
	mv "${S}/test" "${S}_tests"
}

python_test() {
	cd "${T}" || die
	epytest "${S}_tests"
}

pkg_postinst() {
	optfeature "getting exact value for arc lenght computation" dev-python/scipy
	optfeature "loading images" dev-python/pillow
	optfeature "speeding up linearization for Shapes" dev-python/numpy
}
