# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT=6.0
NUGETS="
atksharp@3.24.24.34
cairosharp@3.24.24.34
castle.core@4.4.0
coverlet.collector@3.0.2
eto.forms@2.5.10
eto.forms@2.5.11
eto.platform.gtk@2.5.11
gdksharp@3.24.24.34
giosharp@3.24.24.34
glibsharp@3.24.24.34
gtksharp@3.24.24.34
hidsharpcore@1.2.1.1
messagepack@2.1.194
messagepack.annotations@2.1.194
microsoft.bcl.asyncinterfaces@1.1.1
microsoft.codecoverage@16.9.4
microsoft.csharp@4.0.1
microsoft.extensions.dependencyinjection@6.0.0-rc.1.21451.13
microsoft.extensions.dependencyinjection.abstractions@6.0.0-rc.1.21451.13
microsoft.netcore.platforms@1.0.1
microsoft.netcore.platforms@1.1.0
microsoft.netcore.platforms@1.1.1
microsoft.netcore.platforms@3.0.0
microsoft.netcore.targets@1.0.1
microsoft.netcore.targets@1.1.0
microsoft.net.test.sdk@16.9.4
microsoft.testplatform.objectmodel@16.9.4
microsoft.testplatform.testhost@16.9.4
microsoft.visualstudio.threading@16.7.56
microsoft.visualstudio.threading.analyzers@16.7.56
microsoft.visualstudio.validation@15.5.31
microsoft.win32.primitives@4.3.0
microsoft.win32.registry@4.6.0
moq@4.16.1
nerdbank.streams@2.6.77
netstandard.library@1.6.1
newtonsoft.json@12.0.2
newtonsoft.json@13.0.1
newtonsoft.json@13.0.3
newtonsoft.json@9.0.1
newtonsoft.json.schema@3.0.15
nuget.frameworks@5.0.0
octokit@0.50.0
pangosharp@3.24.24.34
runtime.any.system.collections@4.3.0
runtime.any.system.diagnostics.tools@4.3.0
runtime.any.system.diagnostics.tracing@4.3.0
runtime.any.system.globalization@4.3.0
runtime.any.system.globalization.calendars@4.3.0
runtime.any.system.io@4.3.0
runtime.any.system.reflection@4.3.0
runtime.any.system.reflection.extensions@4.3.0
runtime.any.system.reflection.primitives@4.3.0
runtime.any.system.resources.resourcemanager@4.3.0
runtime.any.system.runtime@4.3.0
runtime.any.system.runtime.handles@4.3.0
runtime.any.system.runtime.interopservices@4.3.0
runtime.any.system.text.encoding@4.3.0
runtime.any.system.text.encoding.extensions@4.3.0
runtime.any.system.threading.tasks@4.3.0
runtime.any.system.threading.timer@4.3.0
runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.native.system@4.3.0
runtime.native.system.io.compression@4.3.0
runtime.native.system.net.http@4.3.0
runtime.native.system.security.cryptography.apple@4.3.0
runtime.native.system.security.cryptography.openssl@4.3.0
runtime.native.system.security.cryptography.openssl@4.3.2
runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple@4.3.0
runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.unix.microsoft.win32.primitives@4.3.0
runtime.unix.system.console@4.3.0
runtime.unix.system.diagnostics.debug@4.3.0
runtime.unix.system.io.filesystem@4.3.0
runtime.unix.system.net.primitives@4.3.0
runtime.unix.system.net.sockets@4.3.0
runtime.unix.system.private.uri@4.3.0
runtime.unix.system.runtime.extensions@4.3.0
sharpziplib@1.3.3
streamjsonrpc@2.6.121
system.appcontext@4.3.0
system.buffers@4.3.0
system.collections@4.0.11
system.collections@4.3.0
system.collections.concurrent@4.3.0
system.collections.immutable@1.7.1
system.collections.nongeneric@4.3.0
system.collections.specialized@4.3.0
system.commandline@2.0.0-beta4.22272.1
system.componentmodel@4.3.0
system.componentmodel.annotations@4.7.0
system.componentmodel.annotations@5.0.0
system.componentmodel.primitives@4.3.0
system.componentmodel.typeconverter@4.3.0
system.console@4.3.0
system.diagnostics.debug@4.0.11
system.diagnostics.debug@4.3.0
system.diagnostics.diagnosticsource@4.3.0
system.diagnostics.tools@4.0.1
system.diagnostics.tools@4.3.0
system.diagnostics.tracesource@4.3.0
system.diagnostics.tracing@4.3.0
system.dynamic.runtime@4.0.11
system.dynamic.runtime@4.3.0
system.globalization@4.0.11
system.globalization@4.3.0
system.globalization.calendars@4.3.0
system.globalization.extensions@4.3.0
system.io@4.1.0
system.io@4.3.0
system.io.compression@4.3.0
system.io.compression.zipfile@4.3.0
system.io.filesystem@4.0.1
system.io.filesystem@4.3.0
system.io.filesystem.primitives@4.0.1
system.io.filesystem.primitives@4.3.0
system.io.pipelines@4.7.2
system.linq@4.1.0
system.linq@4.3.0
system.linq.expressions@4.1.0
system.linq.expressions@4.3.0
system.memory@4.5.4
system.net.http@4.3.0
system.net.http@4.3.4
system.net.nameresolution@4.3.0
system.net.primitives@4.3.0
system.net.sockets@4.3.0
system.net.websockets@4.3.0
system.objectmodel@4.0.12
system.objectmodel@4.3.0
system.private.uri@4.3.0
system.reflection@4.1.0
system.reflection@4.3.0
system.reflection.emit@4.0.1
system.reflection.emit@4.3.0
system.reflection.emit@4.7.0
system.reflection.emit.ilgeneration@4.0.1
system.reflection.emit.ilgeneration@4.3.0
system.reflection.emit.lightweight@4.0.1
system.reflection.emit.lightweight@4.3.0
system.reflection.emit.lightweight@4.6.0
system.reflection.extensions@4.0.1
system.reflection.extensions@4.3.0
system.reflection.metadata@1.6.0
system.reflection.primitives@4.0.1
system.reflection.primitives@4.3.0
system.reflection.typeextensions@4.1.0
system.reflection.typeextensions@4.3.0
system.resources.resourcemanager@4.0.1
system.resources.resourcemanager@4.3.0
system.runtime@4.1.0
system.runtime@4.3.0
system.runtime.compilerservices.unsafe@4.5.2
system.runtime.compilerservices.unsafe@4.7.1
system.runtime.compilerservices.unsafe@6.0.0-rc.1.21451.13
system.runtime.extensions@4.1.0
system.runtime.extensions@4.3.0
system.runtime.handles@4.0.1
system.runtime.handles@4.3.0
system.runtime.interopservices@4.1.0
system.runtime.interopservices@4.3.0
system.runtime.interopservices.runtimeinformation@4.3.0
system.runtime.numerics@4.3.0
system.runtime.serialization.primitives@4.1.1
system.security.accesscontrol@4.6.0
system.security.claims@4.3.0
system.security.cryptography.algorithms@4.3.0
system.security.cryptography.cng@4.3.0
system.security.cryptography.csp@4.3.0
system.security.cryptography.encoding@4.3.0
system.security.cryptography.openssl@4.3.0
system.security.cryptography.primitives@4.3.0
system.security.cryptography.x509certificates@4.3.0
system.security.principal@4.3.0
system.security.principal.windows@4.3.0
system.security.principal.windows@4.6.0
system.text.encoding@4.0.11
system.text.encoding@4.3.0
system.text.encoding.extensions@4.0.11
system.text.encoding.extensions@4.3.0
system.text.regularexpressions@4.1.0
system.text.regularexpressions@4.3.0
system.threading@4.0.11
system.threading@4.3.0
system.threading.tasks@4.0.11
system.threading.tasks@4.3.0
system.threading.tasks.dataflow@4.11.1
system.threading.tasks.extensions@4.0.0
system.threading.tasks.extensions@4.3.0
system.threading.tasks.extensions@4.5.4
system.threading.threadpool@4.3.0
system.threading.timer@4.3.0
system.xml.readerwriter@4.0.11
system.xml.readerwriter@4.3.0
system.xml.xdocument@4.0.11
system.xml.xdocument@4.3.0
system.xml.xmldocument@4.3.0
waylandnet@0.2.0
xunit@2.4.1
xunit.abstractions@2.0.3
xunit.analyzers@0.10.0
xunit.assert@2.4.1
xunit.core@2.4.1
xunit.extensibility.core@2.4.1
xunit.extensibility.execution@2.4.1
xunit.runner.visualstudio@2.4.3
"

