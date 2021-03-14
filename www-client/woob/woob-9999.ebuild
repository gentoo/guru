# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

if [[ "${PV}" == "9999" ]]
then
	EGIT_REPO_URI="https://git.weboob.org/weboob/weboob.git"
	inherit git-r3
else
	SRC_URI="https://git.woob.tech/weboob/weboob/uploads/7b91875f693b60e93c5976daa051034b/weboob-2.0.tar.gz"
	S="${WORKDIR}/weboob-${PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Consume lots of websites without a browser (Web Outside Of Browsers)"
HOMEPAGE="https://woob.tech/"
LICENSE="LGPL-3+"
SLOT="0"
IUSE="test"
#RESTRICT="!test ( test )"

# setup.cfg + .ci/requirements.txt + .ci/requirements-module.txt
COMMON_DEPEND="
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/html2text[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/unidecode[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/Babel[${PYTHON_USEDEP}]

	dev-python/prettytable[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/unidecode[${PYTHON_USEDEP}]
"
# setup.cfg + .ci/requirements.txt + .ci/requirements-module.txt
DEPEND="
	${COMMON_DEPEND}
	test? (
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/xunitparser[${PYTHON_USEDEP}]
		>=dev-python/coverage-5.1[${PYTHON_USEDEP}]

		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pyflakes[${PYTHON_USEDEP}]
		dev-python/asttokens[${PYTHON_USEDEP}]

		dev-python/feedparser[${PYTHON_USEDEP}]
		dev-python/python-jose[${PYTHON_USEDEP}]
		dev-python/geopy[${PYTHON_USEDEP}]
		dev-python/selenium[${PYTHON_USEDEP}]
	)
"
RDEPEND="${COMMON_DEPEND}"

distutils_enable_tests nose

src_prepare() {
	default

	sed -i \
		-e '/weboob.browser.browsers,/d' \
		-e '/weboob.browser.pages,/d' \
		setup.cfg || die "Failed removing network-dependent tests"
}

python_install_all() {
	distutils-r1_python_install_all
	insinto /usr/share/${PN}/
	doins -r contrib
}
