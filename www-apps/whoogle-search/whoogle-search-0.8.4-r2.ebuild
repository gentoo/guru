# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=no
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 systemd

DESCRIPTION="A self-hosted, ad-free, privacy-respecting metasearch engine"
HOMEPAGE="https://github.com/benbusby/whoogle-search"
SRC_URI="https://github.com/benbusby/whoogle-search/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
		dev-python/cssutils[${PYTHON_USEDEP}]
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
        dev-python/python-dotenv[${PYTHON_USEDEP}]
		dev-python/defusedxml[${PYTHON_USEDEP}]
		dev-python/waitress[${PYTHON_USEDEP}]
		dev-python/validators[${PYTHON_USEDEP}]
        app-arch/brotli[${PYTHON_USEDEP},python]
        net-libs/stem
        acct-user/whoogle
        acct-group/whoogle
"


src_install() {
    rm -r .github docs test .dockerignore .gitignore .replit docker-compose.yml Dockerfile heroku.yml MANIFEST.in README.md requirements.txt
    mkdir -p "${ED}/opt/whoogle-search" || die
    insinto /opt/whoogle-search
    doins -r ./*
    fperms -R 0755 /opt/whoogle-search
	fowners -R whoogle:whoogle /opt/whoogle-search

    insinto /etc/default/
    doins ${FILESDIR}/whoogle
    insinto /usr/lib/sysusers.d/
    doins ${FILESDIR}/whoogle.conf

    newinitd "${FILESDIR}"/whoogle.initd whoogle
    systemd_dounit ${FILESDIR}/whoogle.service
}
