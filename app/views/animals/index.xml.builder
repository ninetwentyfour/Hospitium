xml.instruct! :xml, :version=>"1.0"

xml.animals do
  @animals.each do |animal|
    xml.animal do
      xml.name animal.name
      xml.status animal.status.status
      xml.species_name animal.species_name
      xml.sex animal.sex
      xml.age calculate_animal_age(animal.birthday)
      xml.spay_neuter animal.spay
      xml.color animal.color
      xml.special_needs animal.special_needs
      xml.organization animal.organization_name
      xml.image_1 animal.image.url(:medium)
      xml.image_2 animal.second_image.url(:medium)
      xml.image_3 animal.third_image.url(:medium)
      xml.image_4 animal.fourth_image.url(:medium)
    end
  end
end