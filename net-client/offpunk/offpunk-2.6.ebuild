# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 optfeature

DESCRIPTION="Offline-First Gemini/Web/Gopher/RSS reader and browser"
HOMEPAGE="
	https://offpunk.net/
	https://sr.ht/~lioploum/offpunk/
"
SRC_URI="https://git.sr.ht/~lioploum/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		$(python_gen_cond_dep '
			dev-python/pytest-mock[${PYTHON_USEDEP}]
		')
	)
"

DOCS=( doc/. CHANGELOG CONTRIBUTORS README.md TODO )

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	doman man/*
}

pkg_postinst() {
	optfeature "HTML support" "dev-python/beautifulsoup4 dev-python/readability-lxml"
	optfeature "HTTP support" dev-python/requests
	optfeature "RSS/Atom feed support" dev-python/feedparser
	optfeature "Wayland clipboard support" gui-apps/wl-clipboard
	optfeature "X11 clipboard support" x11-misc/xsel x11-misc/xclip
	optfeature "XDG support" x11-misc/xdg-utils
	optfeature "better TOFU certificate validation" dev-python/cryptography
	optfeature "custom process title support" dev-python/setproctitle
	optfeature "inline images support" media-gfx/chafa media-gfx/timg
	optfeature "text encoding detection" dev-python/chardet
}
