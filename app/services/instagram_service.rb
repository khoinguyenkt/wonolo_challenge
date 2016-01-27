class InstagramService

  def media_search params
    lat = params[:lat]
    lng = params[:lng]

    if lat.present? && lng.present?
      distance = params[:radius].to_i*1000 || 1000
      results = Instagram.media_search(lat,lng, {distance: distance})
      Kaminari.paginate_array(results).page(params[:page]).per(PER_PAGE)
    else
      []
    end
  end
end