# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="A collection of plugins for the BuildStream project"
HOMEPAGE="https://apache.github.io/buildstream-plugins/"
SRC_URI="
	https://github.com/apache/buildstream-plugins/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	dev-build/buildstream:2[${PYTHON_USEDEP}]
"

BDEPEND="
	virtual/pkgconfig
	test? (
		dev-python/pycodestyle[${PYTHON_USEDEP}]
		dev-python/pyftpdlib[${PYTHON_USEDEP}]
		dev-python/pylint[${PYTHON_USEDEP}]
		dev-python/pytest-datafiles[${PYTHON_USEDEP}]
		dev-python/pytest-env[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
	)
"

RESTRICT="!test? ( test )"

EPYTEST_PLUGINS=( pytest-datafiles )
distutils_enable_tests pytest

python_test() {
	# UNKNOWN:Path name should not have more than 107 characters
	local TMPDIR=/tmp

	# fuse: failed to open /dev/fuse: Permission denied
	addwrite "/dev/fuse"
	# still fails inside a bubblewrap container :/
	# fusermount3: mount failed: Operation not permitted

	local EPYTEST_DESELECT=(
		# fuse tests
		tests/sources/cargo.py::test_cargo_track_fetch_build
		tests/sources/patch.py::test_stage_and_patch
		tests/sources/patch.py::test_stage_file_nonexistent_dir
		tests/sources/patch.py::test_stage_file_empty_dir
		tests/sources/patch.py::test_stage_separate_patch_dir
		tests/sources/patch.py::test_stage_multiple_patches
		tests/sources/patch.py::test_patch_strip_level
		# tests using network
		tests/sources/docker.py::test_docker_fetch
		tests/sources/docker.py::test_docker_source_checkout
		tests/sources/docker.py::test_handle_network_error
		tests/sources/docker.py::test_fetch_duplicate_layers
		source_determinism.py::test_deterministic_source_umask[git]
	)

	export BST_TEST_SUITE=1

	# to not pollute the source directory and make grepping hard.
	# can't just use ${T} as the --basetemp option removes the directory
	# if it exists
	epytest --basetemp "${T}"/test_dir
}
