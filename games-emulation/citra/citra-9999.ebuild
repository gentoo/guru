# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg

DESCRIPTION="A Nintendo 3DS Emulator"
HOMEPAGE="https://citra-emu.org"
EGIT_REPO_URI="https://github.com/citra-emu/citra"
EGIT_SUBMODULES=(
	'catch2' 'discord-rpc' 'dynarmic' 'libyuv'
	'lodepng' 'nihstro' 'soundtouch' 'xbyak'
)

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="cubeb +hle-sound nls +qt5 sdl +system-libfmt +telemetry video"

RDEPEND="
	cubeb? ( media-libs/cubeb )
	!hle-sound? ( media-libs/fdk-aac )
	hle-sound? ( media-video/ffmpeg[fdk] )
	qt5? ( nls? ( dev-qt/linguist )
			dev-qt/qtgui:5
			dev-qt/qtmultimedia:5
			dev-qt/qtnetwork:5
			dev-qt/qtopengl:5
			dev-qt/qtwidgets:5 )
	sdl? (
		media-libs/libsdl2
		>=dev-libs/inih-52
	)
	system-libfmt? ( >=dev-libs/libfmt-9:= )
	video? ( media-video/ffmpeg:= )
	>=dev-libs/openssl-1.1:=
	app-arch/zstd
	dev-libs/boost:=
	dev-libs/crypto++:=
	dev-libs/teakra
	net-libs/enet:1.3=
	virtual/libusb:1
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-cpp/cpp-httplib
	dev-cpp/cpp-jwt
	dev-cpp/robin-map"
REQUIRED_USE="|| ( qt5 sdl )"

src_unpack() {
	if ! use system-libfmt; then
		EGIT_SUBMODULES+=( 'fmt' )
	fi
	git-r3_src_unpack

	cp -a "${S}"/externals/xbyak "${S}"/externals/dynarmic/externals/ || die

	# Do not fetch via sources because this file always changes
	curl https://api.citra-emu.org/gamedb/ > "${S}"/compatibility_list.json
}

