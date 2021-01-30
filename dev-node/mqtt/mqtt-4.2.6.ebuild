# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A library for the MQTT protocol"
HOMEPAGE="
	https://github.com/mqttjs/MQTT.js
	https://www.npmjs.com/package/mqtt
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/commist
	dev-node/concat-stream
	dev-node/debug
	dev-node/help-me
	dev-node/inherits
	dev-node/minimist
	dev-node/mqtt-packet
	dev-node/pump
	dev-node/readable-stream
	dev-node/reinterval
	dev-node/split2
	dev-node/ws
	dev-node/xtend
"
