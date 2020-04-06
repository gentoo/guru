# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="A Geocoding Toolbox for Python"
HOMEPAGE="
	http://www.geopy.org
	https://github.com/geopy/geopy
	https://pypi.org/project/geopy
"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

IUSE="timezone"
REQUIRED_USE="test? ( timezone )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	<sci-geosciences/geographiclib-2[${PYTHON_USEDEP}]
	>=sci-geosciences/geographiclib-1.49[${PYTHON_USEDEP}]

	timezone? (
			dev-python/pytz[${PYTHON_USEDEP}]
	)
"
DEPEND="
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx \
				">=dev-python/sphinx_rtd_theme-0.4.0" \
				dev-python/readme_renderer
