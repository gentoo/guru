# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

MY_PN=${PN/-/.}
COMMIT="18654218da069865716179d7f07640869a5e1fe8"
DESCRIPTION="vim plugin: syntax highlighting for Gemini Text, the text/gemini media type"
HOMEPAGE="https://sr.ht/~torresjrjr/gemini.vim/"
SRC_URI="https://git.sr.ht/~torresjrjr/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
