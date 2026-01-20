module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    size = options[:size]
    
    # アバターが設定されていればそれを使う
    if user.avatar.attached?
      image_tag user.avatar.variant(resize_to_limit: [size, size]), 
                alt: user.name, 
                class: "gravatar",
                style: "width: #{size}px; height: #{size}px; object-fit: cover;"
    else
      # なければGravatarを使う
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
  end
end