# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_REQ_USE="xml(+)"
PYTHON_COMPAT=( python3_{13..14} )
USE_RUBY="ruby33 ruby34 ruby40"

inherit check-reqs flag-o-matic gnome2 optfeature python-any-r1 ruby-single toolchain-funcs cmake

# keep in sync with WebKitGTK, they both share the webkit/glib branch

DESCRIPTION="Open source web browser engine"
HOMEPAGE="https://www.wpewebkit.org/"
SRC_URI="https://www.wpewebkit.org/releases/${P}.tar.xz"

LICENSE="LGPL-2+ BSD"
SLOT="2.0"
KEYWORDS="~amd64"

IUSE="avif doc cpu_flags_x86_sse cpu_flags_x86_sse2 custom-cflags examples gamepad +gstreamer +introspection legacy-wpe pdf qt6 jpegxl lcms seccomp spell systemd wayland"
REQUIRED_USE="
	doc? ( introspection )
	examples? ( wayland )
	qt6? ( wayland )
"

# Tests do not run when built from tarballs
# https://bugs.webkit.org/show_bug.cgi?id=215986
RESTRICT="test"

# Dependencies can be found in Source/cmake/OptionsWPE.cmake.
#
# * >=gst-plugins-opus-1.14.4-r1 for opusparse (required by MSE)
#
# * dev-util/sysprof-capture is disabled because it was a new dependency in 2.46
#   and we don't need any more new problems.
#
DEPEND="
	dev-db/sqlite:3
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/hyphen
	dev-libs/icu:=
	dev-libs/libgcrypt:0=
	dev-libs/libtasn1:=
	dev-libs/libxml2:2=
	dev-libs/libxslt
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/harfbuzz:=[icu(+)]
	media-libs/libjpeg-turbo:0=
	media-libs/libepoxy[egl(+)]
	media-libs/libpng:0=
	media-libs/libwebp:=
	media-libs/mesa[opengl,wayland?]
	media-libs/woff2
	net-libs/libsoup:3.0[introspection?]
	virtual/udev
	virtual/zlib:=
	x11-libs/libdrm
	x11-libs/libxkbcommon
	dev-libs/libinput:=
	avif? ( media-libs/libavif:= )
	gamepad? ( dev-libs/libmanette )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0[egl,opengl,wayland?]
		media-plugins/gst-plugins-opus:1.0
	)
	introspection? ( >=dev-libs/gobject-introspection-1.82.0-r2:= )
	jpegxl? ( media-libs/libjxl:= )
	legacy-wpe? ( gui-libs/libwpe:1.0 )
	lcms? ( media-libs/lcms:2 )
	qt6? (
		 dev-qt/qtbase:6
		 dev-qt/qtdeclarative:6
	)
	seccomp? ( sys-libs/libseccomp )
	spell? ( app-text/enchant:2 )
	systemd? ( sys-apps/systemd:= )
	wayland? (
		dev-libs/wayland
		dev-libs/wayland-protocols
		legacy-wpe? ( gui-libs/wpebackend-fdo:1.0 )
	)
"

RDEPEND="${DEPEND}
	gstreamer? (
		media-plugins/gst-plugins-webrtc:1.0
	)
	seccomp? (
		sys-apps/bubblewrap
		sys-apps/xdg-dbus-proxy
	)
"

# Need real bison, not yacc
BDEPEND="
	${PYTHON_DEPS}
	${RUBY_DEPS}
	dev-lang/perl
	>=dev-util/gdbus-codegen-2.80.5-r1
	dev-util/glib-utils
	dev-util/gperf
	dev-util/unifdef
	sys-devel/bison
	sys-devel/gettext
	virtual/pkgconfig
	doc? ( dev-util/gi-docgen )
	wayland? ( dev-util/wayland-scanner )
"

CHECKREQS_DISK_BUILD="18G" # and even this might not be enough, bug #417307

PATCHES=(
	# https://bugs.gentoo.org/938162, see also mycmakeargs
	"${FILESDIR}"/2.48.3-fix-ftbfs-riscv64.patch
	"${FILESDIR}"/2.50.4-disable-native-simd-on-riscv.patch
	"${FILESDIR}"/2.52.1-documentloader-eventloop-h.patch
	"${FILESDIR}"/2.52.6-no-sse2.patch
	"${FILESDIR}"/2.54.2-fix-32bit-builds.patch
	"${FILESDIR}"/2.54.2-fix-ftbfs-32bit.patch
)

