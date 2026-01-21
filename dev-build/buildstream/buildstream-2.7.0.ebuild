# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 linux-info optfeature shell-completion

DESCRIPTION="The software integration tool"
HOMEPAGE="https://buildstream.build/"
# zsh completion & docs not packaged in pypi tarball
SRC_URI="
	https://github.com/apache/buildstream/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz

	doc? ( https://github.com/apache/buildstream/releases/download/${PV}/docs.tgz
			-> ${P}-docs.tgz )
"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64"
IUSE="doc test"

# https://docs.buildstream.build/master/main_install.html#runtime-requirements
# pyproject.toml, requiremnts/*.txt
RDEPEND="
	dev-util/buildbox[casd,fuse,recc]
	dev-vcs/git
	app-alternatives/tar
	sys-devel/patch
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/grpcio[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/pluginbase[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml-clib[${PYTHON_USEDEP}]
	dev-python/pyroaring[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	test? (
		app-alternatives/lzip
		dev-build/buildstream-plugins:2[${PYTHON_USEDEP}]
		dev-python/astroid[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/dill[${PYTHON_USEDEP}]
		dev-python/exceptiongroup[${PYTHON_USEDEP}]
		dev-python/execnet[${PYTHON_USEDEP}]
		dev-python/iniconfig[${PYTHON_USEDEP}]
		dev-python/isort[${PYTHON_USEDEP}]
		dev-python/markupsafe[${PYTHON_USEDEP}]
		dev-python/mccabe[${PYTHON_USEDEP}]
		dev-python/pexpect[${PYTHON_USEDEP}]
		dev-python/platformdirs[${PYTHON_USEDEP}]
		dev-python/ptyprocess[${PYTHON_USEDEP}]
		dev-python/pylint[${PYTHON_USEDEP}]
		dev-python/pyftpdlib[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/pytest-datafiles[${PYTHON_USEDEP}]
		dev-python/pytest-env[${PYTHON_USEDEP}]
		dev-python/pytest-expect[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		dev-python/tomli[${PYTHON_USEDEP}]
		dev-python/tomlkit[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
		dev-util/ostree
	)
"

RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}"/${P}-rename-the-destination-of-the-plugins-option.patch
)

EPYTEST_PLUGINS=( pytest-{timeout,datafiles,env} )

distutils_enable_tests pytest

src_unpack() {
	if use doc; then
		# docs don't contain a parent directory, just spills into ${WORKDIR}
		unpack ${P}-docs.tgz
		mkdir  "${T}"/docs || die
		mv ./* "${T}"/docs || die
	fi

	unpack ${P}.tar.gz
}

pkg_setup() {
	CONFIG_CHECK="~FUSE_FS"
	linux-info_pkg_setup
}

python_test() {
	# https://projects.gentoo.org/python/guide/test.html#installing-extra-dependencies-in-test-environment-pep-517-mode
	cp -a "${BUILD_DIR}"/{install,test} || die
	local -x PATH=${BUILD_DIR}/test/usr/bin:${PATH}

	# install the samples plugins or else tests using it get skipped
	pushd tests/plugins/sample-plugins >/dev/null || die
	distutils_pep517_install "${BUILD_DIR}"/test
	popd >/dev/null || die

	# tox.ini
	export BST_TEST_HOME=${HOME}
	export BST_TEST_XDG_CACHE_HOME=${HOME}/cache
	export BST_TEST_XDG_CONFIG_HOME=${HOME}/config
	export BST_TEST_XDG_DATA_HOME=${HOME}/share

	# fuse: failed to open /dev/fuse: Permission denied
	addwrite "/dev/fuse"
	# still fails inside a bubblewrap container :/
	# fusermount3: mount failed: Operation not permitted

	local EPYTEST_DESELECT=(
		# the git_tag and zip tests fail
		# `no sample plugin available for {zip,git_tag}`
		tests/frontend/workspace.py::test_build[project-no-guess-strict-git_tag]
		tests/frontend/workspace.py::test_build[project-no-guess-strict-zip]
		tests/frontend/workspace.py::test_build[project-no-guess-non-strict-git_tag]
		tests/frontend/workspace.py::test_build[project-no-guess-non-strict-zip]
		tests/frontend/workspace.py::test_build[workspace-guess-strict-git_tag]
		tests/frontend/workspace.py::test_build[workspace-guess-strict-zip]
		tests/frontend/workspace.py::test_build[workspace-guess-non-strict-git_tag]
		tests/frontend/workspace.py::test_build[workspace-guess-non-strict-zip]
		tests/frontend/workspace.py::test_build[workspace-no-guess-strict-git_tag]
		tests/frontend/workspace.py::test_build[workspace-no-guess-strict-zip]
		tests/frontend/workspace.py::test_build[workspace-no-guess-non-strict-git_tag]
		tests/frontend/workspace.py::test_build[workspace-no-guess-non-strict-zip]
		# fuse tests
		# "std::runtime_error exception thrown at [buildboxcommon_fusestager.cpp:149], errMsg = "The FUSE stager child process unexpectedly died with exit code 2""
		# TODO: test on host instead of container with /dev/fuse mounted
		tests/sourcecache
		tests/sources
	)

	# to not pollute the source directory and make grepping hard.
	# can't just use ${T} as the --basetemp option removes the directory
	# if it exists
	epytest --basetemp "${T}"/test_dir
}

src_install() {
	distutils-r1_src_install

	dobashcomp src/${PN}/data/bst
	dozshcomp src/${PN}/data/zsh/_bst

	if use doc; then
		HTML_DOCS=( "${T}"/docs/* )
		einstalldocs
	fi
}

pkg_postinst() {
	for i in dev-build/buildstream-plugins{,-community}; do
		if ! has_version ${i}; then
			elog "Please install ${i} for additional functionality via plugins."
		fi
	done

	! has_version app-arch/lzip && \
		optfeature "extraction of .tar.lz sources" app-alternatives/lzip
	! has_version dev-util/ostree && \
		optfeature "ostree based source integration" dev-util/ostree
}
