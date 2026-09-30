module ApplicationHelper
  def profile
    @profile ||= Profile.current
  end

  def page_title(title)
    content_for(:title, title)
  end

  # Opens in a new tab, without giving the other site access to this one
  def external_link_to(name, url, **options)
    link_to(name, url, target: "_blank", rel: "noopener", **options)
  end

  # Marks the current page's nav link so screen readers and CSS can tell
  def nav_link_to(name, path)
    link_to(name, path, "aria-current": (current_page?(path) ? "page" : nil))
  end

  def mail_link(email = profile[:email])
    mail_to(email, email)
  end
end
