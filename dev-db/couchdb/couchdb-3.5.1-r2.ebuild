# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Document-oriented NoSQL database"
HOMEPAGE="https://couchdb.apache.org"
SRC_URI="https://apache.org/dist/${PN}/source/${PV}/apache-${PN}-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/apache-${PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
QA_PREBUILT="
	/usr/lib/${PN}/lib/**/*
	/usr/lib/${PN}/erts-*/bin/*
"

RDEPEND="
	>=dev-libs/openssl-3.5.6
	>=dev-libs/icu-78.3
	>=sys-libs/ncurses-6.5_p20251220
	>=virtual/zlib-1.3.1
	acct-user/couchdb
	acct-group/couchdb
"

DEPEND="${RDEPEND}"

BDEPEND="
	${RDEPEND}
	>=dev-lang/erlang-28.1
"

src_prepare() {
	# Change CouchDB's data directory to /var/lib/couchdb
	sed -i 's|./data|/var/lib/couchdb|' "${S}"/configure || die
	eapply_user
}

src_configure() {
	econf \
		--js-engine=quickjs \
		--disable-spidermonkey
}

src_compile() {
	emake release
}

src_install() {
	# CouchDB doesn't provide a helpful `make install`, so we have to manually copy
	# most things over to ${D}
	mkdir -p "${D}"/usr/lib/${PN} "${D}"/etc/${PN} || die
	cp -vr "${S}"/rel/${PN} "${D}"/usr/lib/ || die
	mv -v "${D}"/usr/lib/${PN}/etc/{default.ini,local.ini,vm.args} "${D}"/etc/${PN}/ || die

	# Scope ownership of CouchDB directories to the couchdb user
	fowners -R couchdb:couchdb /usr/lib/${PN}
	fowners -R couchdb:couchdb /etc/${PN}
	find "${D}"/usr/lib/${PN} -type d -exec chmod 0770 {} \;
	fperms 0644 /etc/${PN}/*

	# Install scripts
	newinitd "${FILESDIR}"/couchdb-init.d couchdb
	newconfd "${FILESDIR}"/couchdb-conf.d couchdb

	# Remove some cruft
	rm -vr "${D}"/usr/lib/${PN}/erts-*/{doc,include,lib,man,src} || die
	rm -vr "${D}"/usr/lib/${PN}/etc/ || die
	rm -vr "${D}"/usr/lib/${PN}/lib/couch-${PV}/priv/couch_{ejson_compare,js} || die
}
