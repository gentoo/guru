# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT=9.0
NUGETS="
aaxclean.codecs@2.0.2.2
aaxclean@2.0.2.1
audibleapi@9.4.4.1
avalonia.angle.windows.natives@2.1.25547.20250602
avalonia.buildservices@0.0.31
avalonia.controls.colorpicker@11.3.3
avalonia.controls.datagrid@11.3.3
avalonia.desktop@11.3.3
avalonia.diagnostics@11.3.3
avalonia.freedesktop@11.3.3
avalonia.native@11.3.3
avalonia.reactiveui@11.3.3
avalonia.remote.protocol@11.3.3
avalonia.skia@11.3.3
avalonia.themes.fluent@11.3.3
avalonia.themes.simple@11.3.3
avalonia.win32@11.3.3
avalonia.x11@11.3.3
avalonia@11.3.3
bouncycastle.cryptography@2.4.0
csvhelper@33.1.0
dinah.core@9.0.0.1
dinah.core@9.0.2.1
dinah.entityframeworkcore@9.0.0.1
dynamicdata@8.4.1
enums.net@5.0.0
extendednumerics.bigdecimal@2025.1001.2.129
google.protobuf@3.32.0
harfbuzzsharp.nativeassets.linux@8.3.1.1
harfbuzzsharp.nativeassets.macos@8.3.1.1
harfbuzzsharp.nativeassets.webassembly@8.3.1.1
harfbuzzsharp.nativeassets.win32@8.3.1.1
harfbuzzsharp@8.3.1.1
htmlagilitypack@1.11.71
htmlagilitypack@1.12.0
humanizer.core@2.14.1
lucenenet303r2@3.0.3.9
mathnet.numerics.signed@5.0.0
microcom.runtime@0.11.0
microsoft.bcl.asyncinterfaces@7.0.0
microsoft.build.framework@16.10.0
microsoft.build.framework@17.8.3
microsoft.build.locator@1.7.8
microsoft.build.tasks.git@8.0.0
microsoft.codeanalysis.analyzers@3.3.4
microsoft.codeanalysis.common@4.8.0
microsoft.codeanalysis.csharp.workspaces@4.8.0
microsoft.codeanalysis.csharp@4.8.0
microsoft.codeanalysis.workspaces.common@4.8.0
microsoft.codeanalysis.workspaces.msbuild@4.8.0
microsoft.data.sqlite.core@9.0.8
microsoft.entityframeworkcore.abstractions@9.0.0
microsoft.entityframeworkcore.abstractions@9.0.8
microsoft.entityframeworkcore.analyzers@9.0.0
microsoft.entityframeworkcore.analyzers@9.0.8
microsoft.entityframeworkcore.design@9.0.8
microsoft.entityframeworkcore.relational@9.0.0
microsoft.entityframeworkcore.relational@9.0.8
microsoft.entityframeworkcore.sqlite.core@9.0.8
microsoft.entityframeworkcore.sqlite@9.0.8
microsoft.entityframeworkcore.tools@9.0.8
microsoft.entityframeworkcore@9.0.0
microsoft.entityframeworkcore@9.0.8
microsoft.extensions.caching.abstractions@9.0.8
microsoft.extensions.caching.memory@9.0.0
microsoft.extensions.caching.memory@9.0.8
microsoft.extensions.configuration.abstractions@9.0.0
microsoft.extensions.configuration.abstractions@9.0.8
microsoft.extensions.configuration.binder@8.0.0
microsoft.extensions.configuration.binder@9.0.0
microsoft.extensions.configuration.fileextensions@9.0.0
microsoft.extensions.configuration.fileextensions@9.0.8
microsoft.extensions.configuration.json@9.0.0
microsoft.extensions.configuration.json@9.0.8
microsoft.extensions.configuration@9.0.0
microsoft.extensions.configuration@9.0.8
microsoft.extensions.dependencyinjection.abstractions@9.0.8
microsoft.extensions.dependencyinjection@9.0.8
microsoft.extensions.dependencymodel@8.0.2
microsoft.extensions.dependencymodel@9.0.0
microsoft.extensions.dependencymodel@9.0.8
microsoft.extensions.fileproviders.abstractions@9.0.0
microsoft.extensions.fileproviders.abstractions@9.0.8
microsoft.extensions.fileproviders.physical@9.0.0
microsoft.extensions.fileproviders.physical@9.0.8
microsoft.extensions.filesystemglobbing@9.0.0
microsoft.extensions.filesystemglobbing@9.0.8
microsoft.extensions.logging.abstractions@9.0.8
microsoft.extensions.logging@9.0.0
microsoft.extensions.logging@9.0.8
microsoft.extensions.options@9.0.8
microsoft.extensions.primitives@9.0.0
microsoft.extensions.primitives@9.0.8
microsoft.io.recyclablememorystream@3.0.1
microsoft.netcore.app.crossgen2.linux-x64@9.0.7
microsoft.netcore.platforms@1.1.0
microsoft.netcore.platforms@5.0.0
microsoft.netcore.targets@1.1.0
microsoft.sourcelink.common@8.0.0
microsoft.sourcelink.github@8.0.0
mono.texttemplating@3.0.0
nameparsersharp@1.5.0
naudio.core@2.2.1
newtonsoft.json@13.0.3
npoi@2.7.4
octokit@14.0.0
pluralize.net@1.0.2
polly.core@8.6.2
polly@8.6.2
reactiveui@20.1.1
serilog.exceptions@8.4.0
serilog.settings.configuration@8.0.4
serilog.settings.configuration@9.0.0
serilog.sinks.console@6.0.0
serilog.sinks.file@6.0.0
serilog.sinks.file@7.0.0
serilog@2.8.0
serilog@3.1.1
serilog@4.0.0
serilog@4.2.0
sharpziplib@1.4.2
sixlabors.fonts@1.0.1
sixlabors.imagesharp@2.1.10
sixlabors.imagesharp@3.1.11
skiasharp.nativeassets.linux@2.88.9
skiasharp.nativeassets.macos@2.88.9
skiasharp.nativeassets.webassembly@2.88.9
skiasharp.nativeassets.win32@2.88.9
skiasharp@2.88.9
splat@15.1.1
sqlitepclraw.bundle_e_sqlite3@2.1.10
sqlitepclraw.core@2.1.10
sqlitepclraw.lib.e_sqlite3@2.1.10
sqlitepclraw.provider.e_sqlite3@2.1.10
system.codedom@6.0.0
system.collections.immutable@7.0.0
system.collections.immutable@9.0.0
system.collections.immutable@9.0.2
system.collections.nongeneric@4.3.0
system.componentmodel.annotations@5.0.0
system.composition.attributedmodel@7.0.0
system.composition.convention@7.0.0
system.composition.hosting@7.0.0
system.composition.runtime@7.0.0
system.composition.typedparts@7.0.0
system.composition@7.0.0
system.configuration.configurationmanager@9.0.0
system.diagnostics.debug@4.3.0
system.diagnostics.eventlog@9.0.0
system.diagnostics.eventlog@9.0.2
system.globalization@4.3.0
system.io.pipelines@7.0.0
system.io.pipelines@8.0.0
system.memory@4.5.3
system.reactive@6.0.0
system.reactive@6.0.1
system.reflection.metadata@7.0.0
system.reflection.typeextensions@4.7.0
system.reflection@4.3.0
system.resources.resourcemanager@4.3.0
system.runtime.compilerservices.unsafe@5.0.0
system.runtime.compilerservices.unsafe@6.0.0
system.runtime.extensions@4.3.0
system.runtime@4.3.0
system.security.cryptography.pkcs@8.0.1
system.security.cryptography.protecteddata@9.0.0
system.security.cryptography.xml@8.0.2
system.security.principal.windows@5.0.0
system.serviceprocess.servicecontroller@9.0.0
system.serviceprocess.servicecontroller@9.0.2
system.text.encoding.codepages@5.0.0
system.text.json@7.0.3
system.text.json@9.0.8
system.threading.channels@7.0.0
system.threading.tasks@4.3.0
system.threading@4.3.0
tmds.dbus.protocol@0.21.2
zstring@2.6.0
"

