# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
PYTHON_REQ_USE="tk"
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

WEB_PV="1.6.2"

DESCRIPTION="MPV-based desktop and cast client for Jellyfin (Unofficial)"
HOMEPAGE="https://github.com/iwalton3/jellyfin-mpv-shim"
SRC_URI="
	https://github.com/iwalton3/jellyfin-mpv-shim/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/iwalton3/jellyfin-web/releases/download/jwc${WEB_PV}-1/dist.zip -> jellyfin-web-${WEB_PV}.zip
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	app-arch/unzip
	$(python_gen_cond_dep \
		dev-python/python-mpv[${PYTHON_USEDEP}]
		dev-python/jellyfin-apiclient-python[${PYTHON_USEDEP}]
		dev-python/python-mpv-jsonipc[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
	)
"
RDEPEND="
	${DEPEND}
	dev-libs/libappindicator:3=
	$(python_gen_cond_dep \
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pystray[${PYTHON_USEDEP}]
		>=dev-python/pywebview-3.3.1[${PYTHON_USEDEP}]
		dev-python/werkzeug[${PYTHON_USEDEP}]
	)
"

src_install() {
	distutils-r1_src_install
	insinto "/usr/$(get_libdir)/${PN}/jellyfin-web"
	doins -r "${WORKDIR}"/dist/*
	dosym "/usr/$(get_libdir)/jellyfin-mpv-shim/jellyfin-web" "$(python_get_sitedir)/${PN//-/_}/webclient_view/webclient"
}
