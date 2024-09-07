# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )

inherit font python-any-r1

NOTO_PV="2.034"
DESCRIPTION="A color emoji font with a flat visual style, designed and used by Twitter"
HOMEPAGE="
	https://twemoji.twitter.com
	https://github.com/twitter/twemoji
"
SRC_URI="
	https://github.com/googlefonts/noto-emoji/archive/refs/tags/v${NOTO_PV}.tar.gz -> ${P}-noto.tar.gz
	https://github.com/twitter/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}/noto-emoji-${NOTO_PV}"

LICENSE="Apache-2.0 CC-BY-4.0 MIT OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	${PYTHON_DEPS}
	app-arch/zopfli
	media-gfx/pngquant
	x11-libs/cairo
	|| (
		media-gfx/imagemagick[png]
		media-gfx/graphicsmagick[png]
	)
	$(python_gen_any_dep '
		>=dev-python/fonttools-4.7.0[${PYTHON_USEDEP}]
		>=dev-python/notofonttools-0.2.13[${PYTHON_USEDEP}]
	')
"

RESTRICT="binchecks strip"

DOCS=( CONTRIBUTING.md FOLDERS.md LEGACY.md README.md )

PATCHES=(
	# https://github.com/googlei18n/noto-emoji/issues/240
	"${FILESDIR}"/noto-build-path.patch
	# Be more verbose
	"${FILESDIR}"/noto-pngquant-verbose.patch

)

FONT_S="${S}"
FONT_SUFFIX="ttf"
FONT_CONF=( "${FILESDIR}"/75-${PN}.conf )

python_check_deps() {
	python_has_version "dev-python/fonttools[${PYTHON_USEDEP}]" &&
	python_has_version "dev-python/notofonttools[${PYTHON_USEDEP}]"
}

pkg_setup() {
	python-any-r1_pkg_setup
	font_pkg_setup
}

src_unpack() {
	default

	mv "${WORKDIR}"/${P}/assets "${S}" || die
	mv "${WORKDIR}"/${P}/*.md "${S}" || die
}

src_prepare() {
	default

	# Be more verbose
	sed -i -e 's:\(@$(ZOPFLIPNG) -y "$<" "$@"\) 1> /dev/null 2>&1:\1:g' Makefile || die

	# Based on Fedora patch to allow graphicsmagick usage
	if has_version -b media-gfx/graphicsmagick; then
		eapply "${FILESDIR}/noto-use-gm.patch"
	fi

	sed NotoColorEmoji.tmpl.ttx.tmpl \
		-e "s/Noto Color Emoji/${PN^}/" \
		-e "s/NotoColorEmoji/${PN^}/" \
		-e "s/Copyright .* Google Inc\./Twitter, Inc and other contributors./" \
		-e "s/ Version .*/ ${PV}/" \
		-e "s/.*is a trademark.*//" \
		-e "s/Google, Inc\./Twitter, Inc and other contributors/" \
		-e "s,http://www.google.com/get/noto/,https://twemoji.twitter.com," \
		-e "s/.*is licensed under.*/      Creative Commons Attribution 4.0 International/" \
		-e "s,http://scripts.sil.org/OFL,http://creativecommons.org/licenses/by/4.0/," \
		> ${PN^}.tmpl.ttx.tmpl || die

	pushd assets/72x72 || die
	for png in *.png; do
		mv ${png} emoji_u${png//-/_} || die
	done
}

src_compile() {
	local mymakeflags=(
		EMOJI="${PN^}"
		EMOJI_SRC_DIR="assets/72x72"
		FLAGS=""
		BODY_DIMENSIONS="76x72"
		BYPASS_SEQUENCE_CHECK="true"
		VIRTUAL_ENV="true"
	)

	emake "${mymakeflags[@]}"
}

src_install() {
	rm NotoColorEmoji_WindowsCompatible.ttf *.tmpl.ttf || die

	# Don't lose fancy emoji icons
	insinto /usr/share/icons/${PN}/72/emotes/
	doins assets/72x72/*.png

	insinto /usr/share/icons/${PN}/scalable/emotes/
	doins assets/svg/*.svg

	font_src_install
	einstalldocs
}
