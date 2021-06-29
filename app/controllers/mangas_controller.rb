class MangasController < ApplicationController
  def index
    @mangas = if query.present?
                Manga.search(query).records
              else
                Manga.all
              end
  end

  private

  def query
    @query ||= params[:query]
  end

  def page_number
    [params[:page].to_i, 1].max
  end
end
