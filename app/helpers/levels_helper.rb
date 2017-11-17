module LevelsHelper
  def levels_for(classification)
    classification.levels.map{|l| [l.name, l.id]}
  end
end