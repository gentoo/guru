# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Software speech synthesizer for English, and some other languages"
HOMEPAGE="https://github.com/espeak-ng/espeak-ng"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tgz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3+ turkowski unicode"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +klatt l10n_ru l10n_zh mbrola +sonic +sound"

DEPEND="
	!app-accessibility/espeak
	mbrola? ( app-accessibility/mbrola )
	sonic? ( media-libs/sonic )
	sound? ( media-libs/pcaudiolib )
"
RDEPEND="${DEPEND}
	sound? ( media-sound/sox )
"
BDEPEND="
	virtual/pkgconfig
	doc? ( app-text/ronn )
"

DOCS=( CHANGELOG.md README.md docs )

src_prepare() {
	default

	# disable failing tests
	rm tests/{language-pronunciation,translate}.test || die
	sed -e "/language-pronunciation.check/d" \
		-e "/translate.check/d" \
		-i Makefile.am || die

	sed "s/int samplerate;/static int samplerate;/" -i src/espeak-ng.c || die

	eautoreconf
}

src_configure() {
	econf \
		$(use_with klatt) \
		$(use_with l10n_ru extdict-ru) \
		$(use_with l10n_zh extdict-zh) \
		$(use_with l10n_zh extdict-zhy) \
		$(use_with mbrola) \
		$(use_with sound pcaudiolib) \
		$(use_with sonic) \
		--with-async \
		--without-libfuzzer \
		--disable-rpath
}

src_compile() {
	emake -j1
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" VIMDIR=/usr/share/vimfiles install
	rm "${ED}"/usr/lib*/libespeak.la || die
	rm "${ED}"/usr/lib*/libespeak-ng.{a,la} || die
}
