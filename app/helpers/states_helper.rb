module StatesHelper
  def options_for_states
    State::ALLOWED_STATUSES.map{|s| [s.titleize, s]}
  end
end
