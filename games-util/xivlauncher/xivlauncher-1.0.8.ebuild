EAPI=8

DOTNET_PKG_COMPAT="6.0"
NUGETS="
castle.core@4.4.1
cheaploc@1.1.6
commandlineparser@2.9.1
config.net@4.19.0
downloader@2.2.8
goaaats.steamworks@2.3.4
imgui.net@1.87.2
keysharp@1.0.5
microsoft.bcl.asyncinterfaces@6.0.0
microsoft.codeanalysis.analyzers@3.3.3
microsoft.codeanalysis.bannedapianalyzers@3.3.3
microsoft.codeanalysis.common@4.0.1
microsoft.codeanalysis.csharp@4.0.1
microsoft.codeanalysis.netanalyzers@6.0.0
microsoft.codeanalysis.netanalyzers@7.0.0
microsoft.csharp@4.0.1
microsoft.dotnet.platformabstractions@2.0.3
microsoft.extensions.dependencymodel@2.0.3
microsoft.netcore.platforms@1.0.1
microsoft.netcore.platforms@1.1.0
microsoft.netcore.targets@1.0.1
microsoft.netcore.targets@1.1.0
microsoft.win32.primitives@4.3.0
microsoft.win32.registry@6.0.0-preview.5.21301.5
microsoft.win32.systemevents@6.0.0
mono.cecil@0.9.6.1
nativelibraryloader@1.0.13
netstandard.library@1.6.1
netstandard.library@2.0.3
newtonsoft.json@12.0.2
newtonsoft.json@9.0.1
pinvoke.kernel32@0.7.124
pinvoke.windows.core@0.7.124
polysharp@1.10.0
runtime.any.system.collections@4.3.0
runtime.any.system.diagnostics.tools@4.3.0
runtime.any.system.diagnostics.tracing@4.3.0
runtime.any.system.globalization.calendars@4.3.0
runtime.any.system.globalization@4.3.0
runtime.any.system.io@4.3.0
runtime.any.system.reflection.extensions@4.3.0
runtime.any.system.reflection.primitives@4.3.0
runtime.any.system.reflection@4.3.0
runtime.any.system.resources.resourcemanager@4.3.0
runtime.any.system.runtime.handles@4.3.0
runtime.any.system.runtime.interopservices@4.3.0
runtime.any.system.runtime@4.3.0
runtime.any.system.text.encoding.extensions@4.3.0
runtime.any.system.text.encoding@4.3.0
runtime.any.system.threading.tasks@4.3.0
runtime.any.system.threading.timer@4.3.0
runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.native.system.io.compression@4.3.0
runtime.native.system.net.http@4.3.0
runtime.native.system.security.cryptography.apple@4.3.0
runtime.native.system.security.cryptography.openssl@4.3.0
runtime.native.system@4.0.0
runtime.native.system@4.3.0
runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple@4.3.0
runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.unix.microsoft.win32.primitives@4.3.0
runtime.unix.system.console@4.3.0
runtime.unix.system.diagnostics.debug@4.3.0
runtime.unix.system.io.filesystem@4.3.0
runtime.unix.system.net.primitives@4.3.0
runtime.unix.system.net.sockets@4.3.0
runtime.unix.system.private.uri@4.3.0
runtime.unix.system.runtime.extensions@4.3.0
serilog.enrichers.sensitive@1.7.2
serilog.enrichers.thread@3.1.0
serilog.sinks.async@1.5.0
serilog.sinks.console@3.1.1
serilog.sinks.console@4.0.1
serilog.sinks.debug@1.0.1
serilog.sinks.file@5.0.0
serilog@2.12.0
sharedmemory@2.3.2
sharpgen.runtime.com@2.0.0-beta.13
sharpgen.runtime@2.0.0-beta.13
sixlabors.imagesharp@1.0.4
system.appcontext@4.1.0
system.appcontext@4.3.0
system.buffers@4.3.0
system.buffers@4.4.0
system.buffers@4.5.1
system.collections.concurrent@4.3.0
system.collections.immutable@5.0.0
system.collections.nongeneric@4.3.0
system.collections.specialized@4.3.0
system.collections@4.0.11
system.collections@4.3.0
system.componentmodel.primitives@4.3.0
system.componentmodel.typeconverter@4.3.0
system.componentmodel@4.3.0
system.configuration.configurationmanager@6.0.0
system.console@4.3.0
system.diagnostics.debug@4.0.11
system.diagnostics.debug@4.3.0
system.diagnostics.diagnosticsource@4.3.0
system.diagnostics.tools@4.0.1
system.diagnostics.tools@4.3.0
system.diagnostics.tracesource@4.3.0
system.diagnostics.tracing@4.3.0
system.drawing.common@6.0.0
system.dynamic.runtime@4.0.11
system.dynamic.runtime@4.3.0
system.globalization.calendars@4.3.0
system.globalization.extensions@4.3.0
system.globalization@4.0.11
system.globalization@4.3.0
system.io.compression.zipfile@4.3.0
system.io.compression@4.3.0
system.io.filesystem.primitives@4.0.1
system.io.filesystem.primitives@4.3.0
system.io.filesystem@4.0.1
system.io.filesystem@4.3.0
system.io@4.1.0
system.io@4.3.0
system.linq.expressions@4.1.0
system.linq.expressions@4.3.0
system.linq@4.1.0
system.linq@4.3.0
system.memory@4.5.4
system.net.http@4.3.0
system.net.nameresolution@4.3.0
system.net.primitives@4.3.0
system.net.sockets@4.3.0
system.numerics.vectors@4.4.0
system.numerics.vectors@4.5.0
system.objectmodel@4.0.12
system.objectmodel@4.3.0
system.private.uri@4.3.0
system.reflection.emit.ilgeneration@4.0.1
system.reflection.emit.ilgeneration@4.3.0
system.reflection.emit.ilgeneration@4.7.0
system.reflection.emit.lightweight@4.0.1
system.reflection.emit.lightweight@4.3.0
system.reflection.emit.lightweight@4.7.0
system.reflection.emit@4.0.1
system.reflection.emit@4.3.0
system.reflection.extensions@4.0.1
system.reflection.extensions@4.3.0
system.reflection.metadata@5.0.0
system.reflection.primitives@4.0.1
system.reflection.primitives@4.3.0
system.reflection.typeextensions@4.1.0
system.reflection.typeextensions@4.3.0
system.reflection@4.1.0
system.reflection@4.3.0
system.resources.resourcemanager@4.0.1
system.resources.resourcemanager@4.3.0
system.runtime.compilerservices.unsafe@4.4.0
system.runtime.compilerservices.unsafe@4.5.0
system.runtime.compilerservices.unsafe@4.5.3
system.runtime.compilerservices.unsafe@5.0.0
system.runtime.compilerservices.unsafe@6.0.0
system.runtime.extensions@4.1.0
system.runtime.extensions@4.3.0
system.runtime.handles@4.0.1
system.runtime.handles@4.3.0
system.runtime.interopservices.runtimeinformation@4.0.0
system.runtime.interopservices.runtimeinformation@4.3.0
system.runtime.interopservices@4.1.0
system.runtime.interopservices@4.3.0
system.runtime.numerics@4.3.0
system.runtime.serialization.primitives@4.1.1
system.runtime@4.1.0
system.runtime@4.3.0
system.security.accesscontrol@6.0.0
system.security.accesscontrol@6.0.0-preview.5.21301.5
system.security.claims@4.3.0
system.security.cryptography.algorithms@4.3.0
system.security.cryptography.cng@4.3.0
system.security.cryptography.csp@4.3.0
system.security.cryptography.encoding@4.3.0
system.security.cryptography.openssl@4.3.0
system.security.cryptography.primitives@4.3.0
system.security.cryptography.protecteddata@6.0.0
system.security.cryptography.x509certificates@4.3.0
system.security.permissions@6.0.0
system.security.principal.windows@4.3.0
system.security.principal.windows@5.0.0
system.security.principal.windows@6.0.0-preview.5.21301.5
system.security.principal@4.3.0
system.text.encoding.codepages@4.5.1
system.text.encoding.extensions@4.0.11
system.text.encoding.extensions@4.3.0
system.text.encoding@4.0.11
system.text.encoding@4.3.0
system.text.encodings.web@6.0.0
system.text.json@6.0.6
system.text.regularexpressions@4.1.0
system.text.regularexpressions@4.3.0
system.threading.tasks.extensions@4.0.0
system.threading.tasks.extensions@4.3.0
system.threading.tasks.extensions@4.5.4
system.threading.tasks@4.0.11
system.threading.tasks@4.3.0
system.threading.threadpool@4.3.0
system.threading.timer@4.3.0
system.threading@4.0.11
system.threading@4.3.0
system.windows.extensions@6.0.0
system.xml.readerwriter@4.0.11
system.xml.readerwriter@4.3.0
system.xml.xdocument@4.0.11
system.xml.xdocument@4.3.0
system.xml.xmldocument@4.3.0
veldrid.imagesharp@4.9.0
veldrid.metalbindings@4.9.0
veldrid.openglbindings@4.9.0
veldrid.sdl2@4.9.0
veldrid.startuputilities@4.9.0
veldrid@4.9.0
vk@1.0.25
vortice.d3dcompiler@2.3.0
vortice.direct3d11@2.3.0
vortice.directx@2.3.0
vortice.dxgi@2.3.0
vortice.mathematics@1.4.25
"

