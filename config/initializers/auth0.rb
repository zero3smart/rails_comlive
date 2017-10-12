Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'HHhljqdUGsPy4843Uoxy0i1A5wSzN5up',
    'nT8AW3XioyQ1k30R4H-tKjqukKYhM1QXgOu0HrVu3qRvy__VZI6-C3fImTa17Gv5',
    'ntty.eu.auth0.com',
    callback_path: "/auth/auth0/callback"
  )
end