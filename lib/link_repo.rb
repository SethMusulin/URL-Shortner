class LinkRepo

  def initialize
    @links = []
  end

  def links
    @links
  end

  def add(link)
    url_link_data = {:url_to_redirect_to => link,:id => (@links.count) + 1 }
    @links << url_link_data
  end

end