pkg_pretend() {
	if [[ ${MERGE_TYPE} != "binary" ]] ; then
		if is-flagq "-g*" && ! is-flagq "-g*0" ; then
			einfo "Checking for sufficient disk space to build ${PN} with debugging CFLAGS"
			check-reqs_pkg_pretend
		fi
	fi
}

pkg_setup() {
	if [[ ${MERGE_TYPE} != "binary" ]] && is-flagq "-g*" && ! is-flagq "-g*0" ; then
		check-reqs_pkg_setup
	fi

	python-any-r1_pkg_setup
}

src_prepare() {
	# use cmake_prepare as it doesn't eapply ${PATCHES[@]}
	cmake_prepare
	gnome2_src_prepare

	# We don't want -Werror for gobject-introspection (bug #947761)
	sed -i -e "s:--warn-error::" Source/cmake/FindGI.cmake || die
}

src_configure() {
	# Respect CC, otherwise fails on prefix #395875
	tc-export CC

	if use custom-cflags; then
		# Bug 641398
		append-cppflags -DRELEASE_WITHOUT_OPTIMIZATIONS
	else
		# ODR violations, bug 915230.
		# https://bugs.webkit.org/show_bug.cgi?id=233007
		filter-lto

		# Bug 965483
		if is-flagq '-g?(gdb)?([2-9])'; then
			replace-flags '-g?(gdb)?([2-9])' -g1
			ewarn "-g2+/-ggdb* *FLAGS replaced with -g1"
		fi
	fi

	# It does not compile on alpha without this in LDFLAGS
	# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=648761
	use alpha && append-ldflags "-Wl,--no-relax"

	# Sigbuses on SPARC with mcpu and co., bug #???
	use sparc && filter-flags "-mvis"

	# https://bugs.webkit.org/show_bug.cgi?id=42070 , #301634
	use ppc64 && append-flags "-mminimal-toc"

	# https://bugs.webkit.org/show_bug.cgi?id=245697
	use arm64 && append-flags "-mbranch-protection=pac-ret"

	# Try to use less memory, bug #469942 (see Fedora .spec for reference)
	append-ldflags $(test-flags-CCLD "-Wl,--no-keep-memory")

	# Ruby situation is a bit complicated. See bug 513888
	local rubyimpl
	local ruby_interpreter=""
	local RUBY
	for rubyimpl in ${USE_RUBY}; do
		if has_version -b "virtual/rubygems[ruby_targets_${rubyimpl}(-)]"; then
			RUBY="$(type -P ${rubyimpl})"
			ruby_interpreter="-DRUBY_EXECUTABLE=${RUBY}"
		fi
	done
	# This will rarely occur. Only a couple of corner cases could lead us to
	# that failure. See bug 513888
	[[ -z ${ruby_interpreter} ]] && die "No suitable ruby interpreter found"
	# JavaScriptCore/Scripts/postprocess-asm invokes another Ruby script directly
	# so it doesn't respect RUBY_EXECUTABLE, bug #771744.
	sed -i -e "s:#!/usr/bin/env ruby:#!${RUBY}:" $(grep -rl "/usr/bin/env ruby" Source/JavaScriptCore || die) || die

	# TODO: Check Web Audio support
	# should somehow let user select between them?
	local mycmakeargs=(
		-DPython_EXECUTABLE="${PYTHON}"
		${ruby_interpreter}
		# If bubblewrap[suid] then portage makes it go-r and cmake find_program fails with that
		-DBWRAP_EXECUTABLE:FILEPATH="${EPREFIX}"/usr/bin/bwrap
		-DDBUS_PROXY_EXECUTABLE:FILEPATH="${EPREFIX}"/usr/bin/xdg-dbus-proxy
		-DPORT=WPE # libWPEWebKit-2.0.so
		# Source/cmake/WebKitFeatures.cmake
		-DENABLE_API_TESTS=OFF
		-DENABLE_BUBBLEWRAP_SANDBOX=$(usex seccomp)
		-DENABLE_DRAG_SUPPORT=ON
		-DENABLE_GAMEPAD=$(usex gamepad)
		-DENABLE_GEOLOCATION=ON # Runtime optional (talks over dbus service)
		-DENABLE_MINIBROWSER=$(usex examples)
		-DENABLE_PDFJS=$(usex pdf)
		-DENABLE_SPEECH_SYNTHESIS=OFF
		-DENABLE_SPELLCHECK=$(usex spell)
		-DENABLE_TOUCH_EVENTS=ON
		-DENABLE_VIDEO=$(usex gstreamer)
		-DENABLE_WEB_AUDIO=$(usex gstreamer)
		-DENABLE_WEB_CODECS=$(usex gstreamer) # https://bugs.webkit.org/show_bug.cgi?id=269147
		-DENABLE_WEBDRIVER=ON # build failure otherwise in 2.54.0
		-DENABLE_WEBGL=ON
		-DUSE_AVIF=$(usex avif)
		-DUSE_ATK=OFF
		# Source/cmake/GStreamerDependencies.cmake
		-DENABLE_MEDIA_TELEMETRY=OFF
		-DUSE_GSTREAMER=$(usex gstreamer)
		-DUSE_GSTREAMER_WEBRTC=OFF # https://bugs.webkit.org/show_bug.cgi?id=235885
		# Source/cmake/OptionsGTK.cmake
		-DENABLE_DOCUMENTATION=$(usex doc)
		-DENABLE_INTROSPECTION=$(usex introspection)
		-DENABLE_JOURNALD_LOG=$(usex systemd)
		# WPE
		-DENABLE_WPE_1_1_API=OFF
		-DENABLE_WPE_LEGACY_API=$(usex legacy-wpe)
		-DENABLE_WPE_PLATFORM=ON
		-DENABLE_WPE_PLATFORM_DRM=ON
		-DENABLE_WPE_PLATFORM_HEADLESS=ON
		-DENABLE_WPE_PLATFORM_WAYLAND=$(usex wayland)
		-DENABLE_WPE_QT_API=$(usex qt6)
		-DUSE_GBM=ON
		-DUSE_JPEGXL=$(usex jpegxl)
		-DUSE_LCMS=$(usex lcms)
		-DUSE_LIBBACKTRACE=OFF
		-DUSE_LIBDRM=ON
		-DUSE_LIBHYPHEN=ON
		-DUSE_SYSPROF_CAPTURE=OFF
		-DUSE_WOFF2=ON
	)

	use qt6 && mycmakeargs+=( -DUSE_QT6=$(usex qt6) )

	# Do our best to support x86 machines lacking SSE,
	# https://bugs.gentoo.org/730044
	if use x86; then
		if use cpu_flags_x86_sse2; then
			# These are normally added by the build system, but our
			# patch changes the way an x86 CPU is detected, bypassing
			# that addition.
			append-flags "-msse2 -mfpmath=sse"
		elif use cpu_flags_x86_sse; then
			# If you have SSE1 but not SSE2, these are needed to
			# avoid static_assert failures.
			append-flags "-msse -mfpmath=sse"
		else
			# Neither? This is reportedly crashy, but better than
			# nothing if you really don't have the hardware.
			mycmakeargs+=( -DENABLE_WEBGL=OFF )
			append-cppflags -DSKCMS_HAS_MUSTTAIL=0
		fi
	fi

	if use riscv || use ppc64; then
		# https://bugs.gentoo.org/970556
		# https://bugs.webkit.org/show_bug.cgi?id=305745
		append-cppflags -DSKCMS_HAS_MUSTTAIL=0
	fi

	if use riscv; then
		# Workaround for bug 938162 (upstream bug 271371).
		mycmakeargs+=(
			-DENABLE_WEBASSEMBLY=OFF
		)
	fi

	# https://bugs.gentoo.org/761238
	append-cppflags -DNDEBUG

	WK_USE_CCACHE=NO cmake_src_configure
}

src_install() {
	cmake_src_install

	if use doc; then
		mkdir -p "${ED}"/usr/share/gtk-doc || die
		mv "${ED}"/usr/share/doc/wpe-* "${ED}"/usr/share/gtk-doc/ || die
	fi
}

pkg_postinst() {
	optfeature "geolocation service (used at runtime if available)" "app-misc/geoclue"
	optfeature "Common Multimedia codecs" "media-plugins/gst-plugins-meta"
	optfeature "VAAPI encoding support" "media-libs/gst-plugins-bad[vaapi]"
	optfeature "MPEG-DASH support" "media-plugins/gst-plugins-dash"
	optfeature "HTTP live streaming (HLS) support" "media-plugins/gst-plugins-hls"
}