src_prepare() {
	# Dynarmic: ensure those are unbundled
	for ext in fmt robin-map; do
		rm -rf externals/dynarmic/externals/${ext} || die
	done

	# Do not care about submodules wanted one are already fetched
	sed -i -e '/check_submodules_present()/d' CMakeLists.txt || die

	# Unbundle inih
	sed -i -e '/inih/d' externals/CMakeLists.txt || die
	sed -i -e '1ifind_package(PkgConfig REQUIRED)\npkg_check_modules(INIH REQUIRED INIReader)' \
		-e '/target_link_libraries/s/inih/${INIH_LIBRARIES}/' src/citra/CMakeLists.txt || die
	sed -i -e 's:inih/cpp/::' src/citra/config.cpp || die

	# Fix boost unbundling
	sed -i -e '/(-DBOOST_ERROR_CODE_HEADER_ONLY/,/)/d' CMakeLists.txt || die
	sed -i -e '/[Bb][Oo][Oo][Ss][Tt]/d' externals/CMakeLists.txt || die

	# Unbundle libressl (TODO rework scopes, find_package(OpenSSL is called 5 times)
	sed -i -e '$afind_package(OpenSSL 1.1)\nset(OPENSSL_LIBRARIES OpenSSL::SSL OpenSSL::Crypto PARENT_SCOPE)' \
		CMakeLists.txt || die
	sed -i -e 's/# LibreSSL/find_package(OpenSSL 1.1)\nif (NOT OPENSSL_FOUND)\n/' \
		-e 's/-DHAVE_INET_NTOP)$/&\nendif()\n/' externals/CMakeLists.txt || die
	sed -i -e '/get_directory_property(OPENSSL_LIBS/,/)/d' \
		-e 's/OPENSSL_LIBS/OPENSSL_LIBRARIES/' \
		src/web_service/CMakeLists.txt \
		src/core/CMakeLists.txt || die
	sed -i -e 's/{PLATFORM_LIBRARIES}/& OpenSSL::SSL OpenSSL::Crypto/' \
		src/{citra,citra_qt,dedicated_room,tests}/CMakeLists.txt || die
	sed -i -e '1ifind_package(OpenSSL 1.1)' src/{citra,citra_qt,dedicated_room,tests}/CMakeLists.txt || die

	if use system-libfmt; then # Unbundle libfmt
		sed -i -e '/fmt/d' externals/CMakeLists.txt || die
		sed -i -e '/find_package(Threads/afind_package(fmt)' CMakeLists.txt || die
	fi

	# Unbundle teakra
	sed -i -e '/teakra/d' externals/CMakeLists.txt || die

	# Unbundle zstd
	sed -i -e 's:libzstd_static:${ZSTD_LIBRARIES}:' \
		-e '1ifind_package(PkgConfig REQUIRED)\npkg_check_modules(ZSTD REQUIRED libzstd)' \
		src/common/CMakeLists.txt || die
	sed -i -e '/zstd/d' externals/CMakeLists.txt || die

	# Unbundle enet
	sed -i -e 's:enet:${ENET_LIBRARIES}:' \
		-e '1ifind_package(PkgConfig REQUIRED)\npkg_check_modules(ENET REQUIRED libenet)' \
		src/network/CMakeLists.txt || die
	sed -i -e '/#include.*enet/{s/"/</;s/"/>/}' src/network/*cpp || die
	sed -i -e '/enet/d' externals/CMakeLists.txt || die

	# Unbundle crypto++
	sed -i -e 's:cryptopp:${CRYPTOPP_LIBRARIES}:' \
		-e '1ifind_package(PkgConfig REQUIRED)\npkg_check_modules(CRYPTOPP REQUIRED libcryptopp)' \
		src/dedicated_room/CMakeLists.txt \
		src/core/CMakeLists.txt || die
	sed -i -e '/cryptopp-cmake/d' externals/CMakeLists.txt || die

	# Unbundle cubeb
	sed -i -e '/CUBEB/,/endif()/d' externals/CMakeLists.txt || die
	if use cubeb; then
		sed -i -e '$afind_package(cubeb REQUIRED)\n' CMakeLists.txt || die
	fi

	# Unbundle cpp-httplib
	sed -i -e '/# httplib/,/target_link_libraries(httplib/d' externals/CMakeLists.txt || die

	# Unbundle cpp-jwt
	sed -i -e '/# cpp-jwt/,/CPP_JWT_USE_VENDORED_NLOHMANN_JSON/d' externals/CMakeLists.txt || die
	sed -i -e 's/ cpp-jwt//' src/web_service/CMakeLists.txt || die

	# Unbundle xbyak
	sed -i -e '/^install(/,/^)$/d' externals/xbyak/CMakeLists.txt || die

	# Do not install dynarmic
	sed -i -e '/^# Install/,$d' externals/dynarmic/CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_FFMPEG_AUDIO_DECODER=$(usex hle-sound)
		-DENABLE_FFMPEG_VIDEO_DUMPER=$(usex video)
		-DENABLE_QT=$(usex qt5)
		-DENABLE_QT_TRANSLATION=$(use qt5 && usex nls || echo OFF)
		-DENABLE_SDL2=$(usex sdl)
		-DENABLE_WEB_SERVICE=$(usex telemetry)
		-DGENERATE_QT_TRANSLATION=$(use qt5 && usex nls || echo OFF)
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_SDL2=ON
	)
	cmake_src_configure

	# This would be better in src_unpack but it would be unlinked
	mv "${S}"/compatibility_list.json "${BUILD_DIR}"/dist/compatibility_list/ || die
}

src_install() {
	cmake_src_install
	rm -rf "${D}"/usr/$(get_libdir)/cmake
}
