# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="VLC video output plugin for niftyled LED hardware"
HOMEPAGE="http://wiki.niftylight.de/niftyled-vlc"
# remove git:// style URI to avoid security warnings
EGIT_REPO_URI="https://github.com/niftylight/niftyled-vlc.git"
#EGIT_COMMIT="master"
#EGIT_BRANCH="${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug"

DOCS=( NEWS README.md AUTHORS ChangeLog )

RDEPEND="media-gfx/niftyled
	media-video/vlc"

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

src_install()
{
	emake DESTDIR="${D}" install
	einstalldocs
}
