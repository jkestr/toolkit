module HeaderHelper

  def page_title
    @page_title ||= "Hello World"
    return @page_title
  end
  #memoize :page_title

  # Creates and stores list of javascripts to be included to HTML pages.
  # Views may add scripts just as if this were an array itself.
  #
  # <%= javascripts << "one_line_css_converter.js" %>
  # <%= javascripts.reject! { |r| r == "something_incompatable*.js" }
  #
  # TODO Should this be read only? For additional scripts to be included
  # by the application.js, so they are only loaded when and if they are 
  # needed?
  def javascripts
    @javascripts ||= Array.new()
    return @javascripts
  end
  #memoize :javascripts

  # HTML to include javascripts
  # *BE REAL* and use at the _bottom_ of <body>!
  # TODO don't do crazy development caching techniques on jquery.
  def include_javascript
    return javascript_include_tag javascripts()
  end

  # Creates and stores list of stylesheets to be included to HTML pages.
  def stylesheets
    @stylesheets ||= Array.new()
    return @stylesheets
  end
  #memoize :stylesheets

  # HTML to include the stylesheets
  # For now we're loading blueprint via hardcoded tags in the template,
  # which is a complete 540 from what we're doing with javascripts.
  # It sure would save us from dealing with caching if we hardcoded the
  # scripts. On the other hand, we'll always want blueprint around, but
  # we might not always want to stick with jQuery.
  # TODO iff we include blueprint here, we shouldn't cache in dev env
  def link_stylesheets
    return stylesheet_link_tag stylesheets()
  end

  # Creates and stores list of metatags to be included to HTML pages.
  # I insert the content-type in the html first thing, and include
  # the meta tags later. You might want to add it as a default here
  # if aren't going to do that.
  def meta_tags
    @meta_tags ||= {}
    return @meta_tags
  end
  #memoize :meta_tags

  # This feels a little silly, creating meta tags with ActionPack
  # here and using content_type() for HAMLs header.
  # But I really don't think people should have an option of anything
  # other then UTF-8, and "SEO" meta tags should go after the biggies. 
  def meta_tags_html
    meta_tags.map { |meta|
      content = m[1].is_a(Array) ? m[1].join(", ") : m[1] 
      tag(:meta, "http-equiv" => m[0], "content" => content) 
    }
  end
  
end
