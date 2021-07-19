# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake multilib

DESCRIPTION="TTS engine with extended languages support (including Russian)"
HOMEPAGE="https://rhvoice.su https://github.com/RHVoice/RHVoice"
SRC_URI="
	https://github.com/${PN}/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	l10n_en? ( https://github.com/${PN}/evgeniy-eng/archive/refs/tags/4.0.tar.gz -> rhvoice-evgeniy-eng-4.0.tar.gz )
	l10n_ru? (
		https://github.com/${PN}/aleksandr-hq-rus/archive/refs/tags/4.0.tar.gz -> rhvoice-aleksandr-hq-4.0.tar.gz
		https://github.com/${PN}/evgeniy-rus/archive/refs/tags/4.0.tar.gz -> rhvoice-evgeniy-rus-4.0.tar.gz
		https://github.com/${PN}/victoria-rus/archive/refs/tags/4.0.tar.gz -> rhvoice-victoria-4.0.tar.gz
		https://github.com/${PN}/yuriy-rus/archive/refs/tags/4.0.tar.gz -> rhvoice-yuriy.tar.gz
	)
	l10n_uk? ( https://github.com/${PN}/volodymyr-ukr/archive/refs/tags/4.0.tar.gz -> rhvoice-volodymyr-4.0.tar.gz )
"
S="${WORKDIR}/RHVoice-${PV}"
CMAKE_REMOVE_MODULES_LIST="Hardening VersionFromGit"

LICENSE="l10n_pt-BR? ( CC-BY-SA-4.0 ) l10n_mk? ( AGPL-3 ) BSD GPL-2 GPL-3+ LGPL-2.1+"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="ao cli client portaudio +pulseaudio +server +speech-dispatcher utils"
REQUIRED_USE="|| ( ao portaudio pulseaudio )"

CC_NC_LANGS=( en eo ky ru uk )
NC_LANGS=( ka tt )
LANGS=" ${CC_NC_LANGS[@]} ${NC_LANGS[@]} mk pt-BR"
IUSE+="${LANGS// / l10n_}"

for lang in "${CC_NC_LANGS[@]}" ; do
	LICENSE+=" l10n_${lang}?"
	LICENSE+=" ( CC-BY-NC-ND-4.0 )"
done

for lang in "${NC_LANGS[@]}" ; do
	LICENSE+=" l10n_${lang}?"
	LICENSE+=" ( free-noncomm )"
done

RDEPEND="
	!dev-libs/hts_engine
	ao? ( media-libs/libao )
	client? ( sys-apps/dbus )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	server? (
		dev-libs/glib[dbus]
		>=dev-cpp/glibmm-2.66.1:2
	)
	speech-dispatcher? ( app-accessibility/speech-dispatcher )
"
BDEPEND="${DEPEND}
	dev-cpp/cli11
	dev-libs/rapidxml
	dev-libs/utfcpp
"
REQUIRED_USE="|| ( ao portaudio pulseaudio )"

DOCS=( README.md doc config/dicts )

delete_voices() {
	for voice in "$@"; do
		rm -r "data/voices/${voice}" || die
	done
}

src_unpack() {
	default

	# git submodules, which are not present in the snapshot
	rmdir "${S}"/data/voices/{aleksandr-hq,evgeniy-rus,evgeniy-eng,victoria,volodymyr,yuriy} || die

	if use l10n_ru ; then
		mv "${WORKDIR}"/aleksandr-hq-rus-4.0 "${S}"/data/voices/aleksandr-hq || die
		mv "${WORKDIR}"/evgeniy-rus-4.0 "${S}"/data/voices/evgeniy-rus || die
		mv "${WORKDIR}"/victoria-rus-4.0 "${S}"/data/voices/victoria || die
		mv "${WORKDIR}"/yuriy-rus-4.0 "${S}"/data/voices/yuriy || die
	fi

	if use l10n_en ; then
		mv "${WORKDIR}"/evgeniy-eng-4.0 "${S}"/data/voices/evgeniy-eng || die
	fi

	if use l10n_uk ; then
		mv "${WORKDIR}"/volodymyr-ukr-4.0 "${S}"/data/voices/volodymyr || die
	fi
}

src_prepare() {
	cmake_src_prepare

	sed "s|/lib/speech-dispatcher-modules|/$(get_libdir)/speech-dispatcher-modules|" \
		-i src/sd_module/CMakeLists.txt || die

	sed 's|/systemd/system||' \
		-i src/service/CMakeLists.txt || die

	sed -e "/set(RAPIDXML_INCLUDE_DIR/d" \
		-i src/third-party/CMakeLists.txt || die
	sed "/set(UTF8_INCLUDE_DIR/d" -i src/CMakeLists.txt || die

	sed 's/ "RHVoice_question_match"//' \
		-i src/third-party/mage/CMakeLists.txt || die

	sed -e "/include(VersionFromGit)/d" \
		-e "/include(Hardening)/d" \
		-e "/find_package(Sanitizers)/d" \
		-e "/getVersionFromGit/d" \
		-e "/harden/d" \
		-i CMakeLists.txt || die
	sed -e "/add_sanitizers/d" \
		-e "/harden/d" \
		-i src/*/CMakeLists.txt \
		-i src/third-party/*/CMakeLists.txt || die

	use l10n_en || delete_voices alan bdl clb slt
	use l10n_eo || delete_voices spomenka
	use l10n_ka || delete_voices natia
	use l10n_ky || delete_voices azamat nazgul
	use l10n_mk || delete_voices kiko
	use l10n_ru || delete_voices aleksandr anna arina artemiy elena irina pavel
	use l10n_tt || delete_voices talgat
	use l10n_uk || delete_voices anatol natalia
	use l10n_pt-BR || delete_voices Leticia-F123
}

src_configure() {
	local mycmakeargs=(
		-Dcommon_doc_dir=/usr/share/doc/${PF}
		-DRHVOICE_VERSION=${PV}
		-DRHVOICE_VERSION_MAJOR=$(ver_cut 1)
		-DWITH_CLI11=ON
		# src/CMakeLists.txt
		-DBUILD_CLIENT=$(usex client)
		-DBUILD_UTILS=$(usex utils)
		-DBUILD_TESTS=$(usex cli)
		-DBUILD_SERVICE=$(usex server)
		-DBUILD_SPEECHDISPATCHER_MODULE=$(usex speech-dispatcher)
		# src/audio/CMakeLists.txt
		-DWITH_LIBAO=$(usex ao)
		-DWITH_PULSE=$(usex pulseaudio)
		-DWITH_PORTAUDIO=$(usex portaudio)
		# src/third-party/CMakeLists.txt
		-DRAPIDXML_INCLUDE_DIR=/usr/include/rapidxml
		-DUTF8_INCLUDE_DIR=/usr/include/utf8cpp
	)

	cmake_src_configure
}
