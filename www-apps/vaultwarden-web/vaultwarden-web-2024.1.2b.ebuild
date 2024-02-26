# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs

DESCRIPTION="Bitwarden web vault patched to make it work with Vaultwarden"
HOMEPAGE="https://github.com/dani-garcia/bw_web_builds"

BW_CLIENTS_COMMIT="a1a5c4b"
SRC_URI="
	https://github.com/bitwarden/clients/archive/refs/tags/web-v${PV%b}.tar.gz -> ${PN}-${PV%b}.tar.gz
	https://github.com/rahilarious/gentoo-distfiles/releases/download/bitwarden-clients-${BW_CLIENTS_COMMIT}/deps.tar.xz -> bitwarden-clients-${BW_CLIENTS_COMMIT}.tar.xz
	https://github.com/dani-garcia/bw_web_builds/archive/refs/tags/v${PV}.tar.gz -> ${P}-patches.tar.gz
"

S="${WORKDIR}/clients-web-v${PV%b}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="!www-apps/vaultwarden-web-bin"
BDEPEND="
	net-libs/nodejs[npm]
"

CHECKREQS_MEMORY=3G
CHECKREQS_DISK_BUILD=2G

pkg_pretend() {
	einfo ""
	einfo "#################################################"
	einfo "Prebuilt alternative to this package is available:"
	einfo "        ${CATEGORY}/${PN}-bin"
	einfo "#################################################"
	einfo ""
	check-reqs_pkg_pretend
}

src_prepare() {
	default

	# mimicking the behaviour of https://github.com/dani-garcia/bw_web_builds/blob/master/scripts/apply_patches.sh
	local PATCH_FILE
	if [[ -f "../bw_web_builds-${PV}/patches/v${PV%b}.patch" ]]; then
		einfo "Exact patch file found, using that"
		PATCH_FILE="../bw_web_builds-${PV}/patches/v${PV%b}.patch"
	else
		einfo "No exact patch file not found, using latest"
		PATCH_FILE="../bw_web_builds-${PV}/patches/$(find ../bw_web_builds-${PV}/patches -type f -print0 | xargs -0 basename -a | sort -V | tail -n1)" || die
	fi

	cp -vfR ../bw_web_builds*/resources/src/* ./apps/web/src/ || die
	eapply "${PATCH_FILE}"

	mv -v ../node_modules ./ || die
}

src_compile() {
	# mimicking the behaviour of https://github.com/dani-garcia/bw_web_builds/blob/master/scripts/build_web_vault.sh
	pushd apps/web
	npm --verbose --offline run dist:oss:selfhost && printf '{"version":"%s"}' "${PV}" | tee build/vw-version.json \
			|| die "Build failed! Try prebuilt from upstream ${CATEGORY}/${PN}-bin"
	# although following is optional in upstream's build process, it reduced build dir size from 44M to 25M
	find build -name "*.map" -delete || die
}

src_install() {
	insinto /usr/share/webapps/"${PN}"
	doins -r apps/web/build/*
}
