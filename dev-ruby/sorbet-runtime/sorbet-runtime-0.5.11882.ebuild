# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32 ruby33 ruby34"
inherit ruby-fakegem

DESCRIPTION="Sorbet's runtime static type checker component"
HOMEPAGE="https://sorbet.org/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# sorbet itself is a huge package, with a mix of c++ & ruby
# the tests defined in the main repo are for the full package and wouldn't
# make sense for this gem
RUBY_FAKEGEM_RECIPE_TEST="none"
