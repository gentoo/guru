# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT="10.0"
NUGETS="
castle.core@4.4.1
commandlineparser@2.9.1
config.net@4.19.0
goaaats.steamworks@2.3.4
hexa.net.imgui.backends.sdl3@1.0.18
hexa.net.imgui@2.2.9
hexa.net.sdl3.image@1.0.0
hexa.net.sdl3@1.2.16
hexagen.runtime@1.1.18
hexagen.runtime@1.1.21
keysharp@1.0.5
microsoft.codeanalysis.analyzers@3.3.3
microsoft.codeanalysis.bannedapianalyzers@3.3.4
microsoft.codeanalysis.bannedapianalyzers@4.14.0
microsoft.codeanalysis.common@4.0.1
microsoft.codeanalysis.csharp@4.0.1
microsoft.codeanalysis.netanalyzers@10.0.101
microsoft.codeanalysis.netanalyzers@9.0.0
microsoft.netcore.platforms@1.1.0
microsoft.win32.registry@6.0.0-preview.5.21301.5
microsoft.win32.systemevents@6.0.0
netstandard.library@1.6.1
netstandard.library@2.0.3
newtonsoft.json@13.0.3
pinvoke.kernel32@0.7.124
pinvoke.windows.core@0.7.124
serilog.enrichers.sensitive@1.7.3
serilog.enrichers.thread@4.0.0
serilog.sinks.async@2.1.0
serilog.sinks.console@6.0.0
serilog.sinks.debug@3.0.0
serilog.sinks.file@6.0.0
serilog.sinks.file@7.0.0
serilog@4.0.0
serilog@4.1.0
serilog@4.2.0
serilog@4.3.0
sharedmemory@2.3.2
system.buffers@4.5.1
system.collections.immutable@5.0.0
system.configuration.configurationmanager@6.0.0
system.drawing.common@6.0.0
system.memory@4.5.4
system.memory@4.6.0
system.numerics.vectors@4.4.0
system.reflection.emit.lightweight@4.7.0
system.reflection.metadata@5.0.0
system.runtime.compilerservices.unsafe@4.5.2
system.runtime.compilerservices.unsafe@4.5.3
system.runtime.compilerservices.unsafe@5.0.0
system.security.accesscontrol@6.0.0-preview.5.21301.5
system.security.cryptography.protecteddata@6.0.0
system.security.permissions@6.0.0
system.security.principal.windows@6.0.0-preview.5.21301.5
system.text.encoding.codepages@4.5.1
system.text.json@9.0.2
system.threading.tasks.extensions@4.5.4
system.windows.extensions@6.0.0
"

inherit dotnet-pkg desktop optfeature xdg

XIVQL_COMMIT="40ed6e93e7eb73e1c18f4d4871e05f32ab5fd2c6"

DESCRIPTION="Custom Launcher for Final Fantasy XIV Online (Crossplatform rewrite)"
HOMEPAGE="https://github.com/goatcorp/XIVLauncher.Core/"
SRC_URI="
	https://github.com/goatcorp/XIVLauncher.Core/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/goatcorp/FFXIVQuickLauncher/archive/${XIVQL_COMMIT}.tar.gz
		-> FFXIVQuickLauncher-${XIVQL_COMMIT}.tar.gz
	${NUGET_URIS}
"

S="${WORKDIR}/XIVLauncher.Core-${PV}/src"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+libsecret"

RDEPEND="
	libsecret? ( app-crypt/libsecret )
	media-libs/libsdl2
	sys-apps/attr
	media-libs/fontconfig
	media-libs/lcms
	dev-libs/libxml2
	x11-libs/libXcursor
	x11-libs/libXrandr
	x11-libs/libXdamage
	x11-libs/libXi
	sys-devel/gettext
	|| ( sys-libs/libunwind llvm-runtimes/libunwind )
	media-libs/freetype:2
	media-libs/glu
	x11-libs/libSM
	dev-libs/glib
"

DOTNET_PKG_PROJECTS=("${S}/XIVLauncher.Core/XIVLauncher.Core.csproj")

src_prepare() {
	rmdir "${WORKDIR}/XIVLauncher.Core-${PV}/lib/FFXIVQuickLauncher" || die
	mv "${WORKDIR}/FFXIVQuickLauncher-${XIVQL_COMMIT}" \
		"${WORKDIR}/XIVLauncher.Core-${PV}/lib/FFXIVQuickLauncher" || die
	sed -i "s/git -C .* describe --long --always --dirty &gt; \$(VerFile)/echo ${PV}/" \
		XIVLauncher.Core/XIVLauncher.Core.csproj

	dotnet-pkg_src_prepare
}

src_install() {
	dotnet-pkg-base_install
	dotnet-pkg-base_dolauncher "/usr/share/${P}/XIVLauncher.Core" "xivlauncher"

	domenu ../misc/linux_distrib/XIVLauncher.desktop
	newicon -s 512 ../misc/linux_distrib/512.png xivlauncher.png
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "Patch downloading with aria2" net-misc/aria2
}
