require 'yaml/store'
require_relative 'skill'

class SkillInventory

  def self.database
    @database ||= YAML::Store.new("db/skill_inventory")
  end

  def self.create(new_skill)
    database.transaction do
      database['skills'] ||= []
      database['total'] ||= 0
      database['total'] +=1
      database['skills'] << { "id" => database['total'], "name" => new_skill[:name], "description" => new_skill[:description]}
    end
  end

  def self.all_skills
    database.transaction do
      database['skills'] || []
    end
  end

  def self.all
    all_skills.map { |skill| Skill.new(skill)}
  end

  def self.single_skill(id)
    all_skills.find { |skill| skill["id"] == id }
  end

  def self.find(id)
    Skill.new(single_skill(id))
  end

   def self.update(id, data)
     database.transaction do
       target_skill = database['skills'].find { |skill| skill['id'] == id }
       target_skill['name'] = data[:name]
       target_skill['description'] = data[:description]
     end
   end

  def self.delete(id)
    database.transaction do
      database['skills'].delete_if { |skill| skill['id'] == id }
    end
  end
end
