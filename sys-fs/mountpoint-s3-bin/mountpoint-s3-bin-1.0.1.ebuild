# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fuse for AWS S3 (Simple Storage Service), official"
HOMEPAGE="https://github.com/awslabs/mountpoint-s3"

SRC_URI="https://s3.amazonaws.com/mountpoint-s3-release/${PV}/x86_64/mount-s3-${PV}-x86_64.tar.gz"
KEYWORDS="~amd64"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="sys-fs/fuse:0"

S="${WORKDIR}"

QA_FLAGS_IGNORED="/usr/bin/${PN}"

src_install() {
	newbin "${S}/bin/mount-s3" ${PN}
}
