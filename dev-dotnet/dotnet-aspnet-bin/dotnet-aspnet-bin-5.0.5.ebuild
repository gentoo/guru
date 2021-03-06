# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION=".NET ASP.NET Runtime Store"
HOMEPAGE="https://dotnet.microsoft.com/"
SRC_URI="
	amd64? ( https://dotnetcli.azureedge.net/dotnet/aspnetcore/Runtime/${PV}/aspnetcore-runtime-${PV}-linux-x64.tar.gz )
	arm? ( https://dotnetcli.azureedge.net/dotnet/aspnetcore/Runtime/${PV}/aspnetcore-runtime-${PV}-linux-arm.tar.gz )
	arm64? ( https://dotnetcli.azureedge.net/dotnet/aspnetcore/Runtime/${PV}/aspnetcore-runtime-${PV}-linux-arm64.tar.gz )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

# The SDK includes dotnet-aspnet-bin so prevent installing the SDK at the same time
RDEPEND="
	app-crypt/mit-krb5
	~dev-dotnet/dotnet-runtime-bin-${PV}
	!dev-dotnet/dotnet-sdk-bin
	!dev-dotnet/dotnet-sdk-bin-common
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

src_install() {
	insinto /opt/dotnet/shared/
	doins -r "${S}/shared/Microsoft.AspNetCore.App"
}
