# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Python Reddit API Wrapper"
HOMEPAGE="https://pypi.org/project/praw/ https://github.com/praw-dev/praw"
SRC_URI="https://github.com/praw-dev/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {AUTHORS,CHANGES,README}.rst SECURITY.md )

RDEPEND="
	<dev-python/prawcore-3[${PYTHON_USEDEP}]
	dev-python/websocket-client[${PYTHON_USEDEP}]
"
BDEPEND="test? (
	dev-python/betamax[${PYTHON_USEDEP}]
	dev-python/betamax-matchers[${PYTHON_USEDEP}]
)"

# TODO: remove in next release
EPYTEST_DESELECT=(
	tests/unit/test_deprecations.py
	tests/unit/util/test_deprecate_args.py
	tests/unit/models/reddit/test_submission.py::TestSubmission::test_comment_sort_warning
	tests/unit/models/reddit/test_submission.py::TestSubmission::test_comment_sort_warning__disabled
)

distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

distutils_enable_tests pytest

python_prepare_all() {
	# disable optional dependencies
	sed "/update_checker/d" -i setup.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	local epytestargs=(
		# spams deprecation warnings
		-p no:asyncio
	)
	epytest "${epytestargs[@]}"
}
