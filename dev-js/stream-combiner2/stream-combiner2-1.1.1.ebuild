# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="This is a sequel to [stream-combiner](https://npmjs.org/package/stream-combiner) for streams3."
HOMEPAGE="
	https://github.com/substack/stream-combiner2
	https://www.npmjs.com/package/stream-combiner2
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/duplexer2
	dev-js/readable-stream
"
