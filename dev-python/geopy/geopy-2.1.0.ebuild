# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="A Geocoding Toolbox for Python"
HOMEPAGE="
	https://geopy.readthedocs.io
	https://github.com/geopy/geopy
	https://pypi.org/project/geopy
"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=sci-geosciences/GeographicLib-1.51-r1[python,${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/async_generator[${PYTHON_USEDEP}]
		dev-python/pytest-aiohttp[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
				dev-python/sphinx-issues \
				dev-python/sphinx_rtd_theme

python_test() {
	epytest \
		--deselect test/test_adapters.py::test_not_available_adapters_raise \
		--deselect test/test_adapters.py::test_geocoder_constructor_uses_https_proxy \
		--deselect test/test_adapters.py::test_geocoder_https_proxy_auth_is_respected \
		--deselect test/test_adapters.py::test_ssl_context_with_proxy_is_respected \
		--deselect test/test_adapters.py::test_ssl_context_without_proxy_is_respected[URLLibAdapter] \
		--deselect test/test_adapters.py::test_ssl_context_without_proxy_is_respected[RequestsAdapter] \
		--deselect test/geocoders/algolia.py \
		--deselect test/geocoders/arcgis.py \
		--deselect test/geocoders/azure.py \
		--deselect test/geocoders/baidu.py \
		--deselect test/geocoders/banfrance.py \
		--deselect test/geocoders/bing.py::TestBing \
		--deselect test/geocoders/databc.py \
		--deselect test/geocoders/geocodeearth.py \
		--deselect test/geocoders/geocodefarm.py \
		--deselect test/geocoders/geolake.py::TestGeolake \
		--deselect test/geocoders/geonames.py::TestGeoNames \
		--deselect test/geocoders/geonames.py::TestGeoNamesInvalidAccount \
		--deselect test/geocoders/googlev3.py \
		--deselect test/geocoders/here.py::TestHereApiKey \
		--deselect test/geocoders/here.py::TestHereLegacyAuth \
		--deselect test/geocoders/ignfrance.py \
		--deselect test/geocoders/mapbox.py \
		--deselect test/geocoders/mapquest.py \
		--deselect test/geocoders/maptiler.py \
		--deselect test/geocoders/nominatim.py \
		--deselect test/geocoders/opencage.py::TestOpenCage \
		--deselect test/geocoders/openmapquest.py::TestOpenMapQuest \
		--deselect test/geocoders/pelias.py \
		--deselect test/geocoders/photon.py \
		--deselect test/geocoders/pickpoint.py \
		--deselect test/geocoders/smartystreets.py::TestLiveAddress::test_geocode \
		--deselect test/geocoders/tomtom.py \
		--deselect test/geocoders/what3words.py \
		--deselect test/geocoders/yandex.py
}
