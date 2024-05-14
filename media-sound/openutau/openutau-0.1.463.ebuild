# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DOTNET_PKG_COMPAT=6.0

NUGETS="
asyncio@0.1.69
avalonia.angle.windows.natives@2.1.0.2023020321
avalonia.buildservices@0.0.29
avalonia.controls.colorpicker@11.0.4
avalonia.controls.datagrid@11.0.4
avalonia.desktop@11.0.4
avalonia.diagnostics@11.0.4
avalonia.freedesktop@11.0.4
avalonia.native@11.0.4
avalonia.reactiveui@11.0.4
avalonia.remote.protocol@11.0.4
avalonia.skia@11.0.4
avalonia.themes.fluent@11.0.4
avalonia.themes.simple@11.0.4
avalonia.win32@11.0.4
avalonia.x11@11.0.4
avalonia@11.0.4
bunlabs.naudio.flac@2.0.1
concentus.oggfile@1.0.4
concentus@1.1.7
coverlet.collector@6.0.2
dotnet.bundle@0.9.13
dynamicdata@7.9.5
fody@6.6.3
harfbuzzsharp.nativeassets.linux@2.8.2.3
harfbuzzsharp.nativeassets.macos@2.8.2.3
harfbuzzsharp.nativeassets.webassembly@2.8.2.3
harfbuzzsharp.nativeassets.win32@2.8.2.3
harfbuzzsharp@2.8.2.3
ignore@0.1.50
k4os.hash.xxhash@1.0.8
melanchall.drywetmidi@7.0.2
microcom.runtime@0.11.0
microsoft.bcl.asyncinterfaces@5.0.0
microsoft.bcl.hashcode@1.1.1
microsoft.codeanalysis.analyzers@3.0.0
microsoft.codeanalysis.common@3.8.0
microsoft.codeanalysis.csharp.scripting@3.8.0
microsoft.codeanalysis.csharp@3.8.0
microsoft.codeanalysis.scripting.common@3.8.0
microsoft.codecoverage@17.9.0
microsoft.csharp@4.3.0
microsoft.extensions.objectpool@5.0.10
microsoft.ml.onnxruntime.managed@1.15.0
microsoft.ml.onnxruntime@1.15.0
microsoft.net.test.sdk@17.9.0
microsoft.netcore.app.crossgen2.linux-x64@6.0.25
microsoft.netcore.platforms@1.1.0
microsoft.netcore.platforms@2.1.2
microsoft.netcore.platforms@3.1.0
microsoft.netcore.platforms@5.0.0
microsoft.netcore.targets@1.1.0
microsoft.testplatform.objectmodel@17.9.0
microsoft.testplatform.testhost@17.9.0
microsoft.win32.primitives@4.3.0
microsoft.win32.systemevents@5.0.0
microsoft.win32.systemevents@6.0.0
nacl.net@0.1.13
naudio.core@2.2.1
naudio.midi@2.2.1
naudio.vorbis@1.5.0
netmq@4.0.1.13
netsparkleupdater.sparkleupdater@2.2.3
netstandard.library@1.6.1
newtonsoft.json@13.0.3
nlayer.naudiosupport@1.4.0
nlayer@1.15.0
numsharp@0.30.0
nvorbis@0.10.4
nwaves@0.9.6
polysharp@1.10.0
portable.bouncycastle@1.9.0
reactiveui.fody@18.3.1
reactiveui@18.3.1
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
serilog.sinks.console@5.0.1
serilog.sinks.debug@2.0.0
serilog.sinks.file@5.0.0
serilog@3.1.1
sharpcompress@0.36.0
sharpgen.runtime.com@2.0.0-beta.13
sharpgen.runtime@2.0.0-beta.13
skiasharp.nativeassets.linux@2.88.3
skiasharp.nativeassets.macos@2.88.3
skiasharp.nativeassets.webassembly@2.88.3
skiasharp.nativeassets.win32@2.88.3
skiasharp@2.88.3
splat@14.4.1
system.appcontext@4.3.0
system.buffers@4.5.1
system.collections.concurrent@4.3.0
system.collections.immutable@5.0.0
system.collections@4.3.0
system.componentmodel.annotations@4.5.0
system.componentmodel.annotations@5.0.0
system.console@4.3.0
system.diagnostics.debug@4.3.0
system.diagnostics.diagnosticsource@4.3.0
system.diagnostics.diagnosticsource@7.0.2
system.diagnostics.tools@4.3.0
system.diagnostics.tracing@4.3.0
system.drawing.common@5.0.0
system.drawing.common@6.0.0
system.dynamic.runtime@4.3.0
system.formats.asn1@5.0.0
system.globalization.calendars@4.3.0
system.globalization.extensions@4.3.0
system.globalization@4.3.0
system.io.compression.zipfile@4.3.0
system.io.compression@4.3.0
system.io.filesystem.primitives@4.3.0
system.io.filesystem@4.3.0
system.io.packaging@7.0.0
system.io.pipelines@6.0.0
system.io@4.3.0
system.linq.expressions@4.3.0
system.linq@4.3.0
system.memory@4.5.3
system.memory@4.5.4
system.memory@4.5.5
system.net.http@4.3.0
system.net.nameresolution@4.3.0
system.net.primitives@4.3.0
system.net.sockets@4.3.0
system.numerics.vectors@4.4.0
system.numerics.vectors@4.5.0
system.objectmodel@4.3.0
system.private.servicemodel@4.9.0
system.private.uri@4.3.0
system.reactive@5.0.0
system.reflection.dispatchproxy@4.7.1
system.reflection.emit.ilgeneration@4.3.0
system.reflection.emit.lightweight@4.3.0
system.reflection.emit@4.3.0
system.reflection.extensions@4.3.0
system.reflection.metadata@1.6.0
system.reflection.metadata@5.0.0
system.reflection.primitives@4.3.0
system.reflection.typeextensions@4.3.0
system.reflection@4.3.0
system.resources.resourcemanager@4.3.0
system.runtime.compilerservices.unsafe@4.5.2
system.runtime.compilerservices.unsafe@4.5.3
system.runtime.compilerservices.unsafe@4.7.0
system.runtime.compilerservices.unsafe@4.7.1
system.runtime.compilerservices.unsafe@6.0.0
system.runtime.extensions@4.3.0
system.runtime.handles@4.3.0
system.runtime.interopservices.runtimeinformation@4.3.0
system.runtime.interopservices@4.3.0
system.runtime.numerics@4.3.0
system.runtime@4.3.0
system.security.accesscontrol@5.0.0
system.security.claims@4.3.0
system.security.cryptography.algorithms@4.3.0
system.security.cryptography.cng@4.3.0
system.security.cryptography.cng@5.0.0
system.security.cryptography.csp@4.3.0
system.security.cryptography.encoding@4.3.0
system.security.cryptography.openssl@4.3.0
system.security.cryptography.pkcs@5.0.0
system.security.cryptography.primitives@4.3.0
system.security.cryptography.x509certificates@4.3.0
system.security.cryptography.xml@5.0.0
system.security.permissions@5.0.0
system.security.principal.windows@4.3.0
system.security.principal.windows@5.0.0
system.security.principal@4.3.0
system.servicemodel.primitives@4.9.0
system.text.encoding.codepages@7.0.0
system.text.encoding.codepages@4.5.1
system.text.encoding.codepages@4.7.0
system.text.encoding.codepages@8.0.0
system.text.encoding.extensions@4.3.0
system.text.encoding@4.3.0
system.text.encodings.web@7.0.0
system.text.json@7.0.2
system.text.regularexpressions@4.3.0
system.threading.tasks.extensions@4.3.0
system.threading.tasks.extensions@4.5.4
system.threading.tasks@4.3.0
system.threading.threadpool@4.3.0
system.threading.timer@4.3.0
system.threading@4.3.0
system.valuetuple@4.5.0
system.windows.extensions@5.0.0
system.xml.readerwriter@4.3.0
system.xml.xdocument@4.3.0
tmds.dbus.protocol@0.15.0
utf.unknown@2.5.1
vortice.directx@2.4.2
vortice.dxgi@2.4.2
vortice.mathematics@1.4.25
wanakana-net@1.0.0
xunit.abstractions@2.0.3
xunit.analyzers@1.12.0
xunit.assert@2.7.1
xunit.core@2.7.1
xunit.extensibility.core@2.7.1
xunit.extensibility.execution@2.7.1
xunit.runner.visualstudio@2.5.8
xunit@2.7.1
yamldotnet@15.1.2
zstdsharp.port@0.7.4
"

