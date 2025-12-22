# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Extra Pydantic types"
HOMEPAGE="
	https://github.com/pydantic/pydantic-extra-types
	https://pypi.org/project/pydantic-extra-types/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pydantic-2.5.2[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/phonenumbers[${PYTHON_USEDEP}]
		dev-python/pycountry[${PYTHON_USEDEP}]
		dev-python/semver[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# Requires unpackaged cron-converter
	tests/test_cron.py
	tests/test_json_schema.py
	# Requires unpackaged pendulum
	tests/test_pendulum_dt.py
	# Requires unpackaged python-ulid
	tests/test_ulid.py
)

EPYTEST_DESELECT=(
	# https://github.com/pydantic/pydantic-extra-types/issues/346
	tests/test_coordinate.py::test_json_schema
)

pkg_postinst() {
	optfeature_header "Optional type support"
	optfeature "PhoneNumber" dev-python/phonenumbers
	optfeature "language_code" dev-python/pycountry
	optfeature "semantic_version" dev-python/semver
	# optfeature "ulid" python-ulid
	# optfeature "pendulum_dt" pendulum
	optfeature "mongo_object_id" dev-python/pymongo
	# optfeature "cron" cron-converter
}
