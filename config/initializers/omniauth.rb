Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'cxjXuVAQwYtclpugaNq7wA', 'tWnjikJiGyyowmBYZCeq3aXRB13LCZp4QXiFQEZk'
  provider :facebook, '364764130215064', 'cf464cc6b2fdbc8472f353c1ef74ba94', :scope => 'publish_stream,email,offline_access,manage_pages'
end