inherit dotnet-pkg desktop xdg

DESCRIPTION="Custom Launcher for Final Fantasy XIV Online (Crossplatform rewrite)"

HOMEPAGE="https://github.com/goatcorp/XIVLauncher.Core/"

IUSE="+aria2 +libsecret"

RDEPEND="
	aria2? ( net-misc/aria2 )
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
	|| ( sys-libs/libunwind sys-libs/llvm-libunwind )
	media-libs/freetype:2
	media-libs/glu
	x11-libs/libSM
"

XIVQL_COMMIT="020dde9d504f879a56b08fde570bcb4b5772ed3e"

SRC_URI="
	https://github.com/goatcorp/XIVLauncher.Core/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/goatcorp/FFXIVQuickLauncher/archive/${XIVQL_COMMIT}.tar.gz
		-> FFXIVQuickLauncher-${XIVQL_COMMIT}.tar.gz
	${NUGET_URIS}
"

S="${WORKDIR}/XIVLauncher.Core-${PV}/src"

DOTNET_PKG_PROJECTS=( "${S}/XIVLauncher.Core/XIVLauncher.Core.csproj" )

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	rmdir "${WORKDIR}/XIVLauncher.Core-${PV}/lib/FFXIVQuickLauncher" || die
	mv "${WORKDIR}/FFXIVQuickLauncher-${XIVQL_COMMIT}" \
		"${WORKDIR}/XIVLauncher.Core-${PV}/lib/FFXIVQuickLauncher" || die
	sed -i "s/git -C .* describe --long --always --dirty &gt; \$(VerFile)/echo ${PV}/" \
		XIVLauncher.Core/XIVLauncher.Core.csproj

	dotnet-pkg_src_prepare
}

src_install() {
	# lower openssl security for the launcher due to Square Enix's standards
	cp "${FILESDIR}/openssl.cnf" "${DOTNET_PKG_OUTPUT}/"

	dotnet-pkg-base_install
	dotnet-pkg-base_append_launchervar "OPENSSL_CONF=/usr/share/${P}/openssl.cnf"
	dotnet-pkg-base_dolauncher "/usr/share/${P}/XIVLauncher.Core" "xivlauncher"

	domenu ../misc/linux_distrib/XIVLauncher.desktop
	newicon -s 512 ../misc/linux_distrib/512.png xivlauncher.png
}
