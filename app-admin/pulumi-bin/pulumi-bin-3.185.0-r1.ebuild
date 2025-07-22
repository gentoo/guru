# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Infrastructure as code in any programming language"
HOMEPAGE="
	https://www.pulumi.com/
	https://github.com/pulumi/pulumi
"
SRC_URI="
	amd64? ( https://github.com/pulumi/pulumi/releases/download/v${PV}/pulumi-v${PV}-linux-x64.tar.gz )
"

S="${WORKDIR}/pulumi"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="*"

src_install() {
	dobin pulumi*
}
