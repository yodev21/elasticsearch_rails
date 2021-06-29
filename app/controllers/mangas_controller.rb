class MangasController < ApplicationController
  def index
    # @mangas = if query.present?
    #             # Manga.search(query).records
    #             Manga.search(query)
    #             exit
    #           else
    #             Manga.search({})
    #           end
    @mangas = query.present? ? Manga.search(query).records : Manga.search({})
    exit if query.present? && @mangas.first
  end

  private

  def query
    @query ||= params[:query]
  end

  def page_number
    [params[:page].to_i, 1].max
  end
end
