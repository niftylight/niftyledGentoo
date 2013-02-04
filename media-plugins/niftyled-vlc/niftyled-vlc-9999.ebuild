# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit git-2 autotools

DESCRIPTION="VLC video output plugin for niftyled LED hardware"
HOMEPAGE="http://wiki.niftylight.de/niftyled-vlc"
EGIT_REPO_URI="git://github.com/niftylight/niftyled-vlc.git https://github.com/niftylight/niftyled-vlc.git"
#EGIT_COMMIT="master"
#EGIT_BRANCH="${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug"

RDEPEND="media-gfx/niftyled
	media-video/vlc"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare()
{
	eautoreconf
}

src_unpack()
{
	git-2_src_unpack
}

src_configure()
{
	econf \
	    $(use_enable debug)
}

src_install()
{
	emake DESTDIR="${D}" install || die

	dodoc NEWS README AUTHORS ChangeLog
}
