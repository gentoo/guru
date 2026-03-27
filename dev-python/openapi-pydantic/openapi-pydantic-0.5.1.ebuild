EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Modern, type-safe OpenAPI schemas in Python using Pydantic 1.8+ and 2.x"
HOMEPAGE="
	https://github.com/mike-oakley/openapi-pydantic
	https://pypi.org/project/openapi-pydantic/
"
SRC_URI="
	https://github.com/mike-oakley/openapi-pydantic/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/pydantic-1.8[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/openapi-spec-validator-0.7.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
