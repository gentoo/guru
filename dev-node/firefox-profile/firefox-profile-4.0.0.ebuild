# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="firefox profile for selenium WebDriverJs, admc/wd or any other node selenium driver that supports capabilities"
HOMEPAGE="
	https://github.com/saadtazi/firefox-profile-js
	https://www.npmjs.com/package/firefox-profile
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/adm-zip
	dev-node/archiver
	dev-node/async
	dev-node/fs-extra
	dev-node/ini
	dev-node/jetpack-id
	dev-node/lazystream
	dev-node/lodash
	dev-node/minimist
	dev-node/uuid
	dev-node/xml2js
"