inherit desktop xdg dotnet-pkg

DESCRIPTION="Libation: Free, open-source Audible library manager"
HOMEPAGE="https://github.com/rmcrackan/Libation"

SRC_URI="https://github.com/rmcrackan/Libation/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz ${NUGET_URIS}"

S="${WORKDIR}/Libation-${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Required by dotnet-pkg.eclass
DOTNET_PKG_PROJECTS=( "Source/LibationAvalonia/LibationAvalonia.csproj" )
DEPEND="
	>=dev-dotnet/dotnet-sdk-9.0
	x11-libs/libX11
	dev-dotnet/libgdiplus
	media-libs/fontconfig
	media-libs/libglvnd
	media-gfx/icoutils
"
RDEPEND="${DEPEND}
	>=dev-dotnet/csharp-gentoodotnetinfo-0
"
pkg_setup() {
	dotnet-pkg_pkg_setup
}
src_unpack() {
	dotnet-pkg_src_unpack
}

src_prepare() {
	dotnet-pkg_src_prepare
	sed -i 	-e 's#<OutputType>WinExe</OutputType>#<OutputType>Exe</OutputType>#' \
		-e 's#net9.0-windows7.0#net9.0#' \
		-e 's#win-x64#linux-x64#' \
		"${S}/Source/LibationAvalonia/LibationAvalonia.csproj" || die "Failed to patch csproj"

}

src_configure() {
	dotnet-pkg_src_configure
}

src_compile() {
	dotnet-pkg_src_compile
}

src_install() {
	# Install the built binaries using dotnet-pkg.eclass
	dotnet-pkg_src_install

	# Create a launcher script
	dosym -r /usr/bin/Libation /usr/bin/libation

	# Install desktop entry
	echo '[Desktop Entry]' > "${T}/libation.desktop"
	echo 'Name=Libation' >> "${T}/libation.desktop"
	echo 'Exec=/usr/bin/libation' >> "${T}/libation.desktop"
	echo 'Type=Application' >> "${T}/libation.desktop"
	echo 'Terminal=false' >> "${T}/libation.desktop"
	echo 'Categories=Utility;Audio;AudioVideo' >> "${T}/libation.desktop"
	echo 'Icon=libation' >> "${T}/libation.desktop"
	domenu "${T}/libation.desktop"

	# Install icons if available
	if [[ -d "${S}/Source/LibationAvalonia/Assets" ]]; then
		# Extract all images from .ico to .png
		mkdir -p "${T}/icons"
		icotool -x -o "${T}/icons" "${S}/Source/LibationAvalonia/Assets/libation.ico" || die "Failed to extract icons"
		newicon -s 16 "${T}/icons/libation_1_16x16x32.png" libation.png
		newicon -s 24 "${T}/icons/libation_3_24x24x32.png" libation.png
		newicon -s 32 "${T}/icons/libation_4_32x32x32.png" libation.png
		newicon -s 48 "${T}/icons/libation_6_48x48x32.png" libation.png
		newicon -s 64 "${T}/icons/libation_7_64x64x32.png" libation.png
		newicon -s 96 "${T}/icons/libation_8_96x96x32.png" libation.png
		newicon -s 128 "${T}/icons/libation_9_128x128x32.png" libation.png
		newicon -s 256 "${T}/icons/libation_10_256x256x32.png" libation.png
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
