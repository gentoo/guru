# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

COMMIT="822712d80b4ad5bc5c241ab0a778ede812ec501f"
DESCRIPTION="vim plugin: extends the Conceal feature for LaTeX"
HOMEPAGE="https://github.com/KeitaNakamura/tex-conceal.vim"
SRC_URI="https://github.com/KeitaNakamura/${PN}.vim/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}.vim-${COMMIT}"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
