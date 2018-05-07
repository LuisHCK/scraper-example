class Api::V1::PagesController < ApplicationController
  # Inclide Middleware to allow Ruby's "open" method
  # get a html document from url
  require 'open-uri'
  
  # POST api/v1/pages
  def create
    # Initialize new Page Instance
    @page = Page.new()

    # Get and store document from url param
    html_doc = get_page(params[:url])

    # Read the html document and get required tags
    html_doc.css('a, h1, h2, h3').each do |tag|
      # Create relationship with the tag found
      @page.tags << Tag.new(page_payload(tag))
    end

    # Save page meta-data
    @page.title = html_doc.css('title')[0].text if html_doc.css('title').try(:any?)
    @page.description = html_doc.at('meta[name=description]')['content'] if html_doc.at('meta[name=description]').try(:any?)
    @page.url = params[:url]

    if @page.save
      # Serialize the new Page using jsonapi serializer
      resource =  Api::V1::PageResource
      render json: JSONAPI::ResourceSerializer.new(resource)
      .serialize_to_hash(resource.new(@page, nil))
    else
      # When page fails to save, returns the errors to be fixed
      render json: @page.errors, status: 422
    end
  end

  private

  # Use Nokogiri to parse a HTML page from an URL
  #==== Attributes
  # - url: URL of the web page
  def get_page(url)
    # If Nokogiri can't get the url stop the execution
    # and return a message to client
    begin
      Nokogiri::HTML(open(params[:url]))
    rescue => exception
      return render json: {errors: exception.message}, status: 422
    end
  end

  # Build a Paylad for each case
  #==== Attributes
  # - tag: Tag instance from HTML document
  def page_payload(tag)
    # Define params to save in tags Model
    payload = {}
    if tag.name == 'a'
      # When a link tag id found, store the "href" insted text
      payload = {
        name: tag.name,
        content: tag['href']
      }
    else
      # Default payload for h1, h2 and h3 tags
      payload = {
        name: tag.name,
        content: tag.text
      }
    end
    return payload
  end

end
