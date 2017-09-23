module OwnershipsHelper
  def options_for_apps(user)
    user.apps.map {|a| [a.name, "App-#{a.id}"]}
  end
end
