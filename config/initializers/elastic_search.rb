if Rails.env == "production"
  Elasticsearch::Model.client = Elasticsearch::Client.new(
      url:  ENV['BONSAI_URL'],
      log: true
  )
  ENV['ELASTICSEARCH_URL'] = ENV['BONSAI_URL']
end