# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="lightweight logging/debugging output lib for new or existing applications."
HOMEPAGE="http://wiki.niftylight.de/libniftylog"
# removed git:// style URI due to security warning
EGIT_REPO_URI="https://github.com/niftylight/niftylog.git"
#EGIT_COMMIT="master"
#EGIT_BRANCH="${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug static"

DOCS=( NEWS README.md AUTHORS ChangeLog )

RDEPEND=""
# we unconditionally build the documentation and don't have a configure option for it,
# so we need doxygen installed.
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare()
{
	default
	eautoreconf
}

src_unpack()
{
	git-r3_src_unpack
}

src_configure()
{
	econf \
	    $(use_enable debug) \
	    $(use_enable static)
}

src_compile()
{
	emake
}
