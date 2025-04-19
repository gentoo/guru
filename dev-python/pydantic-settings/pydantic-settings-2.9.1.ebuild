# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Settings management using Pydantic"
HOMEPAGE="
	https://pypi.org/project/pydantic-settings/
	https://github.com/pydantic/pydantic-settings
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="yaml"

RDEPEND="
	>=dev-python/pydantic-2.7.0[${PYTHON_USEDEP}]
	dev-python/pydantic-core[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-0.21.0[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	>=dev-python/typing-inspection-0.4.0[${PYTHON_USEDEP}]
	yaml? ( dev-python/pyyaml[${PYTHON_USEDEP}] )
"
BDEPEND="
	test? (
		dev-python/annotated-types[${PYTHON_USEDEP}]
		dev-python/boto3[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# Dependencies not packaged: pytest-examples
	tests/test_docs.py

	# https://github.com/pydantic/pydantic-settings/pull/601
	tests/test_source_azure_key_vault.py

	# https://github.com/pydantic/pydantic-settings/pull/602
	tests/test_source_gcp_secret_manager.py
)

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "AWS Secrets Manager support" dev-python/boto3
}
