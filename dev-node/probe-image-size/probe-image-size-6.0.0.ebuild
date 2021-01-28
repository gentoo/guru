# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get image size without full download (JPG, GIF, PNG, WebP, BMP, TIFF, PSD)"
HOMEPAGE="
	https://github.com/nodeca/probe-image-size
	https://www.npmjs.com/package/probe-image-size
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/deepmerge
	dev-node/needle
	dev-node/stream-parser
"