inherit desktop dotnet-pkg linux-info udev xdg

DESCRIPTION="A cross-platform open-source tablet driver"
HOMEPAGE="https://opentabletdriver.net/"
SRC_URI="
	https://github.com/OpenTabletDriver/OpenTabletDriver/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${NUGET_URIS}
"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/libevdev
	virtual/udev
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/gtk+:3
	!x11-drivers/OpenTabletDriver-bin
"
BDEPEND="app-misc/jq"

PATCHES=( "${FILESDIR}/${P}-nogit.patch" )

CONFIG_CHECK="~INPUT_UINPUT"
DOTNET_PKG_PROJECTS=(
	"${S}/OpenTabletDriver.Console/OpenTabletDriver.Console.csproj"
	"${S}/OpenTabletDriver.Daemon/OpenTabletDriver.Daemon.csproj"
	"${S}/OpenTabletDriver.UX.Gtk/OpenTabletDriver.UX.Gtk.csproj"
)

pkg_setup() {
	linux-info_pkg_setup
	dotnet-pkg_pkg_setup
}

src_prepare() {
	# Build doesn't need the solution file but eclass tries to use it.
	rm -f OpenTabletDriver.sln || die
	dotnet-pkg_src_prepare
}

src_configure() {
	dotnet-pkg_src_configure

	# These projects are only used at build time, should not be installed.
	dotnet-pkg-base_restore OpenTabletDriver.Tests
}

