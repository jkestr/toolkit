begin
  require 'lorem'
rescue
end

module ToolkitHelper

  # HTML attributes we also need
  def html_attrs(lang = 'en-US')
    return {
      :lang => lang,
      "xml:lang" => lang,
      :xmlns => "http://www.w3.org/1999/xhtml"
    }
  end

  # Just your lil-olde content type
  def content_type()
    return {
      'http-equiv' => 'Content-Type',
      'content' => 'text/html;charset=UTF-8'
    }
  end
  
  # Generate an abbreviation tag.
  # TODO How to make this pretty yet lightweight?
  #
  # # Constants
  # abbr(:uri)
  #   <abbr title="Universal Resource Identifier">URI</abbr>
  #
  # abbr(:url)
  #   <abbr title="Universal Resource Locator">URL</abbr>
  #
  # # Macros
  # abbr(Date.today, "%b, %Y")
  #   <abbr title="2009-01-26">Jan 2009</abbr>
  #
  # abbr(DateTime.now, "%h:%M %p")
  #   <abbr title="2009-01-26T21:00+0500'>9:00 PM</abbr>
  #
  # # Tag helper
  # abbr('display', 'mouse over')
  #   <abbr title='mouse over'>display</abbr>
  #
  def abbr(*args)
    if args.length == 1 && args[0].is_a?(Symbol)
      case args[0]
      when :uri 
        content_tag(:abbr, "URI", 
                           :title => "Universal Resource Identifier")
      when :url
        content_tag(:abbr, "URL",
                           :title => "Universal Resource Locator")
      when :llc
        content_tag(:abbr, "LLC",
                           :title => "Limited Liability Corporation")
      end
    elsif args.length == 2
      if args[0].is_a?(Date)
        content_tag(:abbr, args[0].to_s(args[1]), 
                           :title => args[0].to_s(:utc))
      else  
        content_tag(:abbr, args[0], :title => args[1])
      end
    end
  end

  def page_title
    @page_title ||= "Hello World"
    return @page_title
  end
  #memoize :page_title

  # Creates and stores list of javascripts to be included to HTML pages.
  def javascripts
    @javascripts ||= %w{jquery.min.js jquery-ui.min.js application.js}
    return @javascripts
  end
  #memoize :javascripts

  # HTML to include javascripts
  # *BE REAL* and use at the _bottom_ of <body>
  def include_javascript
    return javascript_include_tag javascripts()
  end

  # Creates and stores list of stylesheets to be included to HTML pages.
  def stylesheets
    @stylesheets ||= %w{layout theme}
    return @stylesheets
  end
  #memoize :stylesheets

  # HTML to include the stylesheets
  def link_stylesheets
    return stylesheet_link_tag stylesheets()
  end

  # Creates and stores list of metatags to be included to HTML pages.
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

  # Returns a transparent gif.
  # size:: passed to image_tag, defaults to '1x1'
  # options:: passed on to image_tag
  def nil_image(size = '1x1', options = {})
    options.reverse_merge!(:size => size)
    return image_tag('nil.gif', options)
  end

  # Generates a lorem ipsum string
  # length:: number of words to generate
  def jibberish(length = 50)
    return Lorem::Base.new('words', length).output
  rescue
    return ""
  end

  # Returns time_ago_in_words for a random time
  # max_minutes:: maximum number of minutes back allowed
  def rand_time_ago_in_words(max_minutes = 640)
    time_ago_in_words(Time.now - rand(max_minutes) << " ago"
  end

  # Flip words for your easter eggs.
  # --
  # I found this online.... somehwere
  # ++
  module Flip 
   $KCODE = "u"
   MAP = Hash.new{|h,k| k}

   {  'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghiklmnopqrstuvwxyz' => 
      '∀ᗺↃᗡƎℲ⅁HIᒋʞ⅂ƜNOdԾᖈS⊥ႶΛMX⅄Zɐqɔpǝɟɓɥᴉʞ│ɯuodbɹsʇnʌʍxʎz',
      '123456890~!@$%^&*()_+{}:|<>?"#`[],./-=\\' =>
      '|ᘔᗴhᔕ9860~¡Ꭷ$%⋁⅋*)(‾+}{:|><¿„#ˎ][‘˙/-=\\'
   }.each {|from,to| from.split(//).zip(to.split(//)).each {|f,t| MAP[f]=t }}
   MAP.merge!("'"=>',', '7'=>'/̲', 'j'=>'⌠̣', ';'=>':́')

   def self.flip(text)
      MAP.values_at(*text.split(//).reverse).join
   end

  end

end