inherit desktop dotnet-pkg xdg

DESCRIPTION="Open source UTAU successor"
HOMEPAGE="https://github.com/stakira/OpenUtau"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/stakira/OpenUtau.git"
	inherit git-r3
else
	KEYWORDS="~amd64 ~arm ~arm64"
	SRC_URI="https://github.com/stakira/OpenUtau/archive/refs/tags/build/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/OpenUtau-build-${PV}"
fi

SRC_URI+=" ${NUGET_URIS} "

LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-dotnet/dotnet-sdk-bin
	sys-fs/fuse-common
	media-libs/alsa-lib
"

DEPEND="${RDEPEND}
"

DOTNET_PKG_PROJECTS=( OpenUtau/OpenUtau.csproj )

src_unpack() {
	dotnet-pkg_src_unpack

	if [[ -n "${EGIT_REPO_URI}" ]] ; then
		git-r3_src_unpack
	fi
}

src_compile() {
	DOTNET_PKG_BUILD_EXTRA_ARGS+=(
		-p:Version="${PV}"
	)
	dotnet-pkg_src_compile
}

src_test() {
	dotnet-pkg-base_test OpenUtau.Test/OpenUtau.Test.csproj
}

src_install() {
	dotnet-pkg-base_install
	dotnet-pkg-base_dolauncher "/usr/share/${P}/OpenUtau" openutau

	insinto /usr/share/pixmaps
	doins "${S}/Logo/openutau.svg"
	domenu "${FILESDIR}/OpenUtau.desktop"
}
