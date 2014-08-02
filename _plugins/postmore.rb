module PostMore
  def postmorefilter(input, url, text)
    if input.include? "<!-- more -->"  # upline and downline
      input.split("<!-- more -->").first + "<p class='more'><a href='#{url}'>#{text}</a></p>"
    else
      input
    end
  end
end

Liquid::Template.register_filter(PostMore)
