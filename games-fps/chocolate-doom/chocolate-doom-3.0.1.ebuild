# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit autotools python-any-r1 xdg

DESCRIPTION="A Doom source port that is minimalist and historically accurate"
HOMEPAGE="https://www.chocolate-doom.org"
SRC_URI="https://github.com/${PN}/${PN}/archive/${P}.tar.gz"

LICENSE="BSD GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion doc libsamplerate +midi png vorbis"

DEPEND="
	media-libs/libsdl2
	media-libs/sdl2-mixer[midi?,vorbis?]
	media-libs/sdl2-net
	libsamplerate? ( media-libs/libsamplerate )
	png? ( media-libs/libpng:= )"
RDEPEND="${DEPEND}"
BDEPEND="
	bash-completion? ( ${PYTHON_DEPS} )
	doc? ( ${PYTHON_DEPS} )"

S="${WORKDIR}/${PN}-${P}"

PATCHES=(
	"${FILESDIR}/${P}-overhaul-manpages-add-parameters.patch"
	"${FILESDIR}/${P}-further-manpage-substitutions-and-fixes.patch"
	"${FILESDIR}/${P}-bash-completion-run-docgen-with-z-argument.patch"
	"${FILESDIR}/${P}-install-AppStream-metadata-into-the-proper-location.patch"
	"${FILESDIR}/${P}-Update-AppStream-XML-files-to-current-0.11-standards.patch"
	"${FILESDIR}/${P}-bash-completion-Build-from-actual-shell-script-templ.patch"
	"${FILESDIR}/${P}-configure-add-AM_PROG_AR-macro.patch"
	"${FILESDIR}/${P}-bash-completion-always-install-into-datadir-bash-com.patch"
	"${FILESDIR}/${P}-Update-to-latest-AppStream-formerly-AppData-standard.patch"
	"${FILESDIR}/${P}-use-reverse-DNS-naming-for-installing-.desktop-files.patch"
	"${FILESDIR}/${P}-Introduce-configure-options-for-bash-completion-doc-.patch"
	"${FILESDIR}/${P}-Add-support-for-usr-share-doom-IWAD-search-path.patch"
	"${FILESDIR}/${P}-Update-documentation-about-usr-share-doom-IWAD-locat.patch"
)

DOCS=(
	"AUTHORS"
	"ChangeLog"
	"NEWS.md"
	"NOT-BUGS.md"
	"PHILOSOPHY.md"
	"README.md"
	"README.Music.md"
	"README.Strife.md"
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable bash-completion) \
		$(use_enable doc) \
		--disable-fonts \
		--disable-icons \
		$(use_with libsamplerate) \
		$(use_with png libpng)
}

src_install() {
	emake DESTDIR="${D}" install

	# Remove redundant documentation files
	rm -r "${ED}/usr/share/doc/"* || die

	einstalldocs
}
