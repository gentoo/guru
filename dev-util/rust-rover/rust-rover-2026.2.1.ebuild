# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg-utils

DESCRIPTION="A feature-rich Rust IDE with timely support by JetBrains"
HOMEPAGE="https://www.jetbrains.com/rust/"
SRC_URI="https://download.jetbrains.com/rustrover/RustRover-${PV}.tar.gz"

S="${WORKDIR}/RustRover-${PV}"

LICENSE="|| ( JetBrains-business JetBrains-classroom JetBrains-educational JetBrains-individual )
	Apache-2.0
	BSD
	CC0-1.0
	CDDL
	CDDL-1.1
	EPL-1.0
	GPL-2
	GPL-2-with-classpath-exception
	ISC
	LGPL-2.1
	LGPL-3
	MIT
	MPL-1.1
	OFL-1.1
	ZLIB
"

SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+bundled-jdk nvidia"

RESTRICT="bindist mirror"

QA_PREBUILT="opt/RustRover/*"

BDEPEND="
	dev-util/patchelf
"

RDEPEND="
	!bundled-jdk? ( >=virtual/jre-1.8 )
	>=app-accessibility/at-spi2-core-2.46.0:2
	dev-debug/gdb
	dev-libs/openssl-compat:1.1.1
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	dev-libs/wayland
	media-libs/alsa-lib
	media-libs/freetype:2
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	virtual/zlib:=
	virtual/libcrypt:=
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXxf86vm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
"

src_prepare() {
	default

	local remove_me=(
		Install-Linux-tar.txt
		bin/gdb
		plugins/remote-dev-server/selfcontained
		plugins/gateway-plugin/lib/remote-dev-workers/remote-dev-worker-linux-arm64
		plugins/nativeDebug-plugin/bin/lldb/linux/aarch64
		plugins/platform-ijent-bundledBinaries/ijent-aarch64-unknown-linux-musl-release
		lib/async-profiler/aarch64
	)

	rm -rv "${remove_me[@]}" || die

	sed -i \
		-e "\$a\\\\" \
		-e "\$a#-----------------------------------------------------------------------" \
		-e "\$a# Disable automatic updates as these are handled through Gentoo's" \
		-e "\$a# package manager. See bug #704494" \
		-e "\$a#-----------------------------------------------------------------------" \
		-e "\$aide.no.platform.update=Gentoo" \
		bin/idea.properties || die

	local file
	for file in "plugins/jcef-plugin/jcef"/{libjcef.so,jcef_helper}; do
		if [[ -f ${file} ]]; then
			patchelf --set-rpath '$ORIGIN' "${file}" || die
		fi
	done

	if use nvidia; then
		grep -q '^-Dide.browser.jcef.out-of-process.enabled=' \
			bin/rustrover64.vmoptions \
			|| echo "-Dide.browser.jcef.out-of-process.enabled=false" \
			>> bin/rustrover64.vmoptions \
			|| die
	fi
}

src_install() {
	local dir="/opt/RustRover"

	dodir "${dir}"
	cp -a "${S}/." "${ED}${dir}/" || die

	if ! use bundled-jdk; then
		rm -r "${ED}${dir}/jbr" || die
	fi

	make_wrapper "rustrover" "${dir}/bin/rustrover"

	newicon "bin/rustrover.svg" "rustrover.svg"
	make_desktop_entry \
		"rustrover" \
		"RustRover" \
		"rustrover" \
		"Development;IDE;"

	# Recommended for JetBrains IDE file watching.
	dodir /etc/sysctl.d
	echo "fs.inotify.max_user_watches = 524288" \
		> "${ED}/etc/sysctl.d/30-idea-inotify-watches.conf" \
		|| die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
