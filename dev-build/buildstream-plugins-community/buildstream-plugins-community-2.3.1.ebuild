# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="A collection of community maintained plugins for the BuildStream project"
HOMEPAGE="https://buildstream.gitlab.io/buildstream-plugins-community/"
SRC_URI="https://gitlab.com/BuildStream/buildstream-plugins-community/-/archive/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	dev-build/buildstream:2[${PYTHON_USEDEP}]
	dev-python/arpy[${PYTHON_USEDEP}]
	dev-python/dulwich[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/pycodestyle[${PYTHON_USEDEP}]
		dev-python/pyftpdlib[${PYTHON_USEDEP}]
		dev-python/pylint[${PYTHON_USEDEP}]
		dev-python/pytest-datafiles[${PYTHON_USEDEP}]
		dev-python/pytest-env[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
		dev-python/setuptools-scm[${PYTHON_USEDEP}]
		dev-util/ostree
		dev-util/quilt
		dev-vcs/git-lfs
	)
"

RESTRICT="!test? ( test )"

EPYTEST_PLUGINS=( pytest-datafiles )

distutils_enable_tests pytest

src_configure() {
	# pyproject contains `version=dynamic`
	export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

	distutils-r1_src_configure
}

python_test() {
	# UNKNOWN:Path name should not have more than 107 characters
	local TMPDIR=/tmp

	# fuse: failed to open /dev/fuse: Permission denied
	addwrite "/dev/fuse"
	# still fails inside a bubblewrap container :/
	# fusermount3: mount failed: Operation not permitted

	EPYTEST_DESELECT=(
		# fuse tests
		tests/sources/bazel.py::test_basic
		tests/sources/bazel.py::test_multi_url
		tests/sources/bazel.py::test_no_sha
		# tests using network
		tests/sources/bazel_file.py::test_basic
		tests/sources/bazel_file.py::test_multi_url
		source_determinism.py::test_deterministic_source_umask[git_tag]
		source_determinism.py::test_deterministic_source_umask[zip]
	)

	export BST_TEST_SUITE=1

	# to not pollute the source directory and make grepping hard.
	# can't just use ${T} as the --basetemp option removes the directory
	# if it exists
	epytest --basetemp "${T}"/test_dir
}
