# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION=".NET SDK (includes runtime + aspnet)"
HOMEPAGE="https://dotnet.microsoft.com/"
SRC_URI="
	amd64? ( https://dotnetcli.azureedge.net/dotnet/Sdk/${PV}/dotnet-sdk-${PV}-linux-x64.tar.gz )
	arm? ( https://dotnetcli.azureedge.net/dotnet/Sdk/${PV}/dotnet-sdk-${PV}-linux-arm.tar.gz )
	arm64? ( https://dotnetcli.azureedge.net/dotnet/Sdk/${PV}/dotnet-sdk-${PV}-linux-arm64.tar.gz )
"

LICENSE="MIT"
SLOT="5.0"
KEYWORDS="~amd64 ~arm ~arm64"

# The SDK includes dotnet-runtime-bin and dotnet-aspnet-bin,
#  so prevent installing them at the same time
RDEPEND="
	app-crypt/mit-krb5
	!dev-dotnet/dotnet-aspnet-bin
	!dev-dotnet/dotnet-runtime-bin
	~dev-dotnet/dotnet-sdk-bin-common-${PV}
	dev-libs/icu
	dev-util/lldb
	dev-util/lttng-ust
	net-misc/curl
	sys-apps/lsb-release
	sys-devel/llvm
	sys-libs/zlib
	|| (
		dev-libs/openssl
		dev-libs/openssl-compat
	)
	|| (
		sys-libs/libunwind
		sys-libs/llvm-libunwind
	)
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

	# Skip the common files
	find . -maxdepth 1 -type f -exec rm -f {} \; || die
	rm -rf ./packs/NETStandard.Library.Ref || die
}

src_install() {
	insinto /opt/dotnet
	doins -r "${S}/."
}
