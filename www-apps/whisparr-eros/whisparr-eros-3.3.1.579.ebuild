# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT="10.0"
NUGET_APIS=(
	"https://api.nuget.org/v3-flatcontainer"
	"https://pkgs.dev.azure.com/Servarr/Servarr/_packaging/dotnet-bsd-crossbuild/nuget/v3/flat2"
	"https://pkgs.dev.azure.com/Servarr/Servarr/_packaging/Mono.Posix.NETStandard/nuget/v3/flat2"
)
NUGETS="
azure.core@1.50.0
azure.identity@1.17.1
bouncycastle.cryptography@2.6.2
castle.core@5.1.1
coverlet.collector@8.0.0
dapper@2.1.72
diacritical.net@1.0.5
dryioc.dll@5.4.0
dryioc.dll@5.4.3
dryioc.microsoft.dependencyinjection@6.2.0
dynamitey@3.0.3
equ@2.3.0
fluentassertions@8.8.0
fluentmigrator.abstractions@8.0.1
fluentmigrator.extensions.postgres@8.0.1
fluentmigrator.runner.core@8.0.1
fluentmigrator.runner.postgres@8.0.1
fluentmigrator.runner.sqlite@8.0.1
fluentmigrator@8.0.1
fluentvalidation@12.1.1
fuzzysharp@2.0.2
githubactionstestlogger@3.0.1
ical.net@5.2.1
impromptuinterface@8.0.6
instances@3.0.2
ipaddressrange@6.3.0
mailkit@4.15.1
microsoft.applicationinsights@2.23.0
microsoft.aspnetcore.cryptography.internal@10.0.3
microsoft.aspnetcore.cryptography.keyderivation@10.0.3
microsoft.bcl.asyncinterfaces@8.0.0
microsoft.codecoverage@18.3.0
microsoft.data.sqlclient.sni.runtime@6.0.2
microsoft.data.sqlclient@6.1.4
microsoft.extensions.caching.abstractions@9.0.11
microsoft.extensions.caching.memory@9.0.11
microsoft.extensions.configuration.abstractions@10.0.0
microsoft.extensions.configuration.abstractions@10.0.3
microsoft.extensions.configuration.abstractions@8.0.0
microsoft.extensions.configuration.binder@10.0.3
microsoft.extensions.configuration.commandline@10.0.3
microsoft.extensions.configuration.environmentvariables@10.0.3
microsoft.extensions.configuration.fileextensions@10.0.3
microsoft.extensions.configuration.json@10.0.3
microsoft.extensions.configuration.usersecrets@10.0.3
microsoft.extensions.configuration@10.0.3
microsoft.extensions.dependencyinjection.abstractions@10.0.0
microsoft.extensions.dependencyinjection.abstractions@10.0.3
microsoft.extensions.dependencyinjection.abstractions@7.0.0
microsoft.extensions.dependencyinjection.abstractions@9.0.11
microsoft.extensions.dependencyinjection@10.0.0
microsoft.extensions.dependencyinjection@10.0.3
microsoft.extensions.dependencyinjection@8.0.0
microsoft.extensions.diagnostics.abstractions@10.0.3
microsoft.extensions.diagnostics@10.0.3
microsoft.extensions.fileproviders.abstractions@10.0.3
microsoft.extensions.fileproviders.physical@10.0.3
microsoft.extensions.filesystemglobbing@10.0.3
microsoft.extensions.hosting.abstractions@10.0.3
microsoft.extensions.hosting.windowsservices@10.0.3
microsoft.extensions.hosting@10.0.3
microsoft.extensions.logging.abstractions@10.0.0
microsoft.extensions.logging.abstractions@10.0.3
microsoft.extensions.logging.abstractions@8.0.3
microsoft.extensions.logging.abstractions@9.0.11
microsoft.extensions.logging.configuration@10.0.3
microsoft.extensions.logging.console@10.0.3
microsoft.extensions.logging.debug@10.0.3
microsoft.extensions.logging.eventlog@10.0.3
microsoft.extensions.logging.eventsource@10.0.3
microsoft.extensions.logging@10.0.0
microsoft.extensions.logging@10.0.3
microsoft.extensions.logging@8.0.0
microsoft.extensions.options.configurationextensions@10.0.3
microsoft.extensions.options@10.0.0
microsoft.extensions.options@10.0.3
microsoft.extensions.options@8.0.0
microsoft.extensions.options@9.0.11
microsoft.extensions.primitives@10.0.0
microsoft.extensions.primitives@10.0.3
microsoft.extensions.primitives@5.0.1
microsoft.extensions.primitives@9.0.11
microsoft.identity.client.extensions.msal@4.78.0
microsoft.identity.client@4.78.0
microsoft.identity.client@4.80.0
microsoft.identitymodel.abstractions@7.7.1
microsoft.identitymodel.abstractions@8.14.0
microsoft.identitymodel.jsonwebtokens@7.7.1
microsoft.identitymodel.logging@7.7.1
microsoft.identitymodel.protocols.openidconnect@7.7.1
microsoft.identitymodel.protocols@7.7.1
microsoft.identitymodel.tokens@7.7.1
microsoft.net.test.sdk@18.3.0
microsoft.netcore.platforms@1.1.0
microsoft.openapi@2.4.1
microsoft.sqlserver.server@1.0.0
microsoft.testing.extensions.telemetry@2.0.2
microsoft.testing.extensions.trxreport.abstractions@2.0.2
microsoft.testing.extensions.vstestbridge@2.0.2
microsoft.testing.platform.msbuild@2.0.2
microsoft.testing.platform@2.0.2
microsoft.testplatform.adapterutilities@18.0.1
microsoft.testplatform.objectmodel@18.0.1
microsoft.testplatform.objectmodel@18.3.0
microsoft.testplatform.testhost@18.3.0
microsoft.win32.systemevents@10.0.3
mimekit@4.15.1
mono.nat@3.0.0
mono.posix.netstandard@5.20.1.34-servarr24
monotorrent@3.0.2
moq@4.20.72
nbuilder@6.1.0
netstandard.library@1.6.1
newtonsoft.json@13.0.3
newtonsoft.json@13.0.4
nlog.extensions.logging@6.1.2
nlog.layouts.clefjsonlayout@1.0.5
nlog.targets.syslog@7.0.0
nlog@5.0.0
nlog@5.2.5
nlog@6.1.1
nodatime@3.2.2
npgsql@10.0.1
nunit3testadapter@6.1.0
nunit@4.5.1
nunitxml.testlogger@8.0.0
openur.ffmpegcore@5.4.0.31
openur.ffprobestatic@8.0.1.302
polly.contrib.waitandretry@1.1.1
polly.core@8.6.6
polly@8.6.6
restsharp@114.0.0
reusabletasks@4.0.0
semver@3.0.0
sentry@6.1.0
sharpziplib@1.4.2
sixlabors.imagesharp@3.1.12
sourcegear.sqlite3@3.50.4.5
stylecop.analyzers@1.1.118
swashbuckle.aspnetcore.annotations@10.1.4
swashbuckle.aspnetcore.swagger@10.1.4
swashbuckle.aspnetcore.swaggergen@10.1.4
swashbuckle.aspnetcore.swaggerui@10.1.4
system.clientmodel@1.8.0
system.componentmodel.annotations@5.0.0
system.configuration.configurationmanager@10.0.3
system.configuration.configurationmanager@9.0.11
system.data.sqlite@2.0.2
system.diagnostics.eventlog@10.0.3
system.diagnostics.eventlog@6.0.0
system.diagnostics.eventlog@9.0.11
system.drawing.common@10.0.3
system.identitymodel.tokens.jwt@7.7.1
system.io.filesystem.accesscontrol@5.0.0
system.memory.data@8.0.1
system.security.cryptography.pkcs@10.0.0
system.security.cryptography.pkcs@9.0.11
system.security.cryptography.protecteddata@10.0.3
system.security.cryptography.protecteddata@4.5.0
system.security.cryptography.protecteddata@9.0.11
system.serviceprocess.servicecontroller@10.0.3
system.valuetuple@4.6.1
system.valuetuple@4.6.2
"

