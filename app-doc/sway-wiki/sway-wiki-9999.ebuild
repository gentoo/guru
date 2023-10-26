# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Wiki of gui-wm/sway, rendered to HTML using kramdown-parser-gfm"
HOMEPAGE="https://github.com/swaywm/sway/wiki"
EGIT_REPO_URI="https://github.com/swaywm/sway.wiki.git"
LICENSE="MIT"
SLOT="0"
IUSE=""

BDEPEND="dev-ruby/kramdown-parser-gfm"

# Essentially everything but .git
DOCS="*.html *.md"

src_prepare() {
	default

	sed -i 's;https://github.com/swaywm/sway/wiki/;./;' *.md || die
}

src_compile() {
	for i in *.md; do
		kramdown -i GFM "$i" > "${i//.md}.html" || die
	done

	# FIXME: URLs are missing .html and so aren't properly referring to files
	# Let's avoid creating an index until this is fixed
	# ln -s Home.html index.html || die
}
