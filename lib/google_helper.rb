module GoogleHelper
  
  def g_api_jquery(version='1.4.2')
    g_api_base_uri + 'jquery/#{version}/jquery.min.js'
  end
  
  def g_api_jquery_ui(version='1.8.1')
    g_api_base_uri + 'jqueryui/#{version}/jquery-ui.min.js'
  end
  
  def g_analytics(key)
    %Q{
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', '#{key}']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(ga);
      })();
    }
  end
  
  def g_api_base_uri
    'http://ajax.googleapis.com/ajax/libs/'
  end

end
