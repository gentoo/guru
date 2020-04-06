# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1 virtualx

DESCRIPTION="Python interface to the mpv media player"
HOMEPAGE="https://github.com/jaseg/python-mpv"
SRC_URI="https://github.com/jaseg/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# XIO:  fatal IO error 0 (Success) on X server ":1114323366"
# looks like upstream changed the test suite to use xvfbwrapper
# but there are still some bugs, tests pass okay, but still get
# the above error
RESTRICT="test"

RDEPEND="
	media-video/mpv[libmpv]
	dev-python/pillow[${PYTHON_USEDEP}]"

DEPEND="test? ( dev-python/xvfbwrapper[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# OSError: [Errno 9] Bad file descriptor
	sed -i -e 's:test_property_observer_decorator:_&:' \
		-e 's:test_register_decorator_fun:_&:' \
		-e 's:test_register_decorator_fun_chaining:_&:' \
		-e 's:test_register_direct_bound_method:_&:' \
		-e 's:test_register_direct_cmd:_&:' \
		-e 's:test_register_simple_decorator_fun_chaining:_&:' \
		-e 's:test_custom_stream:_&:' \
		-e 's:test_create_destroy:_&:' \
		-e 's:test_event_callback:_&:' \
		-e 's:test_flags:_&:' \
		-e 's:test_log_handler:_&:' \
		-e 's:test_options:_&:' \
		-e 's:test_instance_method_property_observer:_&:' \
		-e 's:test_unobserve_property_runtime_error:_&:' \
			mpv-test.py || die

	distutils-r1_python_prepare_all

}

python_test() {
	virtx pytest -vv mpv-test.py
}
