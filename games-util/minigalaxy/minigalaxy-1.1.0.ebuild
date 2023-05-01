# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 optfeature xdg

DESCRIPTION="A simple GOG client for Linux"
HOMEPAGE="https://github.com/sharkwouter/minigalaxy"
SRC_URI="https://github.com/sharkwouter/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	>=net-libs/webkit-gtk-2.6
	>=x11-libs/gtk+-3
"
BDEPEND="test? (
	$(python_gen_cond_dep '
		dev-python/simplejson[${PYTHON_USEDEP}]')
)"

distutils_enable_tests unittest

python_prepare_all() {
	# AttributeError: module 'minigalaxy.ui' has no attribute 'window'
	rm tests/test_ui_window.py || die

	# TypeError: issubclass() arg 2 must be a class or tuple of classes
	rm tests/test_ui_library.py || die

	# fails
	sed "s/test_create_config/_\0/" -i tests/test_config.py || die

	# require network
	test_api_net=(
		test1_get_library
		test_get_download_file_md5
		test1_can_connect
		test2_get_download_info
	)
	for fn in "${test_api_net[@]}"; do
		sed "s/def ${fn}/def _${fn}/" -i tests/test_api.py || die
	done

	# fail
	test_installer_fail=(
		test_remove_installer_from_keep
		test_remove_installer_keep
		test_remove_installer_same_content
	)
	for fn in "${test_installer_fail[@]}"; do
		sed "s/def ${fn}/def _${fn}/" -i tests/test_installer.py || die
	done

	distutils-r1_python_prepare_all
}

python_test() {
	eval unset ${!LC_*} LANG

	cp minigalaxy/paths.py minigalaxy/paths.py.bak || die
	sed "s:\(LAUNCH_DIR =\) .*:\1 \"${BUILD_DIR}/test/usr/bin\":" \
		-i minigalaxy/paths.py || die

	distutils_install_for_testing
	distutils-r1_python_test

	mv -f minigalaxy/paths.py.bak minigalaxy/paths.py || die
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "running games with system dosbox" games-emulation/dosbox
	optfeature "running games with system scummvm" games-engines/scummvm
}
