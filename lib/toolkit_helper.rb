module ToolkitHelper
  
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
        abbr('URI', 'Universal Resource Identifier')
      when :url
        abbr('URL', 'Universal Resource Locator')
      when :llc
        abbr('LLC', 'Limited Liability Corporation')
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

  # Returns a transparent gif.
  # size:: passed to image_tag, defaults to '1x1'
  # options:: passed on to image_tag
  def nilf(size = '1x1', options = {})
    options.reverse_merge!(:size => size)
    return image_tag('nil.gif', options)
  end

  # Returns time_ago_in_words for a random time.
  # max_minutes:: maximum number of minutes back allowed
  def rand_time_ago_in_words(max_minutes = 640)
    time_ago_in_words(Time.now - rand(max_minutes)) << " ago"
  end

end
