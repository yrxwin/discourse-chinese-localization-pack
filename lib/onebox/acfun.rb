module Onebox
  module Engine
    class AcfunOnebox
      include Engine
      include HTML

      matches_regexp(/^(https?:\/\/)?([\da-z\.-]+)(acfun.tv\/)v\/(.)+\/?$/)

      # Try to get the video ID. Works for URLs of the form:
      # * http://www.acfun.tv/v/ac2650705
      def video_id
        match = uri.path.match(/\/v\/ac([a-zA-Z0-9_=\-]+)(\.html)?.*/)
        return match[1] if match && match[1]

        nil
      rescue
        return nil
      end

      def to_html
        "<object type='application/x-shockwave-flash' allowfullscreeninteractive='true' allowfullscreen='true' allowscriptaccess='always' data='flash/player-view-homura.swf?salt=1433413523775' width='1726' height='985' id='ACFlashPlayer-re' style='visibility: visible;'><param name='allowFullscreenInteractive' value='true'><param name='allowfullscreen' value='true'><param name='allowscriptaccess' value='always'><param name='flashvars' value='vid=#{video_id}&amp;videoId=#{video_id}&amp;width=1726&amp;height=985&amp;fs=0&amp;autoplay=0&amp;host=http://www.acfun.tv&amp;avatar=&amp;hint=小贴士：播放器会自动记录你的每一次操作。&amp;oldcs=1&amp;allowFullscreenInteractive=true&amp;allowfullscreen=true&amp;allowscriptaccess=always'></object>"
      end

      def placeholder_html
        to_html
      end

      private

      # Note: May throw! Make sure to rescue.
      def uri
        @_uri ||= URI(@url)
      end

    end
  end
end
