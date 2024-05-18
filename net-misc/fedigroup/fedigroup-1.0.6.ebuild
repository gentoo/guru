# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
PYPI_PN="${PN}.py"
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Emulate group accounts on Mastodon/Pleroma"
HOMEPAGE="
	https://pypi.org/project/fedigroup.py/
	https://github.com/uanet-exception/fedigroup.py
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/fedigroup
	$(python_gen_cond_dep '
		dev-python/mastodon-py[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	')
"

src_install() {
	distutils-r1_src_install

	newinitd "${FILESDIR}"/fedigroup.initd ${PN}
	newconfd "${FILESDIR}"/fedigroup.confd ${PN}

	diropts --owner fedigroup --group fedigroup
	keepdir /var/lib/fedigroup
}
