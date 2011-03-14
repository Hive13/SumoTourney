module HackerspacesHelper

  def show_external_link(url)
     link = url
     link = "http://#{url}" if not link=~/^http/
     return link
  end
end
