module ApplicationHelper
  def get_url_user username
    "#{INSTAGRAM_URL}#{username}"
  end

  [:lat, :lng].each do |value|
    define_method("get_#{value}_value") do
      params[value].present? ? params[value] : POSITION[value]
    end
  end
end
