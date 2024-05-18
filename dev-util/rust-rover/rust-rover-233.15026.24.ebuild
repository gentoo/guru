# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit desktop wrapper

DESCRIPTION="A feature-rich Rust IDE with timely support by JetBrarins"

HOMEPAGE="https://www.jetbrains.com/rust/"

SRC_URI="https://download.jetbrains.com/rustrover/RustRover-${PV}.tar.gz"

# to keep it tidy.
S="${WORKDIR}/RustRover-${PV}"

LICENSE="idea-eap-EULA"

SLOT="0"

KEYWORDS="-* ~amd64"

IUSE="gnome X"

RESTRICT="bindist mirror"

QA_PREBUILT="opt/RustRover"

BDEPEND="dev-util/patchelf"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	dev-debug/gdb
	dev-debug/lldb
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
	sys-libs/zlib
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
	virtual/rust
"

src_prepare() {
	default

	local remove_me=(
		Install-Linux-tar.txt
		bin/gdb
		bin/lldb
		plugins/cwm-plugin/quiche-native/darwin-aarch64
		plugins/cwm-plugin/quiche-native/darwin-x86-64
		plugins/cwm-plugin/quiche-native/linux-aarch64
		plugins/cwm-plugin/quiche-native/win32-x86-64
		plugins/remote-dev-server/selfcontained
		plugins/intellij-rust/bin/linux/arm64
		plugins/gateway-plugin/lib/remote-dev-workers/remote-dev-worker-linux-arm64
		plugins/platform-ijent-impl/ijent-aarch64-unknown-linux-musl-release
		lib/async-profiler/aarch64
	)

	rm -rv "${remove_me[@]}" || die

	for file in "jbr/lib/{libjcef.so,jcef_helper}"
	do
		if [[ -f "${file}" ]]; then
			patchelf --set-rpath '$ORIGIN' "${file}" || die
		fi
	done
}

src_install() {
	local dir="/opt/RustRover"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}"/bin/{format.sh,fsnotifier,inspect.sh,jetbrains_client.sh,ltedit.sh,remote-dev-server.sh,repair,restarter,rustrover.sh}

	if [[ -d jbr ]]; then
		fperms 755 "${dir}"/jbr/bin/{java,javac,javadoc,jcmd,jdb,jfr,jhsdb,jinfo,jmap,jps,jrunscript,jstack,jstat,keytool,rmiregistry,serialver}
		fperms 755 "${dir}"/jbr/lib/{chrome-sandbox,jcef_helper,jexec,jspawnhelper}
	fi

	make_wrapper "rustrover" "${dir}/bin/rustrover.sh"
	newicon "bin/rustrover.svg" "rustrover.svg"
	make_desktop_entry "rustrover" "RustRover" "rustrover" "Development;IDE;"

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	insinto /usr/lib/sysctl.d
	newins - 30-"${PN}"-inotify-watches.conf <<<"fs.inotify.max_user_watches = 524288"
}
