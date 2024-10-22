# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Settings management using Pydantic"
HOMEPAGE="
	https://pypi.org/project/pydantic-settings/
	https://github.com/pydantic/pydantic-settings
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pydantic-2.7.0[${PYTHON_USEDEP}]
	dev-python/pydantic-core[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-0.21.0[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/annotated-types[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/tomli[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# Dependencies not packaged: pytest-examples
	tests/test_docs.py
	# Dependencies not packaged: azure-keyvault-secrets, azure-identity
	tests/test_source_azure_key_vault.py
)

EPYTEST_DESELECT=(
	# Failed: DID NOT RAISE <class 'UserWarning'>
	tests/test_settings.py::test_protected_namespace_defaults
)

distutils_enable_tests pytest

python_test() {
	# Parsing --help output is width dependent
	local -x COLUMNS=80

	# Ebuild's "A" variable conflicts with test expectations
	local -x A=

	epytest
}
