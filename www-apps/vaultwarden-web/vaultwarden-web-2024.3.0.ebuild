# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )

inherit check-reqs python-any-r1

DESCRIPTION="Bitwarden web vault patched to make it work with Vaultwarden"
HOMEPAGE="https://github.com/dani-garcia/bw_web_builds"

BW_CLIENTS_COMMIT="dbf0f1e"
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
	${PYTHON_DEPS}
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

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare() {
	default

	# mimicking the behaviour of https://github.com/dani-garcia/bw_web_builds/blob/master/scripts/apply_patches.sh
	function replace_embedded_svg_icon() {
		if [ ! -f $1 ]; then echo "$1 does not exist"; exit -1; fi
		if [ ! -f $2 ]; then echo "$2 does not exist"; exit -1; fi

		echo "'$1' -> '$2'"

		first='`$'
		last='^`'
		sed -i "/$first/,/$last/{ /$first/{p; r $1
}; /$last/p; d }" $2
	}

	local PATCH_FILE
	if [[ -f "../bw_web_builds-${PV}/patches/v${PV%b}.patch" ]]; then
		einfo "Exact patch file found, using that"
		PATCH_FILE="../bw_web_builds-${PV}/patches/v${PV%b}.patch"
	else
		einfo "No exact patch file not found, using latest"
		PATCH_FILE="../bw_web_builds-${PV}/patches/$(find ../bw_web_builds-${PV}/patches -type f -print0 | xargs -0 basename -a | sort -V | tail -n1)" || die
	fi

	cp -vfR ../bw_web_builds*/resources/src/* ./apps/web/src/ || die
	replace_embedded_svg_icon \
		../bw_web_builds-"${PV}"/resources/vaultwarden-admin-console-logo.svg \
		./apps/web/src/app/admin-console/icons/admin-console-logo.ts || die
	replace_embedded_svg_icon \
		../bw_web_builds-"${PV}"/resources/vaultwarden-password-manager-logo.svg \
		./apps/web/src/app/layouts/password-manager-logo.ts || die

	eapply "${PATCH_FILE}"
}

src_compile() {
	# mimicking https://contributing.bitwarden.com/getting-started/clients/
	export \
		npm_config_cache="${WORKDIR}"/npm-cache \
		npm_config_nodedir="${EPREFIX}"/usr \
		NODE_GYP_FORCE_PYTHON="${PYTHON}" \
		ELECTRON_SKIP_BINARY_DOWNLOAD=1 \
		|| die
	npm --verbose --offline clean-install || die

	# mimicking the behaviour of https://github.com/dani-garcia/bw_web_builds/blob/master/scripts/build_web_vault.sh
	pushd apps/web || die
	npm --verbose --offline run dist:oss:selfhost && printf '{"version":"%s"}' "${PV}" | tee build/vw-version.json \
			|| die "Build failed! Try prebuilt from upstream ${CATEGORY}/${PN}-bin"
	# although following is optional in upstream's build process, it reduced build dir size from 44M to 25M
	find build -name "*.map" -delete || die
	popd || die
}

src_install() {
	insinto /usr/share/webapps/"${PN}"
	doins -r apps/web/build/*
}
