# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_VERIFY_REPO=https://github.com/tox-dev/python-sbom
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{13..14} ) # pdm only supports up to python3.14

inherit distutils-r1 pypi

DESCRIPTION="SBOMs for Python distributions: write PEP 770 CycloneDX SBOMs into wheels"
HOMEPAGE="
	https://github.com/tox-dev/python-sbom
	https://pypi.org/project/python-sbom/
"

LICENSE="MIT Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/installer[${PYTHON_USEDEP}]
	dev-python/jsonschema-rs[${PYTHON_USEDEP}]
	dev-python/packageurl[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/zipremove[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/pdm[${PYTHON_USEDEP}]
		dev-python/uritools[${PYTHON_USEDEP}]
		dev-util/maturin
	)
"

EPYTEST_PLUGINS=( pytest-{cov,mock} )

distutils_enable_tests pytest

python_test() {
	EPYTEST_IGNORE=(
		tests/examples/delocate/test_delocate.py
		tests/examples/maturin/test_maturin_build.py
		tests/examples/cibuildwheel/test_cibuildwheel.py
	)

	epytest
}
