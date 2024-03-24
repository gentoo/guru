# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Developer environments you can take with you, with Nix inside, live virtual envs"
HOMEPAGE="https://flox.dev"

SRC_URI="https://downloads.flox.dev/by-env/stable/deb/flox-${PV}.x86_64-linux.deb"

inherit unpacker

KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="strip binchecks bindist"

S="${WORKDIR}"

QA_PREBUILT="*"

src_prepare() {
	default

	echo ==========
	ls -lh
	echo ==========

	echo ========== etc ======
	ls -lh etc
	echo =====================

	echo ========== nix ======
	ls -lh nix
	echo =====================

	echo ========== usr ======
	ls -lh usr
	echo ==========

	tar xvJf usr/share/nix/nix.tar.xz --no-same-owner

	bin/nix \
	--extra-experimental-features nix-command \
	--option substitute false \
	copy --from usr/share/nix --all --no-check-sigs

# Now that Nix closure has been extracted, set path to prefer
# tools as provided in installation bundle.
export PATH=/nix/store/bblyj5b3ii8n6v4ra0nb37cmi3lf8rz9-coreutils-9.3/bin:/nix/store/ddkis1jjybv09d6y2xc0q94r87s3ndni-daemonize-1.7.8/bin:/nix/store/l974pi8a5yqjrjlzmg6apk0jwjv81yqw-findutils-4.9.0/bin:/nix/store/9c5qm297qnvwcf7j0gm01qrslbiqz8rs-gnused-4.9/bin:$PATH

}

src_install() {
	# Not dobin because dobin doing chmod -x (making not executable)
	cp -r nix "${ED}"
}

pkg_postinst() {
	einfo "TODO some quck start advice OR link to a documentation"
}
