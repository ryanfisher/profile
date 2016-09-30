module PostsHelper
  def markdown(text)
    Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true),
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      lax_html_blocks: true
    ).render(text).html_safe
  end
end
