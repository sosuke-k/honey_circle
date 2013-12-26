Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "jEqjd7VryKlCbrPXDFRbQ", "VIm4modvD7ouVYluFzyQ0zawace1OvHWvMu24Mg",
  { :secure_image_url => 'true'}
end