# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="niftyled setup configuration GUI"
HOMEPAGE="http://wiki.niftylight.de/niftyconf"
# removed git:// style URI due to security issues
EGIT_REPO_URI="https://github.com/niftylight/niftyconf.git"
#EGIT_COMMIT="master"
#EGIT_BRANCH="${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug"

DOCS=( NEWS README.md AUTHORS ChangeLog )

RDEPEND="media-gfx/niftyled
	 x11-libs/gtk+:2
	 x11-libs/cairo
	 dev-libs/glib"

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
		$(use_enable debug)
}
