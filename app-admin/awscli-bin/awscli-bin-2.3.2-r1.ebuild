# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Universal Command Line Interface for Amazon Web Services version 2"
HOMEPAGE="https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html"
SRC_URI="https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${PV}.zip -> ${P}.zip"

LICENSE="Apache-2.0 MIT LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="!app-admin/awscli"
BDEPEND="app-arch/unzip"

S="${WORKDIR}/aws"

src_install() {
	./install --install-dir "${D}/opt/awscli" --bin-dir "${D}/usr/bin" \
		|| die "install failed"
}
