# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit bash-completion-r1 distutils-r1

DESCRIPTION="youtube-dl fork with additional features and fixes"
HOMEPAGE="https://ytdl-org.github.io/youtube-dl"
SRC_URI="https://github.com/ytdl-org/${PN}/releases/download/${PV}/${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~riscv ~x86"
# Disable test suite because it is two slow and require network access
RESTRICT="test"

RDEPEND="
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	!net-misc/yt-dlp
"

src_prepare() {
	distutils-r1_src_prepare
	sed -i 's|etc/bash_completion.d|share/bash-completion/completions|' setup.py || die
	sed -i 's|etc/fish/completions|share/fish/vendor_completions.d|' setup.py || die
	sed -i '/youtube-dl.bash-completion/d' setup.py || die
	sed -i '/README.txt/d' setup.py || die
}

python_install_all() {
	dodoc "${S}"/{AUTHORS,ChangeLog,README.*}
	doman "${S}"/youtube-dl.1
	newbashcomp "${S}"/youtube-dl.bash-completion youtube-dl

	insinto /usr/share/fish/vendor_completions.d
	doins "${S}"/youtube-dl.fish

	insinto /usr/share/zsh/site-functions
	doins "${S}"/youtube-dl.zsh
}
