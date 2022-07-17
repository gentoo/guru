# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A self-hosted live video and web chat server"
HOMEPAGE="https://owncast.online/ https://github.com/owncast/owncast"

LICENSE="MIT Apache-2.0 ISC BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/owncast
	acct-group/owncast
	media-video/ffmpeg"

SRC_URI="https://github.com/owncast/owncast/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/owncast/owncast/releases/download/v${PV}/${P}-linux-64bit.zip
	https://www.lysator.liu.se/~creideiki/owncast-0.0.12-deps.tar.xz"

PATCHES=(
	"${FILESDIR}/${P}-1758-remove-websocket-origin-check.patch"
)

src_unpack() {
	go-module_src_unpack

	# go-module_src_unpack unpacked both the source and the binary
	# package. This places the binary package files in the wrong
	# place, but that's hopefully survivable. We need the binary
	# package to get the minified CSS file, which is generated using
	# NPM by upstream.
	cp "${WORKDIR}"/webroot/js/web_modules/tailwindcss/dist/tailwind.min.css "${S}"/webroot/js/web_modules/tailwindcss/dist/tailwind.min.css || die
}

src_compile() {
	go build -v -work -x \
	   -ldflags "-s -w -X github.com/${PN}/${PN}/config.VersionNumber=${PV} -X github.com/${PN}/${PN}/config.BuildPlatform=gentoo" \
	   -o ${PN} \
	   github.com/${PN}/${PN} || die
}

src_install() {
	dobin ${PN}

	dodoc README.md

	newinitd "${FILESDIR}"/${PN}.initd ${PN}

	diropts -m 0755 -o owncast -g owncast
	insopts -m 0644 -o owncast -g owncast

	insinto /var/lib/${PN}
	doins -r static webroot
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]] ; then
		einfo "The admin interface at http://localhost:8080/admin/"
		einfo "has default username 'admin' and password 'abc123'."
	fi

	einfo "Hardware accelerated transcoding requires support in media-video/ffmpeg, see https://owncast.online/docs/codecs/"
}
