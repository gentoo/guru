# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Parse and generate MQTT packets like a breeze"
HOMEPAGE="
	https://github.com/mqttjs/mqtt-packet
	https://www.npmjs.com/package/mqtt-packet
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/bl
	dev-node/debug
	dev-node/process-nextick-args
"
