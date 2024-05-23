# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fuse for AWS S3 (Simple Storage Service), official"
HOMEPAGE="https://github.com/awslabs/mountpoint-s3"
SRC_URI="https://s3.amazonaws.com/mountpoint-s3-release/${PV}/x86_64/mount-s3-${PV}-x86_64.tar.gz"

S="${WORKDIR}"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD BSD-2 ISC MIT openssl Unicode-DFS-2016 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="sys-fs/fuse:0"

QA_PREBUILT="/usr/bin/${PN}"

src_install() {
	newbin "${S}/bin/mount-s3" ${PN}
}