inherit dotnet-pkg systemd

# Tag version
TV="$(ver_cut 1-3)-release.$(ver_cut 4)"

DESCRIPTION="Adult movie organizer/manager for usenet and torrent users"
HOMEPAGE="https://whisparr.com"
SRC_URI="
	https://github.com/Whisparr/Whisparr-Eros/archive/refs/tags/v${TV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${TV}/${PN}-${TV}-deps.tar.xz -> ${P}-deps.tar.gz
	${NUGET_URIS}
"

S="${WORKDIR}/Whisparr-Eros-${TV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

DOTNET_PKG_PROJECTS=( "src/Whisparr.sln" )
DOTNET_PKG_BAD_PROJECTS=(
	"src/NzbDrone.Automation.Test/Whisparr.Automation.Test.csproj"
	"src/NzbDrone.Host.Test/Whisparr.Host.Test.csproj"
	"src/NzbDrone.Integration.Test/Whisparr.Integration.Test.csproj"
	"src/NzbDrone.Windows.Test/Whisparr.Windows.Test.csproj"
	"src/NzbDrone.Windows/Whisparr.Windows.csproj"
	"src/ServiceHelpers/ServiceInstall/ServiceInstall.csproj"
	"src/ServiceHelpers/ServiceUninstall/ServiceUninstall.csproj"
	"src/WindowsServiceHelpers"
)

RDEPEND="
	acct-group/whisparr-eros
	acct-user/whisparr-eros
	dev-db/sqlite
	media-video/mediainfo
"
BDEPEND="
	sys-apps/yarn
"

PATCHES=(
	"${FILESDIR}/${PN}-3.3.1.579-look-up-package_info-in-the-startup-folder.patch"
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
		'FullyQualifiedName!~NzbDrone.Common.Test.Http.HttpClientFixture<ManagedHttpDispatcher>.should_parse_malformed_cloudflare_cookie'
		'FullyQualifiedName!~NzbDrone.Common.Test.Http.HttpClientFixture<ManagedHttpDispatcher>.should_reject_malformed_domain_cookie'
		'FullyQualifiedName!~NzbDrone.Common.Test.Http.HttpClientFixture<ManagedHttpDispatcher>.should_send_headers'
	)

	dotnet-pkg-base_test "${DOTNET_PKG_PROJECTS[0]}" \
		--filter "$(IFS='&'; echo "${filters[*]}")"
}

src_install() {
	dotnet-pkg-base_install
	dotnet-pkg-base_dolauncher "/usr/share/${P}/Whisparr" Whisparr-Eros
	dosym -r "/usr/bin/Whisparr-Eros" "/usr/bin/${PN}"

	einstalldocs
	dodoc LICENSE.md

	# This disables the update feature
	insinto "/usr/share/${P}"
	echo "PackageVersion=${PV}" | cat "${FILESDIR}/package_info" - > package_info
	doins "package_info"

	systemd_newunit "${FILESDIR}/whisparr-eros.service" "whisparr-eros.service"
}
