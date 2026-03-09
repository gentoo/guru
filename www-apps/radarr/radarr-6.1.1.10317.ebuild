# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT="8.0"
NUGET_APIS=(
	"https://api.nuget.org/v3-flatcontainer"
	"https://pkgs.dev.azure.com/Servarr/Servarr/_packaging/dotnet-bsd-crossbuild/nuget/v3/flat2"
	"https://pkgs.dev.azure.com/Servarr/Servarr/_packaging/Mono.Posix.NETStandard/nuget/v3/flat2"
	"https://pkgs.dev.azure.com/Servarr/Servarr/_packaging/FFMpegCore/nuget/v3/flat2"
)
NUGETS="
azure.core@1.47.1
azure.identity@1.14.2
bouncycastle.cryptography@2.5.1
castle.core@5.1.1
coverlet.collector@6.0.4
dapper@2.1.66
diacritical.net@1.0.4
dryioc.dll@5.4.3
dryioc.microsoft.dependencyinjection@6.2.0
dynamitey@3.0.3
equ@2.3.0
fluentassertions@6.12.1
fluentmigrator.abstractions@6.2.0
fluentmigrator.extensions.postgres@6.2.0
fluentmigrator.runner.core@6.2.0
fluentmigrator.runner.postgres@6.2.0
fluentmigrator.runner.sqlite@6.2.0
fluentmigrator@6.2.0
fluentvalidation@9.5.4
ical.net@4.3.1
impromptuinterface@8.0.6
instances@1.6.1
ipaddressrange@6.2.0
mailkit@4.13.0
microsoft.applicationinsights@2.23.0
microsoft.aspnetcore.cryptography.internal@8.0.17
microsoft.aspnetcore.cryptography.keyderivation@8.0.17
microsoft.bcl.asyncinterfaces@8.0.0
microsoft.bcl.cryptography@8.0.0
microsoft.codecoverage@17.10.0
microsoft.csharp@4.7.0
microsoft.data.sqlclient.sni.runtime@6.0.2
microsoft.data.sqlclient@6.1.1
microsoft.extensions.caching.abstractions@8.0.0
microsoft.extensions.caching.memory@8.0.1
microsoft.extensions.configuration.abstractions@8.0.0
microsoft.extensions.configuration.binder@8.0.2
microsoft.extensions.configuration.commandline@8.0.0
microsoft.extensions.configuration.environmentvariables@8.0.0
microsoft.extensions.configuration.fileextensions@8.0.1
microsoft.extensions.configuration.json@8.0.1
microsoft.extensions.configuration.usersecrets@8.0.1
microsoft.extensions.configuration@8.0.0
microsoft.extensions.dependencyinjection.abstractions@7.0.0
microsoft.extensions.dependencyinjection.abstractions@8.0.0
microsoft.extensions.dependencyinjection.abstractions@8.0.2
microsoft.extensions.dependencyinjection@8.0.1
microsoft.extensions.diagnostics.abstractions@8.0.1
microsoft.extensions.diagnostics@8.0.1
microsoft.extensions.fileproviders.abstractions@8.0.0
microsoft.extensions.fileproviders.physical@8.0.0
microsoft.extensions.filesystemglobbing@8.0.0
microsoft.extensions.hosting.abstractions@8.0.1
microsoft.extensions.hosting.windowsservices@8.0.1
microsoft.extensions.hosting@8.0.1
microsoft.extensions.logging.abstractions@8.0.0
microsoft.extensions.logging.abstractions@8.0.2
microsoft.extensions.logging.abstractions@8.0.3
microsoft.extensions.logging.configuration@8.0.1
microsoft.extensions.logging.console@8.0.1
microsoft.extensions.logging.debug@8.0.1
microsoft.extensions.logging.eventlog@8.0.1
microsoft.extensions.logging.eventsource@8.0.1
microsoft.extensions.logging@8.0.0
microsoft.extensions.logging@8.0.1
microsoft.extensions.options.configurationextensions@8.0.0
microsoft.extensions.options@8.0.0
microsoft.extensions.options@8.0.2
microsoft.extensions.primitives@8.0.0
microsoft.identity.client.extensions.msal@4.73.1
microsoft.identity.client@4.73.1
microsoft.identitymodel.abstractions@6.35.0
microsoft.identitymodel.abstractions@7.7.1
microsoft.identitymodel.jsonwebtokens@7.7.1
microsoft.identitymodel.logging@7.7.1
microsoft.identitymodel.protocols.openidconnect@7.7.1
microsoft.identitymodel.protocols@7.7.1
microsoft.identitymodel.tokens@7.7.1
microsoft.net.test.sdk@17.10.0
microsoft.netcore.platforms@1.1.0
microsoft.netcore.platforms@5.0.0
microsoft.netcore.targets@1.1.0
microsoft.openapi@1.6.23
microsoft.sqlserver.server@1.0.0
microsoft.testing.extensions.telemetry@1.7.3
microsoft.testing.extensions.trxreport.abstractions@1.7.3
microsoft.testing.extensions.vstestbridge@1.7.3
microsoft.testing.platform.msbuild@1.7.3
microsoft.testing.platform@1.7.3
microsoft.testplatform.adapterutilities@17.13.0
microsoft.testplatform.objectmodel@17.10.0
microsoft.testplatform.objectmodel@17.13.0
microsoft.testplatform.testhost@17.10.0
microsoft.win32.primitives@4.3.0
microsoft.win32.systemevents@8.0.0
mimekit@4.13.0
mono.nat@3.0.0
mono.posix.netstandard@5.20.1.34-servarr20
monotorrent@3.0.2
moq@4.18.4
nbuilder@6.1.0
netstandard.library@1.6.1
netstandard.library@2.0.0
newtonsoft.json@13.0.1
newtonsoft.json@13.0.3
nlog.extensions.logging@5.4.0
nlog.layouts.clefjsonlayout@1.0.3
nlog.targets.syslog@7.0.0
nlog@5.4.0
nodatime@3.2.0
npgsql@9.0.3
nunit3testadapter@5.1.0
nunit@3.14.0
nunitxml.testlogger@3.1.20
polly.contrib.waitandretry@1.1.1
polly.core@8.6.0
polly@8.6.0
restsharp@106.15.0
reusabletasks@4.0.0
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
sentry@4.0.2
servarr.ffmpegcore@4.7.0-26
servarr.ffprobe@5.1.4.112
sharpziplib@1.4.2
sixlabors.imagesharp@3.1.11
sourcegear.sqlite3@3.50.4.2
stylecop.analyzers@1.1.118
swashbuckle.aspnetcore.annotations@8.1.4
swashbuckle.aspnetcore.swagger@8.1.4
swashbuckle.aspnetcore.swaggergen@8.1.4
system.appcontext@4.3.0
system.buffers@4.3.0
system.clientmodel@1.5.1
system.collections.concurrent@4.3.0
system.collections@4.3.0
system.componentmodel.annotations@5.0.0
system.componentmodel@4.3.0
system.configuration.configurationmanager@4.4.0
system.configuration.configurationmanager@8.0.1
system.console@4.3.0
system.data.sqlite@2.0.2
system.diagnostics.debug@4.3.0
system.diagnostics.diagnosticsource@4.3.0
system.diagnostics.diagnosticsource@5.0.0
system.diagnostics.diagnosticsource@6.0.1
system.diagnostics.eventlog@6.0.0
system.diagnostics.eventlog@8.0.1
system.diagnostics.tools@4.3.0
system.diagnostics.tracing@4.3.0
system.drawing.common@8.0.20
system.formats.asn1@8.0.1
system.globalization.calendars@4.3.0
system.globalization.extensions@4.3.0
system.globalization@4.3.0
system.identitymodel.tokens.jwt@7.7.1
system.io.compression.zipfile@4.3.0
system.io.compression@4.3.0
system.io.filesystem.accesscontrol@5.0.0
system.io.filesystem.primitives@4.3.0
system.io.filesystem@4.3.0
system.io@4.3.0
system.linq.expressions@4.3.0
system.linq@4.3.0
system.memory.data@8.0.1
system.memory@4.6.3
system.net.http@4.3.0
system.net.nameresolution@4.3.0
system.net.primitives@4.3.0
system.net.sockets@4.3.0
system.objectmodel@4.3.0
system.private.uri@4.3.0
system.reflection.emit.ilgeneration@4.3.0
system.reflection.emit.lightweight@4.3.0
system.reflection.emit@4.3.0
system.reflection.emit@4.7.0
system.reflection.extensions@4.3.0
system.reflection.metadata@1.6.0
system.reflection.primitives@4.3.0
system.reflection.typeextensions@4.3.0
system.reflection@4.3.0
system.resources.resourcemanager@4.3.0
system.runtime.compilerservices.unsafe@6.0.0
system.runtime.extensions@4.3.0
system.runtime.handles@4.3.0
system.runtime.interopservices.runtimeinformation@4.3.0
system.runtime.interopservices@4.3.0
system.runtime.loader@4.3.0
system.runtime.numerics@4.3.0
system.runtime@4.3.0
system.security.accesscontrol@5.0.0
system.security.claims@4.3.0
system.security.cryptography.algorithms@4.3.0
system.security.cryptography.cng@4.3.0
system.security.cryptography.csp@4.3.0
system.security.cryptography.encoding@4.3.0
system.security.cryptography.openssl@4.3.0
system.security.cryptography.pkcs@8.0.1
system.security.cryptography.primitives@4.3.0
system.security.cryptography.protecteddata@4.4.0
system.security.cryptography.protecteddata@4.5.0
system.security.cryptography.protecteddata@8.0.0
system.security.cryptography.x509certificates@4.3.0
system.security.principal.windows@4.3.0
system.security.principal.windows@5.0.0
system.security.principal@4.3.0
system.serviceprocess.servicecontroller@8.0.1
system.text.encoding.codepages@8.0.0
system.text.encoding.extensions@4.3.0
system.text.encoding@4.3.0
system.text.json@8.0.5
system.text.regularexpressions@4.3.0
system.threading.tasks.extensions@4.3.0
system.threading.tasks@4.3.0
system.threading.threadpool@4.3.0
system.threading.timer@4.3.0
system.threading@4.3.0
system.valuetuple@4.5.0
system.valuetuple@4.6.1
system.xml.readerwriter@4.3.0
system.xml.xdocument@4.3.0
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
		'FullyQualifiedName!~NzbDrone.Common.Test.Http.HttpClientFixture<ManagedHttpDispatcher>.should_parse_malformed_cloudflare_cookie'
		'FullyQualifiedName!~NzbDrone.Common.Test.Http.HttpClientFixture<ManagedHttpDispatcher>.should_reject_malformed_domain_cookie'
		'FullyQualifiedName!~NzbDrone.Common.Test.Http.HttpClientFixture<ManagedHttpDispatcher>.should_send_headers'
	)

	dotnet-pkg-base_test "${DOTNET_PKG_PROJECTS[0]}" \
		--filter "$(IFS='&'; echo "${filters[*]}")"
}

src_install() {
	dotnet-pkg_src_install

	dodoc LICENSE

	# This disables the update feature
	insinto "/usr/share/${P}"
	echo "PackageVersion=${PV}" | cat "${FILESDIR}/package_info" - > package_info
	doins "package_info"

	systemd_newunit "${FILESDIR}/radarr.service" "radarr.service"
}
