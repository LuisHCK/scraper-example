class Api::V1::PageResource < JSONAPI::Resource
  attributes :title, :description, :tags

  # Filter and return a structured objec with tags
  def tags
    {
      h1: @model.tags.select{|tag| tag.name == 'h1'}.as_json(),
      h2: @model.tags.select{|tag| tag.name == 'h2'}.as_json(),
      h3: @model.tags.select{|tag| tag.name == 'h3'}.as_json(),
      links: @model.tags.select{|tag| tag.name == 'a'}.as_json(),
    }
  end
end
