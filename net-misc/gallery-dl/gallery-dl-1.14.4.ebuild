# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{6,7,8})
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit eutils distutils-r1

DESCRIPTION="Download image galleries and collections from several image hosting sites"
HOMEPAGE="https://github.com/mikf/gallery-dl"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mikf/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/mikf/${PN}/archive/v${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="test"
LICENSE="GPL-2"
SLOT="0"
IUSE="bash-completion zsh-completion"

RDEPEND="
	>=dev-python/requests-2.11.0[${PYTHON_USEDEP}]
"

# tests require network access
distutils_enable_tests setup.py

src_compile() {
	if use bash-completion || use zsh-completion
	then
		emake completion
	fi

	emake man

	# this will install shell completion and man pages generated above (if any)
	distutils-r1_src_compile
}

pkg_postinst() {
	elog "To get additional features, some optional runtime dependencies"
	elog "may be installed:"
	elog ""
	optfeature "Pixiv Ugoira to WebM conversion" media-video/ffmpeg
	optfeature "video downloads" net-misc/youtube-dl
}
