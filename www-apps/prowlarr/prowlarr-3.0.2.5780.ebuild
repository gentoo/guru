# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT="10.0"
NUGET_APIS=(
	"https://api.nuget.org/v3-flatcontainer"
	"https://pkgs.dev.azure.com/Servarr/Servarr/_packaging/dotnet-bsd-crossbuild/nuget/v3/flat2"
	"https://pkgs.dev.azure.com/Servarr/Servarr/_packaging/FluentMigrator/nuget/v3/flat2"
	"https://pkgs.dev.azure.com/Servarr/Servarr/_packaging/Mono.Posix.NETStandard/nuget/v3/flat2"
)
NUGETS="
anglesharp.xml@1.3.0
anglesharp@1.10.1
anglesharp@1.9.0
benchmarkdotnet.annotations@0.15.8
benchmarkdotnet@0.15.8
bouncycastle.cryptography@2.7.0
castle.core@4.4.1
commandlineparser@2.9.1
coverlet.collector@10.1.0
dapper@2.1.89
diacritical.net@1.0.5
dryioc.dll@5.4.0
dryioc.dll@5.4.3
dryioc.microsoft.dependencyinjection@6.2.0
dynamitey@3.0.3
fluentassertions@7.2.2
fluentmigrator.abstractions@8.0.1
fluentmigrator.extensions.postgres@8.0.1
fluentmigrator.runner.core@8.0.1
fluentmigrator.runner.postgres@8.0.1
fluentmigrator.runner.sqlite@8.0.1
fluentmigrator@8.0.1
fluentvalidation@9.5.4
gee.external.capstone@2.3.0
iced@1.21.0
impromptuinterface@8.1.0
ipaddressrange@6.3.0
mailkit@4.18.2
microsoft.applicationinsights@2.23.0
microsoft.aspnetcore.cryptography.internal@10.0.15
microsoft.aspnetcore.cryptography.keyderivation@10.0.15
microsoft.aspnetcore.webutilities@10.0.15
microsoft.bcl.asyncinterfaces@1.1.0
microsoft.codeanalysis.analyzers@3.11.0
microsoft.codeanalysis.common@4.14.0
microsoft.codeanalysis.csharp@4.14.0
microsoft.codecoverage@18.11.1
microsoft.diagnostics.netcore.client@0.2.410101
microsoft.diagnostics.netcore.client@0.2.510501
microsoft.diagnostics.runtime@3.1.512801
microsoft.diagnostics.tracing.traceevent@3.1.21
microsoft.dotnet.platformabstractions@3.1.6
microsoft.extensions.configuration.abstractions@10.0.15
microsoft.extensions.configuration.abstractions@8.0.0
microsoft.extensions.configuration.binder@10.0.15
microsoft.extensions.configuration.commandline@10.0.15
microsoft.extensions.configuration.environmentvariables@10.0.15
microsoft.extensions.configuration.fileextensions@10.0.15
microsoft.extensions.configuration.json@10.0.15
microsoft.extensions.configuration.usersecrets@10.0.15
microsoft.extensions.configuration@10.0.15
microsoft.extensions.dependencyinjection.abstractions@10.0.0
microsoft.extensions.dependencyinjection.abstractions@10.0.15
microsoft.extensions.dependencyinjection.abstractions@7.0.0
microsoft.extensions.dependencyinjection.abstractions@8.0.0
microsoft.extensions.dependencyinjection@10.0.15
microsoft.extensions.dependencyinjection@8.0.0
microsoft.extensions.dependencymodel@8.0.2
microsoft.extensions.diagnostics.abstractions@10.0.15
microsoft.extensions.diagnostics@10.0.15
microsoft.extensions.fileproviders.abstractions@10.0.15
microsoft.extensions.fileproviders.physical@10.0.15
microsoft.extensions.filesystemglobbing@10.0.15
microsoft.extensions.hosting.abstractions@10.0.15
microsoft.extensions.hosting.windowsservices@10.0.15
microsoft.extensions.hosting@10.0.15
microsoft.extensions.logging.abstractions@10.0.0
microsoft.extensions.logging.abstractions@10.0.15
microsoft.extensions.logging.abstractions@8.0.0
microsoft.extensions.logging.configuration@10.0.15
microsoft.extensions.logging.console@10.0.15
microsoft.extensions.logging.debug@10.0.15
microsoft.extensions.logging.eventlog@10.0.15
microsoft.extensions.logging.eventsource@10.0.15
microsoft.extensions.logging@10.0.15
microsoft.extensions.logging@2.1.1
microsoft.extensions.logging@6.0.0
microsoft.extensions.logging@8.0.0
microsoft.extensions.options.configurationextensions@10.0.15
microsoft.extensions.options@10.0.15
microsoft.extensions.options@8.0.0
microsoft.extensions.primitives@10.0.15
microsoft.extensions.primitives@8.0.0
microsoft.net.http.headers@10.0.15
microsoft.net.test.sdk@18.11.1
microsoft.netcore.platforms@1.1.0
microsoft.openapi@2.7.5
microsoft.testing.extensions.telemetry@2.4.1
microsoft.testing.extensions.trxreport.abstractions@2.4.1
microsoft.testing.extensions.vstestbridge@2.4.1
microsoft.testing.platform.msbuild@2.4.1
microsoft.testing.platform@2.4.1
microsoft.testplatform.adapterutilities@18.10.1
microsoft.testplatform.objectmodel@18.11.1
microsoft.testplatform.objectmodel@18.9.0
microsoft.testplatform.testhost@18.11.1
microsoft.win32.systemevents@6.0.0
mimekit@4.18.2
mono.nat@3.0.0
monotorrent@3.0.2
moq@4.17.2
nbuilder@6.1.0
netstandard.library@1.6.1
newtonsoft.json@13.0.4
nlog.extensions.logging@5.5.0
nlog.layouts.clefjsonlayout@1.0.5
nlog.targets.syslog@7.0.0
nlog@5.0.0
nlog@5.2.5
nlog@5.5.0
nlog@5.5.1
npgsql@10.0.3
nunit3testadapter@6.3.1
nunit@4.6.1
nunitxml.testlogger@8.1.0
openur.mono.unix@7.1.0.256
perfolizer@0.6.1
polly.contrib.waitandretry@1.1.1
polly.core@8.9.1
polly@8.9.1
pragmastat@3.2.4
restsharp.serializers.systemtextjson@106.15.0
restsharp@106.15.0
reusabletasks@4.0.0
sentry@5.16.3
sharpziplib@1.4.2
sourcegear.sqlite3@3.53.4
stylecop.analyzers.unstable@1.2.0.556
swashbuckle.aspnetcore.swagger@10.3.1
swashbuckle.aspnetcore.swaggergen@10.3.1
system.codedom@9.0.5
system.componentmodel.annotations@5.0.0
system.configuration.configurationmanager@6.0.0
system.data.sqlite@2.0.4
system.diagnostics.eventlog@10.0.15
system.drawing.common@6.0.0
system.io.filesystem.accesscontrol@5.0.0
system.management@9.0.5
system.reflection.typeextensions@4.7.0
system.security.cryptography.pkcs@10.0.13
system.security.cryptography.pkcs@10.0.15
system.security.cryptography.protecteddata@6.0.0
system.security.permissions@6.0.0
system.serviceprocess.servicecontroller@10.0.15
system.valuetuple@4.6.1
system.valuetuple@4.6.2
system.windows.extensions@6.0.0
yamldotnet@18.1.0
"

