# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1 xdg-utils

DESCRIPTION="Maestral is an open-source Dropbox client written in Python"
HOMEPAGE="https://maestral.app"
SRC_URI="https://github.com/samschott/maestral/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/click-8.0.2[${PYTHON_USEDEP}]
	>=dev-python/desktop-notifier-3.3.0[${PYTHON_USEDEP}]
	>=dev-python/dropbox-sdk-python-10.9.0[${PYTHON_USEDEP}]
	<dev-python/dropbox-sdk-python-12.0.0[${PYTHON_USEDEP}]
	>=dev-python/fasteners-0.15[${PYTHON_USEDEP}]
	>=dev-python/keyring-22.0.0[${PYTHON_USEDEP}]
	>=dev-python/keyrings-alt-3.1.0[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/pathspec-0.5.8[${PYTHON_USEDEP}]
	>=dev-python/Pyro5-5.10[${PYTHON_USEDEP}]
	>=dev-python/requests-2.6.2[${PYTHON_USEDEP}]
	>=dev-python/sdnotify-0.3.2[${PYTHON_USEDEP}]
	>=dev-python/survey-3.4.3[${PYTHON_USEDEP}]
	<dev-python/survey-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/watchdog-2.0.1[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/importlib_metadata[${PYTHON_USEDEP}]' python3_8)
"
BDEPEND="
	test? ( dev-python/pytest-benchmark[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

python_prepare_all()
{
	# this test requires systemd
	sed -i -e 's/test_autostart/_&/' tests/offline/test_cli.py || die

	# this test requires network
	sed -i -e 's/test_check_for_updates/_&/' tests/offline/test_main.py || die

	# this test fails on default gentoo instalation as `/usr/local/share` is missing
	# so use `/usr/share` instead
	# inform upstream https://github.com/samschott/maestral/issues/562
	sed -i -e 's:/local/:/:g' tests/offline/utils/test_path.py || die

	distutils-r1_python_prepare_all
}

pkg_postinst()
{
	xdg_icon_cache_update
}

pkg_postrm()
{
	xdg_icon_cache_update
}
