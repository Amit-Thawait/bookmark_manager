class AutoCompleter
  def initialize(app)
    @app = app
  end

  def call(env)
    @request = Rack::Request.new(env)
    if env["PATH_INFO"] == "/tags_autocomplete"
      session = @request.env['rack.session']
      params = @request.params
      if true # TODO: session && session["user_id"].present?
        tags = Tag.select("id, name").where("name like ?", "#{params['q']}%")
        [200, {"Content-Type" => "application/json"}, [tags.to_json]]
      else
       [404, {"Content-Type" => "text/html"}, ["Not Found"]]
      end
    else
      @app.call(env)
    end
  end
end