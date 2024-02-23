# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PLOCALES="cs de es fr_FR hu id it ja_JP nb_NO pl pt pt_BR pt_PT ru sv tr zh_CN"

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit cmake desktop distutils-r1 plocale

DESCRIPTION="The desktop music player of today!"
HOMEPAGE="https://tauonmusicbox.rocks/"

if [[ ${PV} == *9999 ]]; then
	EGIT_SUBMODULES=()
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Taiko2k/${PN}"
else
	SRC_URI="https://github.com/Taiko2k/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

PHAZOR_DEPS="
	dev-libs/miniaudio
	media-libs/flac
	media-libs/libopenmpt
	media-sound/mpg123
	media-libs/opus
	media-libs/opusfile
	media-sound/wavpack
	media-libs/libsamplerate
	sci-libs/kissfft[-cpu_flags_x86_sse]
"

DEPEND="
	dev-python/musicbrainzngs[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/PySDL2[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]

	${PHAZOR_DEPS}
"

RDEPEND="
	${DEPEND}

	dev-libs/libappindicator
"

BDEPEND="sys-devel/gettext"

src_prepare() {
	# Workaround. If PATCHES is used it would be applied to times and fail
	eapply "${FILESDIR}/${PN}-fix-build-system.patch"

	distutils-r1_src_prepare
	cmake_src_prepare
}

src_configure() {
	distutils-r1_src_configure
	cmake_src_configure
}

src_compile() {
	distutils-r1_src_compile
	cmake_src_compile

	build_locale() {
		msgfmt -o "locale/${1}/LC_MESSAGES/tauon.mo" "locale/${1}/LC_MESSAGES/tauon.po" || die
	}

	plocale_for_each_locale build_locale
}

src_test() {
	distutils-r1_src_test
	cmake_src_test
}

python_install() {
	newbin tauon.py tauon
	dolib.so  "${WORKDIR}/${P}_build/libphazor.so"

	install_locale() {
		insinto "/usr/share/locale/${1}/LC_MESSAGES"
		doins "locale/${1}/LC_MESSAGES/tauon.mo"
	}

	plocale_for_each_locale install_locale

	insinto "/usr/share/${PN}"
	doins -r assets theme templates
	doins input.txt

	sed -i 's/\/opt\/tauon-music-box\/tauonmb.sh/tauon/g' extra/tauonmb.desktop || die
	domenu extra/tauonmb.desktop
	doicon -s scalable extra/tauonmb.svg

	distutils-r1_python_install
}
