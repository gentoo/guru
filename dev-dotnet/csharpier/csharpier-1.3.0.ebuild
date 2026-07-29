# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT="10.0"

NUGETS="
awesomeassertions@9.3.0
diffengine@7.3.0
emptyfiles@2.7.0
enumerableasyncprocessor@3.8.4
githubactionstestlogger@2.4.1
ini-parser-netstandard@2.5.3
libgit2sharp@0.31.0
libgit2sharp.nativebinaries@2.0.323
lovettsoftware.xmldiff@1.1.0
microsoft.bcl.asyncinterfaces@10.0.5
microsoft.codeanalysis.analyzers@5.3.0-2.25625.1
microsoft.codeanalysis.common@5.3.0
microsoft.codeanalysis.csharp@5.3.0
microsoft.codeanalysis.publicapianalyzers@4.14.0
microsoft.csharp@4.7.0
microsoft.diasymreader@2.0.0
microsoft.extensions.configuration@8.0.0
microsoft.extensions.configuration.abstractions@8.0.0
microsoft.extensions.configuration.binder@8.0.0
microsoft.extensions.configuration.binder@8.0.2
microsoft.extensions.dependencyinjection@9.0.10
microsoft.extensions.dependencyinjection.abstractions@8.0.0
microsoft.extensions.dependencyinjection.abstractions@8.0.2
microsoft.extensions.dependencyinjection.abstractions@9.0.10
microsoft.extensions.dependencymodel@6.0.2
microsoft.extensions.logging@9.0.10
microsoft.extensions.logging.abstractions@8.0.2
microsoft.extensions.logging.abstractions@9.0.10
microsoft.extensions.logging.configuration@8.0.1
microsoft.extensions.options@8.0.0
microsoft.extensions.options@8.0.2
microsoft.extensions.options@9.0.10
microsoft.extensions.options.configurationextensions@8.0.0
microsoft.extensions.primitives@8.0.0
microsoft.extensions.primitives@9.0.10
microsoft.netcore.platforms@1.1.0
microsoft.netcore.platforms@5.0.0
microsoft.netcore.platforms@5.0.1
microsoft.testing.extensions.codecoverage@18.1.0
microsoft.testing.extensions.trxreport@2.0.2
microsoft.testing.extensions.trxreport.abstractions@2.0.2
microsoft.testing.platform@2.0.0
microsoft.testing.platform@2.0.2
microsoft.testing.platform.msbuild@2.0.2
microsoft.testplatform.objectmodel@17.10.0
microsoft.win32.registry.accesscontrol@5.0.0
microsoft.win32.systemevents@5.0.0
microsoft.windows.compatibility@5.0.2
netstandard.library@2.0.3
nreco.logging.file@1.2.2
polysharp@1.15.0
runtime.linux-arm64.runtime.native.system.io.ports@5.0.0-rtm.20519.4
runtime.linux-arm.runtime.native.system.io.ports@5.0.0-rtm.20519.4
runtime.linux-x64.runtime.native.system.io.ports@5.0.0-rtm.20519.4
runtime.native.system.data.sqlclient.sni@4.7.0
runtime.native.system.io.ports@5.0.0
runtime.osx-x64.runtime.native.system.io.ports@5.0.0-rtm.20519.4
runtime.win-arm64.runtime.native.system.data.sqlclient.sni@4.4.0
runtime.win-x64.runtime.native.system.data.sqlclient.sni@4.4.0
runtime.win-x86.runtime.native.system.data.sqlclient.sni@4.4.0
scriban@7.0.3
strongnamer@0.2.5
system.buffers@4.5.1
system.buffers@4.6.0
system.buffers@4.6.1
system.codedom@5.0.0
system.collections.immutable@9.0.0
system.commandline@2.0.0-beta4.22272.1
system.componentmodel.composition@5.0.0
system.componentmodel.composition.registration@5.0.0
system.configuration.configurationmanager@5.0.0
system.data.datasetextensions@4.5.0
system.data.odbc@5.0.0
system.data.oledb@5.0.0
system.data.sqlclient@4.8.1
system.diagnostics.diagnosticsource@9.0.10
system.diagnostics.eventlog@5.0.0
system.diagnostics.eventlog@5.0.1
system.diagnostics.performancecounter@5.0.0
system.diagnostics.performancecounter@5.0.1
system.directoryservices@5.0.0
system.directoryservices.accountmanagement@5.0.0
system.directoryservices.protocols@5.0.0
system.drawing.common@5.0.0
system.io.abstractions@22.1.1
system.io.abstractions.testinghelpers@22.0.16
system.io.filesystem.accesscontrol@5.0.0
system.io.hashing@9.0.10
system.io.packaging@5.0.0
system.io.pipelines@10.0.5
system.io.ports@5.0.0
system.management@5.0.0
system.memory@4.5.4
system.memory@4.5.5
system.memory@4.6.0
system.memory@4.6.3
system.numerics.vectors@4.6.0
system.numerics.vectors@4.6.1
system.private.servicemodel@4.8.0
system.reflection.context@5.0.0
system.reflection.metadata@9.0.0
system.runtime.caching@5.0.0
system.runtime.compilerservices.unsafe@6.0.0
system.runtime.compilerservices.unsafe@6.1.0
system.runtime.compilerservices.unsafe@6.1.2
system.security.accesscontrol@5.0.0
system.security.cryptography.pkcs@5.0.0
system.security.cryptography.pkcs@5.0.1
system.security.cryptography.protecteddata@5.0.0
system.security.cryptography.xml@4.7.0
system.security.cryptography.xml@5.0.0
system.security.permissions@5.0.0
system.security.principal.windows@5.0.0
system.servicemodel.duplex@4.8.0
system.servicemodel.http@4.8.0
system.servicemodel.nettcp@4.8.0
system.servicemodel.primitives@4.8.0
system.servicemodel.security@4.8.0
system.servicemodel.syndication@5.0.0
system.serviceprocess.servicecontroller@5.0.0
system.speech@5.0.0
system.text.encoding.codepages@10.0.5
system.text.encodings.web@10.0.5
system.text.json@10.0.5
system.threading.tasks.extensions@4.6.0
system.threading.tasks.extensions@4.6.3
system.windows.extensions@5.0.0
testableio.system.io.abstractions@22.1.1
testableio.system.io.abstractions.testinghelpers@22.0.16
testableio.system.io.abstractions.wrappers@22.0.16
testableio.system.io.abstractions.wrappers@22.1.1
testably.abstractions.filesystem.interface@10.1.0
testably.abstractions.filesystem.interface@9.0.0
tunit@1.5.80
tunit.assertions@1.5.80
tunit.core@1.5.80
tunit.engine@1.5.80
yamldotnet@16.3.0
"

