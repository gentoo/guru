# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{13..15} )

EGIT_REPO_URI="https://github.com/searxng/searxng.git"

inherit distutils-r1 git-r3 systemd

DESCRIPTION="Free internet metasearch engine"
HOMEPAGE="https://docs.searxng.org/"

LICENSE="AGPL-3+"
SLOT="0"

RDEPEND="
	acct-group/searxng
	acct-user/searxng

	$(python_gen_cond_dep '
		dev-python/babel[${PYTHON_USEDEP}]
		dev-python/curl-cffi[${PYTHON_USEDEP}]
		dev-python/flask-babel[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/httpx-socks[${PYTHON_USEDEP}]
		dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/isodate[${PYTHON_USEDEP}]
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/markdown-it-py[${PYTHON_USEDEP}]
		dev-python/msgspec[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/typer[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
		dev-python/valkey[${PYTHON_USEDEP}]
		dev-python/whitenoise[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	test? (
		$(python_gen_cond_dep '
			dev-python/aiounittest[${PYTHON_USEDEP}]
			dev-python/mock[${PYTHON_USEDEP}]
			dev-python/parameterized[${PYTHON_USEDEP}]
		')
	)
"

EPYTEST_DESELECT=(
	"tests/robot/test_webapp.py"
	"tests/unit/test_utils.py::TestXPathUtils::test_eval_xpath_unregistered_function"
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install

	newconfd "${FILESDIR}/searxng.confd" searxng
	newinitd "${FILESDIR}/searxng.initd" searxng
	systemd_dounit "${FILESDIR}/searxng.service"

	insinto /etc/searxng
	doins "${FILESDIR}/settings.yml"

	keepdir /var/lib/searxng
	keepdir /var/log/searxng

	fowners searxng:searxng /etc/searxng
	fowners searxng:searxng /var/lib/searxng
	fowners searxng:searxng /var/log/searxng

	fperms 750 /etc/searxng
	fperms 640 /etc/searxng/settings.yml
	fperms 750 /var/lib/searxng
	fperms 750 /var/log/searxng
}

pkg_postinst() {
	einfo "SearXNG has been installed."
	einfo ""
	einfo "To start:"
	einfo "  OpenRC: rc-update add searxng default && rc-service searxng start"
	einfo "  systemd: systemctl enable --now searxng"
	einfo ""
	einfo "SearXNG will listen on http://127.0.0.1:8888"
}
