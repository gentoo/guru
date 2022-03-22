# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Universal Command Line Interface for Amazon Web Services version 2"
HOMEPAGE="https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html"
SRC_URI="
	amd64? ( https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${PV}.zip )
	arm64? ( https://awscli.amazonaws.com/awscli-exe-linux-aarch64-${PV}.zip )
"

LICENSE="Apache-2.0"
SLOT="0"

KEYWORDS="~amd64 ~arm64"

RDEPEND="!app-admin/awscli"
BDEPEND="app-arch/unzip"

QA_PREBUILT="*"
QA_PRESTRIPPED="*"

S="${WORKDIR}/aws"

DOCS=( THIRD_PARTY_LICENSES )

src_install() {
	./install --install-dir "${D}/opt/awscli" --bin-dir "${D}/usr/bin" \
		|| die "install failed"

	einstalldocs
}
