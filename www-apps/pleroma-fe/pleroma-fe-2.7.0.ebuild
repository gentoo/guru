# Copyright 2023 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Main frontend for www-apps/pleroma, inspired by qvitter"
HOMEPAGE="https://pleroma.social/ https://git.pleroma.social/pleroma/pleroma-fe"
if [[ "${PV}" == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.pleroma.social/pleroma/pleroma-fe"
else
	SRC_URI="https://git.pleroma.social/pleroma/pleroma-fe/-/archive/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi
LICENSE="AGPL-3 MIT ISC Apache-2.0"
SLOT="0"

# Requires network access (https) as long as NPM dependencies aren't packaged
# said dependencies have their checksum verified via `yarn.lock`
RESTRICT="network-sandbox"

BDEPEND="
	net-libs/nodejs
	sys-apps/yarn
"

src_unpack() {
	default

	[[ "${PV}" == *9999 ]] && git-r3_src_unpack

	cd "${S}" || die
	yarn install --no-bin-links --frozen-lockfile --non-interactive || die
}

# FIXME src_prepare: Point to the correct source repo, needed for AGPL compliance

src_compile() {
	yarn run build || die
}

src_install() {
	insinto "/opt/pleroma-fe"
	doins -r dist
}

pkg_postinst() {
	elog 'You will need to add the following line in /etc/pleroma/config.exs to make use of this frontend:'
	elog 'config :pleroma, :frontends, primary: %{"name" => "pleroma-fe", "ref" => "gentoo"}'
}
