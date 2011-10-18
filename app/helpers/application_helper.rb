module ApplicationHelper
  
    def calculate_animal_age(birthday)
      age = (Time.now.year - birthday.year).to_s + " years"
      if age == "0 years"
        age = (Time.now.month - birthday.month).to_s + " months"
        if age == "0 months"
          age = (Time.now.day - birthday.day).to_s + " days"
        end
      end
      return age
    end
    
end