inherit dotnet-pkg systemd

DESCRIPTION="An indexer manager/proxy to integrate with your various PVR apps"
HOMEPAGE="https://prowlarr.com"
SRC_URI="
	https://github.com/Prowlarr/Prowlarr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
	${NUGET_URIS}
"

S="${WORKDIR}/Prowlarr-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

DOTNET_PKG_PROJECTS=( "src/Prowlarr.sln" )
DOTNET_PKG_BAD_PROJECTS=(
	"src/NzbDrone.Automation.Test/Prowlarr.Automation.Test.csproj"
	"src/NzbDrone.Host.Test/Prowlarr.Host.Test.csproj"
	"src/NzbDrone.Integration.Test/Prowlarr.Integration.Test.csproj"
	"src/NzbDrone.Update.Test/Prowlarr.Update.Test.csproj"
	"src/NzbDrone.Update/Prowlarr.Update.csproj"
	"src/NzbDrone.Windows.Test/Prowlarr.Windows.Test.csproj"
	"src/NzbDrone.Windows/Prowlarr.Windows.csproj"
	"src/ServiceHelpers/ServiceInstall/ServiceInstall.csproj"
	"src/ServiceHelpers/ServiceUninstall/ServiceUninstall.csproj"
	"src/WindowsServiceHelpers"
)

RDEPEND="
	acct-group/prowlarr
	acct-user/prowlarr
	dev-db/sqlite
"
DEPEND="
	!!www-apps/prowlarr-bin
"
BDEPEND="
	sys-apps/yarn
"

PATCHES=(
	"${FILESDIR}/${PN}-2.3.3.5296-look-up-package_info-in-the-startup-folder.patch"
)

pkg_setup() {
	dotnet-pkg_pkg_setup

	export DOTNET_PKG_BUILD_EXTRA_ARGS=(
		-p:"AssemblyConfiguration=develop"
		-p:"AssemblyVersion=${PV}"
		-p:"RuntimeIdentifiers=${DOTNET_PKG_RUNTIME}"
		-p:"SentryUploadSymbols=false"
		-t:"PublishAllRids"
	)
}

src_prepare() {
	dotnet-pkg_src_prepare
	dotnet-pkg_remove-bad "${DOTNET_PKG_PROJECTS[0]}"
}

src_compile() {
	dotnet-pkg_src_compile

	yarn run build --env production --no-stats || die
	cp -r "${S}/_output/UI" "${DOTNET_PKG_OUTPUT}" || die
}

src_test() {
	filters=(
		'FullyQualifiedName!=NzbDrone.Common.Test.ServiceFactoryFixture.event_handlers_should_be_unique'
		'FullyQualifiedName!~NzbDrone.Common.Test.Http.HttpClientFixture<ManagedHttpDispatcher>'
		'FullyQualifiedName!~NzbDrone.Core.Test.UpdateTests.UpdatePackageProviderFixture'
	)

	dotnet-pkg-base_test "${DOTNET_PKG_PROJECTS[0]}" \
		--filter "$(IFS='&'; echo "${filters[*]}")"
}

src_install() {
	dotnet-pkg_src_install

	rm -f "${ED}/usr/share/${P}/libmsalruntime.so" || die

	# This disables the update feature
	insinto "/usr/share/${P}"
	echo "PackageVersion=${PV}" | cat "${FILESDIR}/package_info" - > package_info
	doins "package_info"

	systemd_newunit "${FILESDIR}/prowlarr.service" "prowlarr.service"
}
