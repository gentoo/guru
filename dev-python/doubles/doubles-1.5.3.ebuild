# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Test doubles for Python"
HOMEPAGE="https://github.com/uber/doubles"
SRC_URI="https://github.com/uber/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
	)
"

DOCS=( CHANGES.rst CONTRIBUTING.rst README.rst )

distutils_enable_sphinx docs/source dev-python/sphinx-rtd-theme
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	test/allow_test.py::TestTwice::test_fails_when_called_three_times
	test/allow_test.py::TestOnce::test_fails_when_called_two_times
	test/allow_test.py::TestZeroTimes::test_fails_when_called_once_times
	test/allow_test.py::TestExactly::test_called_with_zero
	test/allow_test.py::TestExactly::test_fails_when_called_more_than_expected_times
	test/allow_test.py::TestAtMost::test_fails_when_called_more_than_at_most_times
	test/class_double_test.py::TestClassDouble::test_raises_when_stubbing_instance_methods
	test/expect_test.py::TestExpect::test_with_args_validator_not_called
	test/expect_test.py::TestExpect::test_raises_if_an_expected_method_call_without_args_is_not_made
	test/expect_test.py::TestExpect::test_raises_if_an_expected_method_call_with_args_is_not_made
	test/expect_test.py::TestExpect::test_raises_if_an_expected_method_call_with_default_args_is_not_made
	test/expect_test.py::TestTwice::test_fails_when_called_once
	test/expect_test.py::TestTwice::test_fails_when_called_three_times
	test/expect_test.py::TestOnce::test_fails_when_called_two_times
	test/expect_test.py::TestExactly::test_fails_when_called_less_than_expected_times
	test/expect_test.py::TestExactly::test_fails_when_called_more_than_expected_times
	test/expect_test.py::TestAtLeast::test_fails_when_called_less_than_at_least_times
	test/expect_test.py::TestAtMost::test_fails_when_called_more_than_at_most_times
	test/expect_test.py::Test__call__::test_unsatisfied_expectation
	test/expect_test.py::Test__enter__::test_unsatisfied_expectation
	test/expect_test.py::Test__exit__::test_unsatisfied_expectation
	test/object_double_test.py::TestObjectDouble::test_raises_when_stubbing_nonexistent_methods
	test/object_double_test.py::TestObjectDouble::test_raises_when_stubbing_noncallable_attributes
	test/pytest_test.py
)

python_prepare() {
	# attempts to import "coverage"
	echo "pytest_plugins = ['doubles.pytest_plugin']" > test/conftest.py || die

	# "Distribution information not found. Run 'setup.py develop'"
	sed "s/pkg_resources.get_distribution.*/'${PV}'/" -i docs/source/conf.py || die
}

python_test() {
	epytest -p no:doubles test
}
