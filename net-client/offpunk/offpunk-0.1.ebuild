# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 optfeature

MY_PN="av-98-offline"
DESCRIPTION="A command-line, text-based and offline-first Gemini browser"
HOMEPAGE="https://tildegit.org/ploum/AV-98-offline"
SRC_URI="https://tildegit.org/ploum/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

pkg_postinst() {
	optfeature "better TOFU certificate validation" dev-python/cryptography
	#optfeature "ANSI escape codes support" dev-python/ansiwrap
	optfeature "MIME type detection support" dev-python/python-magic
	optfeature "clipboard support" x11-misc/xsel
}
