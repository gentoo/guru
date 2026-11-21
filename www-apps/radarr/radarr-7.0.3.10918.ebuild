# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT="10.0"
NUGET_APIS=(
	"https://api.nuget.org/v3-flatcontainer"
	"https://pkgs.dev.azure.com/Servarr/Servarr/_packaging/dotnet-bsd-crossbuild/nuget/v3/flat2"
	"https://pkgs.dev.azure.com/Servarr/Servarr/_packaging/Mono.Posix.NETStandard/nuget/v3/flat2"
	"https://pkgs.dev.azure.com/Servarr/Servarr/_packaging/FFMpegCore/nuget/v3/flat2"
)
NUGETS="
bouncycastle.cryptography@2.7.0
castle.core@5.1.1
coverlet.collector@10.1.0
dapper@2.1.89
diacritical.net@1.0.5
dryioc.dll@5.4.0
dryioc.dll@5.4.3
dryioc.microsoft.dependencyinjection@6.2.0
dynamitey@3.0.3
equ@2.3.0
fluentassertions@7.2.2
fluentmigrator.abstractions@8.0.1
fluentmigrator.extensions.postgres@8.0.1
fluentmigrator.runner.core@8.0.1
fluentmigrator.runner.postgres@8.0.1
fluentmigrator.runner.sqlite@8.0.1
fluentmigrator@8.0.1
fluentvalidation@9.5.4
ical.net@5.2.4
impromptuinterface@8.1.0
instances@3.1.0
ipaddressrange@6.3.0
mailkit@4.18.2
microsoft.applicationinsights@2.23.0
microsoft.aspnetcore.authentication.openidconnect@10.0.15
microsoft.aspnetcore.cryptography.internal@10.0.15
microsoft.aspnetcore.cryptography.keyderivation@10.0.15
microsoft.bcl.cryptography@10.0.2
microsoft.codecoverage@18.11.1
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
microsoft.extensions.logging@8.0.0
microsoft.extensions.options.configurationextensions@10.0.15
microsoft.extensions.options@10.0.15
microsoft.extensions.options@8.0.0
microsoft.extensions.primitives@10.0.15
microsoft.extensions.primitives@8.0.0
microsoft.identitymodel.abstractions@8.19.2
microsoft.identitymodel.jsonwebtokens@8.19.2
microsoft.identitymodel.logging@8.19.2
microsoft.identitymodel.protocols.openidconnect@8.19.2
microsoft.identitymodel.protocols@8.19.2
microsoft.identitymodel.tokens@8.19.2
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
moq@4.18.4
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
nodatime@3.2.2
npgsql@10.0.3
nunit3testadapter@6.3.1
nunit@4.6.1
nunitxml.testlogger@8.1.0
openur.ffmpegcore@6.0.0.60
openur.ffprobestatic@9.0.2.508
openur.mono.unix@7.1.0.256
polly.contrib.waitandretry@1.1.1
polly.core@8.9.1
polly@8.9.1
restsharp@106.15.0
reusabletasks@4.0.0
sentry@5.16.3
sharpziplib@1.4.2
sixlabors.imagesharp@3.1.12
sourcegear.sqlite3@3.53.4
stylecop.analyzers.unstable@1.2.0.556
swashbuckle.aspnetcore.annotations@10.3.1
swashbuckle.aspnetcore.swagger@10.3.1
swashbuckle.aspnetcore.swaggergen@10.3.1
system.componentmodel.annotations@5.0.0
system.configuration.configurationmanager@6.0.0
system.data.sqlite@2.0.4
system.diagnostics.eventlog@10.0.15
system.diagnostics.eventlog@6.0.0
system.drawing.common@6.0.0
system.identitymodel.tokens.jwt@8.19.2
system.io.filesystem.accesscontrol@5.0.0
system.security.cryptography.pkcs@10.0.13
system.security.cryptography.pkcs@10.0.15
system.security.cryptography.protecteddata@6.0.0
system.security.permissions@6.0.0
system.serviceprocess.servicecontroller@10.0.15
system.valuetuple@4.6.1
system.valuetuple@4.6.2
system.windows.extensions@6.0.0
"

inherit dotnet-pkg systemd

DESCRIPTION="Movie organizer/manager for usenet and torrent users"
HOMEPAGE="https://radarr.video"
SRC_URI="
	https://github.com/Radarr/Radarr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
	${NUGET_URIS}
"

S="${WORKDIR}/Radarr-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

DOTNET_PKG_PROJECTS=( "src/Radarr.sln" )
DOTNET_PKG_BAD_PROJECTS=(
	"src/NzbDrone.Automation.Test/Radarr.Automation.Test.csproj"
	"src/NzbDrone.Host.Test/Radarr.Host.Test.csproj"
	"src/NzbDrone.Integration.Test/Radarr.Integration.Test.csproj"
	"src/NzbDrone.Update.Test/Radarr.Update.Test.csproj"
	"src/NzbDrone.Update/Radarr.Update.csproj"
	"src/NzbDrone.Windows.Test/Radarr.Windows.Test.csproj"
	"src/NzbDrone.Windows/Radarr.Windows.csproj"
	"src/ServiceHelpers/ServiceInstall/ServiceInstall.csproj"
	"src/ServiceHelpers/ServiceUninstall/ServiceUninstall.csproj"
	"src/WindowsServiceHelpers"
)

RDEPEND="
	acct-group/radarr
	acct-user/radarr
	dev-db/sqlite
	media-video/mediainfo
"
DEPEND="
	!!www-apps/radarr-bin
"
BDEPEND="
	sys-apps/yarn
"

PATCHES=(
	"${FILESDIR}/${PN}-6.1.1.10317-look-up-package_info-in-the-startup-folder.patch"
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
	chmod 755 "${DOTNET_PKG_OUTPUT}/ffprobe" || die

	yarn run build --env production --no-stats || die
	cp -r "${S}/_output/UI" "${DOTNET_PKG_OUTPUT}" || die
}

src_test() {
	filters=(
		'FullyQualifiedName!=NzbDrone.Common.Test.ServiceFactoryFixture.event_handlers_should_be_unique'
		'FullyQualifiedName!~NzbDrone.Common.Test.Http.HttpClientFixture<ManagedHttpDispatcher>'
		'FullyQualifiedName!~NzbDrone.Core.Test.MetadataSource.SkyHook.SkyHookProxySearchFixture.no_search_result'
	)

	dotnet-pkg-base_test "${DOTNET_PKG_PROJECTS[0]}" \
		--filter "$(IFS='&'; echo "${filters[*]}")"
}

src_install() {
	dotnet-pkg_src_install

	# This disables the update feature
	insinto "/usr/share/${P}"
	echo "PackageVersion=${PV}" | cat "${FILESDIR}/package_info" - > package_info
	doins "package_info"

	systemd_newunit "${FILESDIR}/radarr.service" "radarr.service"
}