src_compile() {
	dotnet-pkg_src_compile
	./generate-rules.sh -c OpenTabletDriver.Configurations/Configurations > 70-opentabletdriver.rules || die
}

src_install() {
	dotnet-pkg_src_install

	dotnet-pkg-base_dolauncher "/usr/share/${P}/${PN}.Console" otd
	dotnet-pkg-base_dolauncher "/usr/share/${P}/${PN}.Daemon" otd-daemon
	dotnet-pkg-base_dolauncher "/usr/share/${P}/${PN}.UX.Gtk" otd-gui

	doicon OpenTabletDriver.UX/Assets/otd.png
	doman docs/manpages/opentabletdriver.8
	make_desktop_entry otd-gui OpenTabletDriver otd Settings
	udev_dorules 70-opentabletdriver.rules

	cd "${S}/eng/linux/Generic/usr/lib" || die
	insinto /lib/modprobe.d
	doins modprobe.d/99-opentabletdriver.conf
	insinto /usr/lib/modules-load.d
	doins modules-load.d/opentabletdriver.conf
	insinto /usr/lib/systemd/user
	doins systemd/user/opentabletdriver.service
}

src_test() {
	dotnet-pkg-base_test OpenTabletDriver.Tests
}

pkg_postinst() {
	udev_reload
	xdg_pkg_postinst

	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "Please replug your tablet before attempting to use the driver"
	fi
}

pkg_postrm() {
	udev_reload
	xdg_pkg_postrm
}
