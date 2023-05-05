# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm
PYTHON_COMPAT=( python3_{10..11} )

inherit bash-completion-r1 distutils-r1 pypi

DESCRIPTION="Modern Python package and dependency manager supporting latest PEP standards"
HOMEPAGE="
	https://github.com/pdm-project/pdm/
	https://pypi.org/project/pdm/
"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	dev-python/blinker[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	<dev-python/urllib3-2.0.0[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/virtualenv[${PYTHON_USEDEP}]
	dev-python/pyproject-hooks[${PYTHON_USEDEP}]
	dev-python/requests-toolbelt[${PYTHON_USEDEP}]
	>=dev-python/unearth-0.9.0[${PYTHON_USEDEP}]
	dev-python/findpython[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	dev-python/shellingham[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]
	dev-python/resolvelib[${PYTHON_USEDEP}]
	dev-python/installer[${PYTHON_USEDEP}]
	dev-python/cachecontrol[${PYTHON_USEDEP}]

	$(python_gen_cond_dep '
		dev-python/tomli[${PYTHON_USEDEP}]
	' 3.10)
"
BDEPEND="
	${RDEPEND}
	test? (
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/pytest-rerunfailures[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/pdm-2.5.1-build-backend.patch"
)

distutils_enable_tests pytest

python_compile_all() {
	PDM_CHECK_UPDATE=0 "${EPYTHON}" -m pdm completion bash > completion.bash || die
	PDM_CHECK_UPDATE=0 "${EPYTHON}" -m pdm completion zsh > completion.zsh || die
}

python_test() {
	local EPYTEST_DESELECT=()

	[[ ${EPYTHON} == python3.11 ]] && EPYTEST_DESELECT+=(
		# TODO
		tests/cli/test_others.py::test_build_distributions
		tests/models/test_candidates.py::test_expand_project_root_in_url
	)

	epytest -m "not network"
}

python_install_all() {
	distutils-r1_python_install_all

	newbashcomp completion.bash pdm

	insinto /usr/share/zsh/site-functions
	newins completion.zsh _pdm
}