inherit check-reqs dotnet-pkg multiprocessing

DESCRIPTION="An opinionated code formatter for C#"
HOMEPAGE="https://csharpier.com/
	https://github.com/belav/csharpier/"
SRC_URI="https://github.com/belav/${PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.gh.tar.gz"
SRC_URI+=" ${NUGET_URIS} "

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DOTNET_PKG_PROJECTS=( "${S}/Src/CSharpier.Cli/CSharpier.Cli.csproj" )
TEST_PROJECT="${S}/Src/CSharpier.Tests/CSharpier.Tests.csproj"

DOTNET_PKG_BUILD_EXTRA_ARGS=( --framework "net${DOTNET_PKG_COMPAT}" )

CHECKREQS_DISK_BUILD="2G"

DOCS=( CHANGELOG.md README.md )

pkg_setup() {
	check-reqs_pkg_setup
	dotnet-pkg_pkg_setup
}

src_prepare() {
	dotnet-pkg_src_prepare
}

src_configure() {
	dotnet-pkg_src_configure

	if use test; then
		dotnet-pkg-base_restore "${TEST_PROJECT}"
	fi
}

src_test() {
	local jobs=$(get_makeopts_jobs)

	# CSharpier uses MTP to run tests
	# it fails with dotnet-pkg-base_test
	# so used edotnet run directly
	edotnet run --project "${TEST_PROJECT}" \
		--configuration Release \
		--no-restore \
		-- \
		--maximum-parallel-tests "${jobs}"
}

src_install() {
	dotnet-pkg-base_install
	dotnet-pkg-base_dolauncher "/usr/share/${P}/CSharpier" "${PN}"
	einstalldocs
}
