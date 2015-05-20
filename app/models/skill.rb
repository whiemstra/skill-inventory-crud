class Skill
  attr_reader :id,
              :name,
              :description

  def initialize(data)
    @id          = data["id"]
    @name        = data["name"]
    @description = data["description"]
  end

end
