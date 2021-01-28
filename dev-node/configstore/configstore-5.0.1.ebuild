# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Easily load and save config without having to think about where and how"
HOMEPAGE="
	https://github.com/yeoman/configstore
	https://www.npmjs.com/package/configstore
"

LICENSE="BSD-2"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/dot-prop
	dev-node/graceful-fs
	dev-node/make-dir
	dev-node/unique-string
	dev-node/write-file-atomic
	dev-node/xdg-basedir
"
