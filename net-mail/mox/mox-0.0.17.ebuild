# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="Modern, secure, all-in-on email server (binary package)"
HOMEPAGE="https://www.xmox.nl/"

SRC_URI="
	https://github.com/mjl-/mox/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="|| ( MIT MPL-2.0 )"
# bundled project licenses ( run `mox licenses` )
LICENSE+=" MIT BSD Apache-2.0 BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/mox
	acct-group/mox
"

BDEPEND="
	>=dev-lang/go-1.25.0
"

src_prepare() {
	default
	sed -i \
		-e 's/WorkingDirectory=\/home\/mox/WorkingDirectory=\/var\/lib\/mox/' \
		-e 's/ExecStart=\/home\/mox\/mox/ExecStart=\/usr\/bin\/mox/' \
		-e 's/ExecStop=\/home\/mox\/mox/ExecStop=\/usr\/bin\/mox/' \
		${PN}.service
}

DOCS=(
	README.md
)

src_compile() {
	ego build
}

src_test() {
	CGO_ENABLED=1 ego test -fullpath -shuffle=on -count 2 -covermode atomic -coverprofile cover.out ./...
}

src_install() {
	dobin ${PN}

	doinitd "${FILESDIR}"/${PN%-bin}
	systemd_dounit ${PN}.service
	newconfd "${FILESDIR}"/${PN%-bin}.confd ${PN%-bin}

	einstalldocs
}

pkg_postinst() {
	einfo "Run the mox quickstart to get started"
	einfo "# cd /var/lib/mox && mox quickstart you@yourdomain.com"
}
