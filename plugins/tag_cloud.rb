# encoding: utf-8
# Based on https://gist.github.com/1577100 
# Syntax:
# -------
#     <div class='cloud'>
#         {% tag_cloud %}
#     </div>
#
#     {% category_list [counter:true] %}
# 
# Example:
# --------
# In some template files, you can add the following markups.
# 
# ### source/_includes/custom/asides/category_list.html ###
# 
#     <section>
#       <h1>Categories</h1>
#         <ul id="category-list">{% category_list counter:true %}</ul>
#     </section>
# 
# Notes:
# ------
# Be sure to insert above template files into `default_asides` array in `_config.yml`.
# And also you can define styles for 'category-list' in a `.scss` file.
# (ex: `sass/custom/_styles.scss`)
#
# 合并了两大tag_cloud插件

require 'stringex'

module Jekyll

  class TagCloud < Liquid::Tag
    safe = true

    # tag cloud variables - these are setup in 'initialize'
    attr_reader :size_min, :size_max, :precision, :unit, :threshold, :limit, :sort, :order, :style, :separator

    def initialize(name, params, tokens)
      # initialize default values
      @size_min, @size_max, @precision, @unit = 70, 170, 0, '%'
      @threshold                              = 1
      @limit                                  = 0
      @sort, @order                           = 'alpha', 'asc'
      @order = 'desc' if @sort == 'freq'
      @style, @tag_before, @tag_after, @separator = 'list', '<li>', '</li>', ', '

      # process parameters
      @params = Hash[*params.split(/(?:: *)|(?:, *)/)]
      process_font_size(@params['font-size'])
      process_threshold(@params['threshold'])
      process_limit(@params['limit'])
      process_sort(@params['sort'])
      process_style(@params['style'])

      super
    end

    def render(context)
      # get the directory for the tag links
      dir = context.registers[:site].config['tag_dir'] || 'tags'

      # get an Array of [tag name, tag count] pairs
      count = context.registers[:site].tags.map do |name, posts|
        [name, posts.count] if posts.count >= threshold
      end

      # clear nils if any
      count.compact!

      # get the minimum, and maximum tag count
      min, max = count.map(&:last).minmax

      # map: [[tag name, tag count]] -> [[tag name, tag weight]]
      weighted = count.map do |name, count|
        # logarithmic distribution
        weight = (Math.log(count) - Math.log(min))/(Math.log(max) - Math.log(min))
        [name, weight]
      end

      # get the top @limit tag pairs when a limit is given, unless the sort method is random
      if @limit > 0 and @sort != 'rand'
        # sort the tag pairs by frequency in descending order
        weighted.sort! { |a,b| b[1] <=> a[1] }

        # then slice off the top @limit tag pairs
        weighted = weighted[0,@limit]
      end

      # sort the [tag name, tag weight] pairs
      case @sort
      when 'freq'
        if @order == 'asc'
          # sorts from least to most frequent
          weighted.sort! { |a,b| a[1] <=> b[1] }
        elsif @limit == 0
          # otherwise, sort from the most to least frequent
          weighted.sort! { |a,b| b[1] <=> a[1] }
        end
      when 'rand'
        weighted.sort_by! { rand }

        if @limit > 0
          # slice off the top @limit tag pairs
          weighted = weighted[0,@limit]
        end
      else
        if @order == 'desc'
          # sorts in reverse alphabetical order, i.e z to a
          weighted.sort! { |a,b| b <=> a }
        else
          # otherwise, sorts in alphabetical order, i.e a to z
          weighted.sort! { |a,b| a <=> b }
        end
      end

      html = ""

      # iterate over the weighted tag Array and create the tag items
      weighted.each_with_index do |tag, i|
        name, weight = tag
        size = size_min + ((size_max - size_min) * weight).to_f
        size = sprintf("%.#{@precision}f", size)
        slug = name.to_url
        @separator = "" if i == (weighted.size - 1)
        html << "#{@tag_before}<a style=\"font-size: #{size}#{unit}\" href=\"/#{dir}/#{slug}/\">#{name}</a>#{@separator}#{@tag_after}\n"
      end

      html
    end

    private

    def process_font_size(param)
      /(\d*\.{0,1}(\d*)) *- *(\d*\.{0,1}(\d*)) *(%|em|px)/.match(param) do |m|
        @size_min  = m[1].to_f
        @size_max  = m[3].to_f
        @precision = [m[2].size, m[4].size].max
        @unit      = m[5]
      end
    end

    def process_threshold(param)
      /\d*/.match(param) do |m|
        @threshold = m[0].to_i
      end
    end

    def process_limit(param)
      /\d*/.match(param) do |m|
        @limit = m[0].to_i
      end
    end

    def process_sort(param)
      /(freq|rand|alpha) *(asc|desc)?/.match(param) do |m|
        @sort  = m[1]
        @order = m[2]
      end
    end

    def process_style(param)
      /(list|para) *({(.*)})?/.match(param) do |m|
        @style     = m[1]
        @separator = m[3]
      end

      @tag_before = @tag_after = "" if @style == "para"
      @separator = "" if @style == "list"
    end

  end

  class CategoryList < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      @opts = {}
      if markup.strip =~ /\s*counter:(\w+)/iu
        @opts['counter'] = $1
        markup = markup.strip.sub(/counter:\w+/iu,'')
      end
      super
    end

    def render(context)
      html = ""
      config = context.registers[:site].config
      category_dir = config['root'] + config['category_dir'] + '/'
      categories = context.registers[:site].categories
      categories.keys.sort_by{ |str| str.downcase }.each do |category|
        url = category_dir + category.gsub(/_|\P{Word}/u, '-').gsub(/-{2,}/u, '-').downcase
        html << "<li><a href='#{url}'>#{category.capitalize}"
        if @opts['counter']
          html << " (#{categories[category].count})"
        end
        html << "</a></li>"
      end
      html
    end
  end
end

Liquid::Template.register_tag('tag_cloud', Jekyll::TagCloud)
Liquid::Template.register_tag('category_list', Jekyll::CategoryList)
