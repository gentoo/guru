# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature

DESCRIPTION="New version checker for software releases"
HOMEPAGE="https://github.com/lilydjwg/nvchecker/"

SRC_URI="https://github.com/lilydjwg/nvchecker/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="
	dev-python/structlog[${PYTHON_USEDEP}]
	|| (
		(
			dev-python/pycurl[${PYTHON_USEDEP}]
			dev-python/tornado[${PYTHON_USEDEP}]
		)
		dev-python/aiohttp[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	test? (
		dev-python/jq[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-httpbin[${PYTHON_USEDEP}]
		$(python_gen_cond_dep \
			'dev-python/zstandard[${PYTHON_USEDEP}]' python3_{11..13})
	)
"

# NOTE: The network-reliant tests are really flaky, as the various websites
#       don't always respond consistently, or may have changed their response.

EPYTEST_DESELECT=(
	# Need missing python libraries
	tests/test_sortversion.py::test_awesomeversion  # awesomeversion
	tests/test_sortversion.py::test_vercmp  # pyalpm

	# "requires makepkg command"
	tests/test_alpm.py::test_alpm
	tests/test_alpm.py::test_alpm_missing_pkg
	tests/test_alpm.py::test_alpm_missing_provides
	tests/test_alpm.py::test_alpm_missing_repo
	tests/test_alpm.py::test_alpm_provided
	tests/test_alpm.py::test_alpm_provided_strip
	tests/test_alpm.py::test_alpm_strip

	# "requires pacman command"
	tests/test_alpmfiles.py::test_alpmfiles
	tests/test_alpmfiles.py::test_alpmfiles_strip
	tests/test_pacman.py::test_pacman
	tests/test_pacman.py::test_pacman_strip_release

	# "KEYFILE not set"
	tests/test_github.py::test_github
	tests/test_github.py::test_github_default_not_master
	tests/test_github.py::test_github_latest_release
	tests/test_github.py::test_github_latest_release_include_prereleases
	tests/test_github.py::test_github_latest_tag
	tests/test_github.py::test_github_max_release
	tests/test_github.py::test_github_max_release_with_ignored
	tests/test_github.py::test_github_max_release_with_include
	tests/test_github.py::test_github_max_tag
	tests/test_github.py::test_github_max_tag_with_ignored
	tests/test_github.py::test_github_max_tag_with_include
	tests/test_github.py::test_github_with_path
	tests/test_github.py::test_github_with_path_and_branch

	# "unconditional skip"
	tests/test_apt.py::test_apt_deepin
	tests/test_mercurial.py::test_mercurial

	# Currently failing due to upstream change. (nvchecker-2.19)
	# Remove in the future
	tests/test_rpmrepo.py::test_rpmrepo_fedora
)

distutils_enable_tests pytest

pkg_postinst() {
	if ! has_version "dev-python/pycurl[${PYTHON_USEDEP}]" || \
		! has_version "dev-python/tornado[${PYTHON_USEDEP}]"; then
		ewarn "This program is using dev-python/aiohttp as networking backend"
		ewarn "However, for the best results, upstream recommends installing the following:"
		ewarn "  dev-python/tornado"
		ewarn "  dev-python/pycurl"
		ewarn
	fi

	optfeature "jq source" "dev-python/jq[${PYTHON_USEDEP}]"
	optfeature "httpheader source" "dev-python/lxml[${PYTHON_USEDEP}]"
	optfeature "pypi source" "dev-python/packaging[${PYTHON_USEDEP}]"
	if use python_targets_python3_11 || \
		use python_targets_python3_12 || \
		use python_targets_python3_13; then
		optfeature "rpmrepo source" "dev-python/zstandard[${PYTHON_USEDEP}]"
	fi
}
