# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} pypy3 )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature

DESCRIPTION="Offline-First Gemini/Web/Gopher/RSS reader and browser"
HOMEPAGE="https://sr.ht/~lioploum/offpunk/"
SRC_URI="https://git.sr.ht/~lioploum/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( doc/. CHANGELOG README.md )

src_install() {
	distutils-r1_src_install
	doman man/*
}

pkg_postinst() {
	optfeature "HTML support" "dev-python/beautifulsoup4 dev-python/readability-lxml"
	optfeature "HTTP support" dev-python/requests
	optfeature "RSS/Atom feed support" dev-python/feedparser
	optfeature "XDG support" x11-misc/xdg-utils
	optfeature "better TOFU certificate validation" dev-python/cryptography
	optfeature "clipboard support" x11-misc/xsel
	optfeature "custom process title support" dev-python/setproctitle
	optfeature "external MP3 player" media-sound/mpg123
	optfeature "external OGG player" media-sound/vorbis-tools[ogg123]
	optfeature "external PDF viewer" app-text/zathura
	optfeature "external image viewer support" media-gfx/feh
	optfeature "inline images support" media-gfx/chafa
}
