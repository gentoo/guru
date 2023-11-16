# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_REMOVE_MODULES_LIST=( VersionFromGit )
inherit cmake verify-sig

DESCRIPTION="TTS engine with extended languages support (including Russian)"
HOMEPAGE="https://rhvoice.su https://github.com/RHVoice/RHVoice"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tar.gz
	verify-sig? ( https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tar.gz.sig )"

AGPL_LANGS=( mk )
CC_SA_LANGS=( pt-BR )
CC_NC_LANGS=( en eo ky ru uk )
NC_LANGS=( ka tt )
LANGS=(
	"${AGPL_LANGS[@]}"
	"${CC_SA_LANGS[@]}"
	"${CC_NC_LANGS[@]}"
	"${LGPL2_LANGS[@]}"
	"${NC_LANGS[@]}"
	sq # LGPL-2.1+
)

LICENSE="BSD GPL-2 GPL-3+ LGPL-2.1+
	$(printf 'l10n_%s? ( AGPL-3 )\n' "${AGPL_LANGS[@]}")
	$(printf 'l10n_%s? ( CC-BY-SA-4.0 )\n' "${CC_SA_LANGS[@]}")
	$(printf 'l10n_%s? ( CC-BY-NC-ND-4.0 )\n' "${CC_NC_LANGS[@]}")
	$(printf 'l10n_%s? ( free-noncomm )\n' "${NC_LANGS[@]}")
"
KEYWORDS="~amd64 ~x86"
IUSE="$(printf 'l10n_%s ' ${LANGS[@]}) ao cli portaudio +pulseaudio +server +speech-dispatcher"
SLOT="0"
REQUIRED_USE="|| ( ao portaudio pulseaudio )"

DEPEND="
	ao? ( media-libs/libao )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	server? (
		dev-libs/glib:2[dbus]
		dev-libs/libsigc++:2
		>=dev-cpp/glibmm-2.66.1:2
	)
	speech-dispatcher? ( app-accessibility/speech-dispatcher )
"
RDEPEND="${DEPEND}
	!dev-libs/hts_engine
"
# TODO: readd dev-libs/rapidxml in ::guru
BDEPEND="
	dev-cpp/cli11
	dev-libs/utfcpp
	verify-sig? ( sec-keys/openpgp-keys-aepaneshnikov )
"
REQUIRED_USE="|| ( ao portaudio pulseaudio )"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/aepaneshnikov.asc"

DOCS=( README.md doc config/dicts )

delete_voices() {
	for voice in "$@"; do
		rm -r "data/voices/${voice}" || die
	done
}

src_prepare() {
	cmake_src_prepare

	sed "s|/lib/speech-dispatcher-modules|/$(get_libdir)/speech-dispatcher-modules|" \
		-i src/sd_module/CMakeLists.txt || die

	# fix dbus service install path
	sed "s|/systemd/system||" \
		-i src/service/CMakeLists.txt || die

	#sed -e "/set(RAPIDXML_INCLUDE_DIR/d" \
	#	-i src/third-party/CMakeLists.txt || die
	sed "/set(UTF8_INCLUDE_DIR/d" -i src/CMakeLists.txt || die

	# fix build failure
	sed 's/ "RHVoice_question_match"//' \
		-i src/third-party/mage/CMakeLists.txt || die

	sed -e "/include(VersionFromGit)/d" \
		-e "/getVersionFromGit/d" \
		-i CMakeLists.txt || die

	use l10n_en || delete_voices alan bdl clb evgeniy-eng lubov slt
	use l10n_eo || delete_voices spomenka
	use l10n_ka || delete_voices natia
	use l10n_ky || delete_voices azamat nazgul
	use l10n_mk || delete_voices kiko
	use l10n_ru || delete_voices aleksandr aleksandr-hq anna arina artemiy \
		elena evgeniy-rus irina mikhail pavel tatiana victoria yuriy
	use l10n_sq || delete-voices hana
	use l10n_tt || delete_voices talgat
	use l10n_uk || delete_voices anatol marianna natalia volodymyr
	use l10n_pt-BR || delete_voices Leticia-F123
}

src_configure() {
	local mycmakeargs=(
		-Dcommon_doc_dir=/usr/share/doc/${PF}
		-DRHVOICE_VERSION=${PV}
		-DRHVOICE_VERSION_MAJOR=$(ver_cut 1)
		-DWITH_CLI11=ON
		# src/CMakeLists.txt
		-DBUILD_CLIENT=OFF	# deprecated
		-DBUILD_UTILS=OFF	# fails to build because of bundled tclap
		-DBUILD_TESTS=$(usex cli)
		-DBUILD_SERVICE=$(usex server)
		-DBUILD_SPEECHDISPATCHER_MODULE=$(usex speech-dispatcher)
		# src/audio/CMakeLists.txt
		-DWITH_LIBAO=$(usex ao)
		-DWITH_PULSE=$(usex pulseaudio)
		-DWITH_PORTAUDIO=$(usex portaudio)
		# src/third-party/CMakeLists.txt
		#-DRAPIDXML_INCLUDE_DIR=/usr/include/rapidxml
		-DUTF8_INCLUDE_DIR=/usr/include/utf8cpp
		# Hardening.cmake: don't mess with flags
		-DHARDENING_COMPILE_FLAGS=
		-DHARDENING_LINK_FLAGS=
	)

	cmake_src_configure
}
