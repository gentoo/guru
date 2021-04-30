# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Common files shared between multiple slots of .NET"
HOMEPAGE="https://dotnet.microsoft.com/"
SRC_URI="
	amd64? ( https://dotnetcli.azureedge.net/dotnet/Sdk/${PV}/dotnet-sdk-${PV}-linux-x64.tar.gz )
	arm? ( https://dotnetcli.azureedge.net/dotnet/Sdk/${PV}/dotnet-sdk-${PV}-linux-arm.tar.gz )
	arm64? ( https://dotnetcli.azureedge.net/dotnet/Sdk/${PV}/dotnet-sdk-${PV}-linux-arm64.tar.gz )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

# The SDK includes dotnet-runtime-bin and dotnet-aspnet-bin,
#  so prevent installing them at the same time
RDEPEND="
	!dev-dotnet/dotnet-aspnet-bin
	!dev-dotnet/dotnet-runtime-bin
	~dev-dotnet/dotnet-sdk-bin-${PV}
"

QA_PREBUILT="*"

S="${WORKDIR}"

src_prepare() {
	# For current .NET versions, all the directories contain versioned files,
	# but the top-level files (the dotnet binary for example) are shared between versions,
	# and those are backward-compatible.
	# The exception from this above rule is packs/NETStandard.Library.Ref which is shared between >=3.0 versions.
	# These common files are installed by the non-slotted dev-dotnet/dotnet-sdk-bin-common
	# package, while the directories are installed by dev-dotnet/dotnet-sdk-bin which uses
	# slots depending on major .NET version.
	# This makes it possible to install multiple major versions at the same time.
	default

	# Skip the versioned files (which are located inside sub-directories)
	find . -maxdepth 1 -type d ! -name . ! -name packs -exec rm -rf {} \; || die
	find ./packs -maxdepth 1 -type d ! -name packs ! -name NETStandard.Library.Ref -exec rm -rf {} \; || die
}

src_install() {
	insinto /opt/dotnet
	doins -r "${S}/."
	dosym ../../opt/dotnet/dotnet /usr/bin/dotnet
	fperms +x /usr/bin/dotnet
	doenvd "${FILESDIR}/80dotnet"
}
