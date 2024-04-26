# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="CUSTOMRESCUECD-x86"
DESCRIPTION="A system rescue cd or usbstick for desktop and server based on gentoo"
HOMEPAGE="https://sourceforge.net/projects/customrescuecd/"
SRC_URI="mirror://sourceforge/customrescuecd/"${MY_P}"-"${PV}".iso"

S=${WORKDIR}

LICENSE="GPL-3"
SLOT="${PV}"
KEYWORDS="~x86"
RESTRICT="bindist mirror"

src_unpack() { :; }

src_install() {
	insinto "/usr/share/${PN%-*}"
	doins "${DISTDIR}/${MY_P}-${PV}.iso"
}

pkg_postinst() {
	local f=${EROOT}/usr/share/${PN%-*}/${PN}-newest.iso

	# no version newer than ours? we're the newest!
	if ! has_version ">${CATEGORY}/${PF}"; then
		ln -f -s -v "${MY_P}-${PV}.iso" "${f}" || die
	fi
}

pkg_postrm() {
	local f=${EROOT}/usr/share/${PN%-*}/${PN}-newest.iso

	# if there is no version newer than ours installed
	if ! has_version ">${CATEGORY}/${PF}"; then
		# and we are truly and completely uninstalled...
		if [[ ! ${REPLACED_BY_VERSION} ]]; then
			# then find an older version to set the symlink to
			local newest_version=$(best_version "<${CATEGORY}/${PF}")

			if [[ ${newest_version} ]]; then
				# update the symlink
				ln -f -s -v "${newest_version%-r*}.iso" "${f}" || die
			else
				# last version removed? clean up the symlink
				rm -v "${f}" || die
				# and the parent directory
				rmdir "${f%/*}" || die
			fi
		fi
	fi
}
