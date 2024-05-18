# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# To update icon cache
inherit xdg-utils

DESCRIPTION="A flat colorful design icon theme for linux desktops"
HOMEPAGE="https://github.com/vinceliuice/Qogir-icon-theme"
SRC_URI="https://github.com/vinceliuice/${PN}/archive/refs/tags/2020-11-22.tar.gz"

# Extract to a non-default name
S=${WORKDIR}/Qogir-icon-theme-2020-11-22

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# No binaries are installed so we don't need these portage features
RESTRICT="binchecks strip"

# Unsure about dependencies
DEPEND="${RDEPEND}"

src_prepare() {
	eapply_user

	# Don't install the ubuntu/manjaro variants
	sed -i 's:THEME_VARIANTS=.*:THEME_VARIANTS="":' \
		install.sh || die "Sed failed to remove theme variants!"

	# Install cursors to Gentoo's cursor location
	sed -i -e "/cp.*cursors/i mkdir -p \${CURSOR_DIR}/Qogir\${color}" \
		-e "s:\(cp.*cursors\"\).*:\1 \${CURSOR_DIR}/Qogir\${color}:" \
		install.sh || die "Sed failed changing cursor location!"

	# Use xdg-utils eclass instead
	sed -i -e "/gtk-update-icon-cache/d" \
		install.sh || die "Sed failed removing gtk-update-icon-cache call!"
}

src_install() {
	mkdir -p "${D}/usr/share/icons"
	CURSOR_DIR="${D}/usr/share/cursors/xorg-x11" "${S}"/install.sh -d "${D}/usr/share/icons"

	# Remove broken symlink to avoid QA warning
	rm "${D}/usr/share/icons/Qogir/scalable/apps/org.aegisub.Aegisub.svg"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
