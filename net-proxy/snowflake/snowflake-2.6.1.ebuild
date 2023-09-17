# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"

JOB_ID="363325"
DESCRIPTION="Pluggable Transport using WebRTC, inspired by Flashproxy"
HOMEPAGE="
	https://snowflake.torproject.org/
	https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/snowflake
"
SRC_URI="https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/${PN}/-/jobs/${JOB_ID}/artifacts/raw/${MY_P}.tar.gz"

LICENSE="Apache-2.0 BSD BSD-2 CC0-1.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

COMPONENTS=( broker client probetest proxy server )

src_compile() {
	for component in "${COMPONENTS[@]}"; do
		pushd ${component} || die
		einfo "Building ${component}"
		ego build
		popd || die
	done
}

src_test() {
	ego test ./...
}

src_install() {
	local component
	for component in "${COMPONENTS[@]}"; do
		newbin ${component}/${component} snowflake-${component}
		newdoc ${component}/README.md README_${component}.md
	done

	systemd_dounit "${FILESDIR}"/snowflake-proxy.service
	newinitd "${FILESDIR}"/snowflake-proxy.initd snowflake-proxy

	einstalldocs
	dodoc doc/*.txt doc/*.md
	doman doc/*.1
}
