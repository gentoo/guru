# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

MY_P="${PN}-v${PV}"
JOB_ID="441747"
DESCRIPTION="Pluggable Transport using WebRTC, inspired by Flashproxy"
HOMEPAGE="
	https://snowflake.torproject.org/
	https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/snowflake
"
SRC_URI="https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/${PN}/-/jobs/${JOB_ID}/artifacts/raw/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0 BSD BSD-2 CC0-1.0 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( >=dev-lang/go-1.21 )"

src_configure() {
	COMPONENTS=(
		broker
		probetest
		proxy
	)

	if has_version -b ">=dev-lang/go-1.21"; then
		COMPONENTS+=(
			client
			server
		)
	else
		ewarn "The following components have been disabled:"
		ewarn "	client server"
		ewarn
		ewarn "You need >=dev-lang/go-1.21 to build them."
	fi
}

src_compile() {
	for component in "${COMPONENTS[@]}"; do
		pushd ${component} || die
		einfo "Building ${component}"
		nonfatal ego build || die "${component}: build failed"
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
