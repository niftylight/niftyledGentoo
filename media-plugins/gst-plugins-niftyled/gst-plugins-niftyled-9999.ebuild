# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit git-2 autotools

DESCRIPTION="gStreamer plugins for the niftyled suite"
HOMEPAGE="http://wiki.niftylight.de/gstreamer"
EGIT_REPO_URI="git://github.com/niftylight/niftyled-gstreamer.git https://github.com/niftylight/niftyled-gstreamer.git"
#EGIT_COMMIT="master"
#EGIT_BRANCH="${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"

IUSE="debug"

RDEPEND="media-gfx/niftyled
	>=media-libs/gstreamer-0.10.0
	>=media-libs/gst-plugins-base-0.10.0"

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

src_install() {
    emake DESTDIR="${D}" install || die

    dodoc NEWS README COPYING AUTHORS ChangeLog
}