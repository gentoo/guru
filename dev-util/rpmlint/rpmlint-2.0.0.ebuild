# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="Tool for checking common errors in RPM packages"
HOMEPAGE="https://github.com/rpm-software-management/rpmlint"
SRC_URI="https://github.com/rpm-software-management/rpmlint/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
	app-arch/bzip2
	app-arch/cpio
	app-arch/gzip
	app-arch/xz-utils
	app-arch/zstd
	sys-devel/binutils:*

	$(python_gen_cond_dep '
		app-arch/rpm[python,${PYTHON_SINGLE_USEDEP}]
		dev-python/pybeam[${PYTHON_USEDEP}]
		dev-python/pyxdg[${PYTHON_USEDEP}]
		dev-python/toml[${PYTHON_USEDEP}]
		dev-python/zstd[${PYTHON_USEDEP}]
	')
"
DEPEND="
	${RDEPEND}
	test? (
		app-shells/dash
		dev-libs/appstream-glib
		dev-util/desktop-file-utils
		dev-util/devscripts
		|| (
			( app-text/hunspell[l10n_cs,l10n_en] app-text/enchant[hunspell] )
			( app-text/aspell[l10n_cs,l10n_en] app-text/enchant[aspell] )
		)

		$(python_gen_cond_dep '
			dev-python/pyenchant[${PYTHON_USEDEP}]
			dev-python/pytest-xdist[${PYTHON_USEDEP}]
			dev-python/python-magic[${PYTHON_USEDEP}]
		')
	)
"

PATCHES=( "${FILESDIR}/no-coverage.patch" )

distutils_enable_tests pytest

python_test() {
	pytest -vv \
			--deselect test/test_speccheck.py::test_check_invalid_url[spec/SpecCheck2] \
			--deselect test/test_lint.py::test_run_installed_and_no_files \
			--deselect test/test_lint.py::test_run_installed[packages0] \
			--deselect test/test_ldd_parser.py::test_dependencies \
	|| die
}
