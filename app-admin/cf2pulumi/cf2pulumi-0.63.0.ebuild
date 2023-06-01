# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="CloudFormation tempate to Pulumi app convertor"
HOMEPAGE="
	https://www.pulumi.com/cf2pulumi/
	https://github.com/pulumi/pulumi-aws-native
"
SRC_URI="
	amd64? ( https://github.com/pulumi/pulumi-aws-native/releases/download/v${PV}/cf2pulumi-v${PV}-linux-x64.tar.gz )
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="*"

src_install() {
	dobin cf2pulumi
}
