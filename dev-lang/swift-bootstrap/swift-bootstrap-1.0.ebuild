# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A virtual package providing a base Swift to bootstrap future versions with."
HOMEPAGE="https://www.swift.org"

S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="5/10"
KEYWORDS="~amd64"

# `dev-lang/swift` BDEPENDS on either this package or `dev-lang/swift` itself. When any version of `dev-lang/swift` is
# installed, it will be preferred over this package; when no version of `dev-lang/swift` is installed, `emerge` will
# fall back to installing this.
#
# Because `dev-lang/swift` is versioned by SLOT, any updates to newer versions of Swift will record the current version
# in the @world set, leaving them around; this allows `swift-bootstrap` to eventually get cleaned up.
RDEPEND="dev-lang/swift:5/10"
