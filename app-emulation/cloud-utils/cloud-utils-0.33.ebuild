# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..13} )
inherit python-single-r1

DESCRIPTION="Useful set of utilities for interacting with a cloud."
HOMEPAGE="https://github.com/canonical/cloud-utils"
SRC_URI="https://github.com/canonical/cloud-utils/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# image-utils vs guest-utils is a distinction that does not actually exist
# upstream, but is rather one that arch linux makes. alpine goes even more
# fine-grained, creating a single package for each individual utility. I ain't
# maintaining all that, but I do think the distinction arch makes is worthwhile.
#
# The difference is this: is the tool something you would want to use within a
# cloud VM, or use outside of a cloud VM to manipulate your VM's disk image?
# This is useful, because the image manipulation scripts need qemu-img and
# cdrtools around, which you might not want to install onto a VM just to run
# something like `ec2metadata` or `growpart`
IUSE="+guest-utils +image-utils"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	|| ( guest-utils image-utils )
"

# cloud-utils also provides its own growpart, which is I think different from
# sys-fs/growpart.
RDEPEND="
	${PYTHON_DEPS}
	guest-utils? (
		!sys-fs/growpart
	)
	image-utils? (
		app-cdr/cdrtools
		app-emulation/qemu
		app-misc/ca-certificates
		net-misc/wget
		sys-apps/util-linux
		sys-fs/dosfstools
		sys-fs/e2fsprogs
		sys-fs/mtools
	)
"

PATCHES=(
	"${FILESDIR}"/use-mkisofs.patch
)

src_install() {
	# This package really is just a pile of scripts, with a simple Makefile that
	# installs them. We can implement the USE flags most easily by ignoring the
	# Makefile and installing the files ourselves.

	local wanted_bin=()
	local wanted_man=()

	if use 'guest-utils'; then
		wanted_bin+=(
			bin/ec2metadata
			bin/growpart
			bin/vcs-run
		)
		wanted_man+=(
			man/growpart.1
		)
	fi

	if use 'image-utils'; then
		wanted_bin+=(
			bin/cloud-localds
			bin/mount-image-callback
			bin/resize-part-image
			bin/write-mime-multipart
		)
		wanted_man+=(
			man/cloud-localds.1
			man/resize-part-image.1
			man/write-mime-multipart.1
		)
	fi

	dobin "${wanted_bin[@]}"
	doman "${wanted_man[@]}"
}
