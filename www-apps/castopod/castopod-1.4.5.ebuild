# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature webapp

UPLOAD_HASH="50c9b05f5267aa48c562539182d9ffd1"
DESCRIPTION="Open-source hosting platform made for podcasters"
HOMEPAGE="
	https://castopod.org
	https://code.castopod.org/adaures/castopod
"
SRC_URI="https://code.castopod.org/adaures/${PN}/uploads/${UPLOAD_HASH}/${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="AGPL-3+ Apache-2.0 BSD-2 BSD GPL-1+ GPL-2 GPL-2+ GPL-3 LGPL-3 MIT MPL-2.0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-lang/php-8.1[curl,exif,gd,intl,mysqli,unicode,webp,xml]
	virtual/httpd-php
"

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_serverowned -R "${MY_HTDOCSDIR}"/writable
	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst

	optfeature "better cache perfomance" dev-db/redis
	optfeature "video clips support" media-video/ffmpeg
}
