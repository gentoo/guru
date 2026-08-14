# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT=8.0
NUGETS="
atksharp@3.24.24.34
cairosharp@3.24.24.34
castle.core@5.1.1
coverlet.collector@6.0.4
diffplex@1.9.0
eto.forms@2.5.10
eto.forms@2.5.11
eto.platform.gtk@2.5.11
gdksharp@3.24.24.34
giosharp@3.24.24.34
glibsharp@3.24.24.34
gtksharp@3.24.24.34
hidsharpcore@1.3.0
jetbrains.annotations@2025.2.4
messagepack@2.5.192
messagepack.annotations@2.5.192
microsoft.codecoverage@18.0.1
microsoft.extensions.dependencyinjection@10.0.1
microsoft.extensions.dependencyinjection.abstractions@10.0.1
microsoft.net.stringtools@17.6.3
microsoft.net.test.sdk@18.0.1
microsoft.testplatform.objectmodel@18.0.1
microsoft.testplatform.testhost@18.0.1
microsoft.visualstudio.threading.only@17.13.61
microsoft.visualstudio.validation@17.8.8
nerdbank.streams@2.12.87
newtonsoft.json@13.0.3
newtonsoft.json@13.0.4
newtonsoft.json.schema@4.0.1
nsubstitute@5.3.0
nsubstitute.analyzers.csharp@1.0.17
octokit@14.0.0
pangosharp@3.24.24.34
sharpziplib@1.4.2
streamjsonrpc@2.22.23
system.collections.immutable@8.0.0
system.commandline@2.0.1
system.componentmodel.annotations@4.7.0
system.componentmodel.annotations@5.0.0
system.diagnostics.eventlog@6.0.0
system.io.pipelines@8.0.0
system.reflection.metadata@8.0.0
validation@2.5.51
waylandnet@0.2.0
xunit@2.9.3
xunit.abstractions@2.0.2
xunit.abstractions@2.0.3
xunit.analyzers@1.18.0
xunit.assert@2.9.3
xunit.core@2.9.3
xunit.extensibility.core@2.4.0
xunit.extensibility.core@2.9.3
xunit.extensibility.execution@2.4.0
xunit.extensibility.execution@2.9.3
xunit.runner.visualstudio@3.1.5
xunit.skippablefact@1.5.23
"

inherit desktop dotnet-pkg linux-info systemd udev xdg

DESCRIPTION="A cross-platform open-source tablet driver"
HOMEPAGE="https://opentabletdriver.net/"
SRC_URI="
	https://github.com/OpenTabletDriver/OpenTabletDriver/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${NUGET_URIS}
"

LICENSE="LGPL-3+"
# nuget licenses
LICENSE+=" Apache-2.0 ISC MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/libevdev
	virtual/udev
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/libnotify
	!x11-drivers/OpenTabletDriver-bin
"
BDEPEND="app-misc/jq"

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
	./generate-rules.sh > 70-opentabletdriver.rules || die
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

	cd "${S}/eng/bash/Generic/usr" || die
	insinto /lib/modprobe.d
	doins lib/modprobe.d/99-opentabletdriver.conf
	insinto /usr/lib/modules-load.d
	doins lib/modules-load.d/opentabletdriver.conf
	insinto /usr/share/libinput
	doins share/libinput/30-vendor-opentabletdriver.quirks
	systemd_douserunit lib/systemd/user/opentabletdriver.service
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
