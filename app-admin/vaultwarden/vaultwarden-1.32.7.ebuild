# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# https://github.com/dani-garcia/vaultwarden/issues/4649
RUST_MAX_VER="1.83.0"

inherit cargo check-reqs readme.gentoo-r1 systemd tmpfiles

DESCRIPTION="Unofficial Bitwarden compatible password manager server written in Rust"
HOMEPAGE="https://github.com/dani-garcia/vaultwarden"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dani-garcia/vaultwarden.git"
else
	SRC_URI="
		https://github.com/dani-garcia/vaultwarden/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		https://jroy.ca/dist/${P}-vendor.tar.xz
		https://jroy.ca/dist/${P}-wiki.tar.xz -> ${P}-docs.tar.xz
	"
	KEYWORDS="~amd64"
fi

LICENSE="AGPL-3"
# Dependent crate licenses
LICENSE+=" 0BSD Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-3.0"

SLOT="0"
IUSE="cli mysql postgres +sqlite web"
REQUIRED_USE="|| ( mysql postgres sqlite )"

RDEPEND="
	acct-user/vaultwarden
	acct-group/vaultwarden
	dev-libs/openssl:=
	cli? ( || ( app-admin/bitwarden-cli app-admin/bitwarden-cli-bin  ) )
	mysql? ( dev-db/mysql-connector-c:= )
	postgres? ( dev-db/postgresql:* )
	sqlite? ( dev-db/sqlite:3 )
	web? ( || ( www-apps/vaultwarden-web www-apps/vaultwarden-web-bin  ) )
"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

QA_FLAGS_IGNORED="usr/bin/${PN}"
QA_PRESTRIPPED="usr/bin/${PN}"
ECARGO_VENDOR="${WORKDIR}/vendor"

PATCHES=(
	"${FILESDIR}"/vaultwarden-envfile-1.30.3.patch
)

CHECKREQS_MEMORY=3G
CHECKREQS_DISK_BUILD=2G

DOC_CONTENTS="\n
	Configuration file: /etc/${PN}.env\n
	Data directory: /var/lib/${PN}\n
	\n
	MySQL & PostgreSQL users must set DATABASE_URL in config\n
	\n
	Default server: http://0.0.0.0:8000\n
	Admin interface: http://0.0.0.0:8000/admin
"

pkg_setup() {
	check-reqs_pkg_setup
	rust_pkg_setup
}

src_unpack() {
	if [[ ${PV} == 9999* ]]; then
		# clone vaultwarden
		git-r3_src_unpack

		# clone vaultwarden.wiki
		EGIT_REPO_URI="https://github.com/dani-garcia/vaultwarden.wiki.git"
		EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}.wiki"
		git-r3_src_unpack

		cargo_live_src_unpack
	else
		cargo_src_unpack
		mkdir "${CARGO_HOME}/gentoo" || die
		ln -s "${WORKDIR}/vendor/"* "${CARGO_HOME}/gentoo/" || die
		sed -i "${ECARGO_HOME}/config.toml" \
			-e 's/work\/vendor/work\/cargo_home\/gentoo/' \
			-e '/source.crates-io/d' \
			-e '/replace-with = "gentoo"/d' \
			-e '/local-registry = "\/nonexistent"/d' \
			|| die
		cat "${WORKDIR}/vendor/vendor-config.toml" >> "${ECARGO_HOME}/config.toml" || die
	fi
}

src_prepare() {
	default
	use web && { sed -i -e 's|^WEB_VAULT_ENABLED=false|WEB_VAULT_ENABLED=true|g;' .env.template || die; }
}

src_configure() {
	local myfeatures=(
		$(usev sqlite)
		$(usev mysql)
		$(usev postgres postgresql )
	)
	cargo_src_configure
}

src_compile() {
	# https://github.com/dani-garcia/vaultwarden/blob/main/build.rs
	[[ ${PV} != 9999* ]] && export VW_VERSION="${PV}"
	cargo_src_compile --no-default-features
}

src_install() {
	dobin target/*/*/"${PN}"
	systemd_newunit "${FILESDIR}"/vaultwarden-1.30.3.service "${PN}".service
	newinitd "${FILESDIR}"/vaultwarden-1.30.3.initd "${PN}"
	newtmpfiles "${FILESDIR}"/vaultwarden-tmpfiles-1.30.3.conf "${PN}".conf
	insinto /etc
	newins .env.template "${PN}".env
	dosym -r /etc/"${PN}".env /etc/conf.d/"${PN}"
	keepdir /var/lib/"${PN}"

	readme.gentoo_create_doc
	einstalldocs
	dodoc -r ../"${PN}".wiki/*
}

pkg_postinst() {
	tmpfiles_process "${PN}".conf
	readme.gentoo_print_elog
}
